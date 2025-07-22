import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _fullNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  File? _selectedProfileImage;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();

    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage == null) return;

      setState(() => _selectedProfileImage = File(pickedImage.path));
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<void> _setLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void _handleSignUp() async {
    if (!_signUpFormKey.currentState!.validate()) {
      _showSnackBar('Please fill in the required fields');

      return;
    }

    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(seconds: 2));
    await _setLoginStatus(true);

    if (!mounted) return;

    setState(() => _isSubmitting = false);
    Navigator.pushNamed(context, '/');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 20.0),
                _buildSignUpForm(theme),
                const SizedBox(height: 20.0),
                _buildSignInPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: const [
        Text(
          'Create an Account',
          style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5.0),
        Text('Sign up to get started', style: TextStyle(fontSize: 18.0)),
      ],
    );
  }

  Widget _buildSignUpForm(ThemeData theme) {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          _buildProfileImagePicker(theme),
          const SizedBox(height: 20.0),
          _buildFullNameField(),
          const SizedBox(height: 20.0),
          _buildEmailField(),
          const SizedBox(height: 20.0),
          _buildPasswordField(),
          const SizedBox(height: 20.0),
          _buildConfirmPasswordField(),
          const SizedBox(height: 20.0),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker(ThemeData theme) {
    return InkWell(
      onTap: !_isSubmitting ? _pickProfileImage : null,
      borderRadius: BorderRadius.circular(50.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              image:
                  _selectedProfileImage != null
                      ? DecorationImage(
                        image: FileImage(_selectedProfileImage!),
                        fit: BoxFit.cover,
                      )
                      : null,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child:
                _selectedProfileImage == null
                    ? Icon(
                      Icons.camera_alt_outlined,
                      size: 40.0,
                      color: theme.colorScheme.onSurface,
                    )
                    : null,
          ),
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Icon(
              Icons.add,
              size: 20.0,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
      controller: _fullNameTextController,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(labelText: 'Full Name'),
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Full Name is required' : null,
      enabled: !_isSubmitting,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailTextController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      enabled: !_isSubmitting,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordTextController,
      obscureText: !_isPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed:
              () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      enabled: !_isSubmitting,
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordTextController,
      obscureText: !_isConfirmPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed:
              () => setState(
                () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
              ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm Password is required';
        }
        if (_passwordTextController.text != value) {
          return 'Passwords do not match';
        }
        return null;
      },
      enabled: !_isSubmitting,
    );
  }

  Widget _buildSignUpButton() {
    return FilledButton(
      onPressed: !_isSubmitting ? _handleSignUp : null,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size(double.infinity, 0),
      ),
      child:
          _isSubmitting
              ? const SizedBox(
                height: 21.0,
                width: 21.0,
                child: CircularProgressIndicator(strokeWidth: 3.0),
              )
              : const Text(
                'Sign Up',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
    );
  }

  Widget _buildSignInPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: !_isSubmitting ? () => Navigator.of(context).pop() : null,
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}
