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

  File? _profileImage;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showPassword1 = false;
  bool _showPassword2 = false;

  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      setState(() => _profileImage = File(image.path));
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<void> _saveLogInStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void _simulateRegister() {
    if (!_signUpFormKey.currentState!.validate()) {
      _showSnackBar('Please fill in the required fields');

      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      _saveLogInStatus(true);

      if (!mounted) return;

      Navigator.pushNamed(context, '/');
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(),
                const SizedBox(height: 20.0),
                _buildSignUpForm(),
                const SizedBox(height: 20.0),
                _buildSignInPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: const [
        Text(
          'Create an Account',
          style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.0),
        Text(
          'Sign up to get started',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          _buildProfileImagePicker(),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _fullNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(labelText: 'Full Name'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Full Name is required'
                        : null,
            enabled: !_isLoading,
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!EmailValidator.validate(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            enabled: !_isLoading,
          ),
          const SizedBox(height: 20.0),
          _buildPasswordField(
            controller: _passwordController,
            label: 'Password',
            showPassword: _showPassword1,
            toggleShowPassword: () {
              setState(() {
                _showPassword1 = !_showPassword1;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          _buildPasswordField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            showPassword: _showPassword2,
            toggleShowPassword: () {
              setState(() {
                _showPassword2 = !_showPassword2;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm Password is required';
              }
              if (_passwordController.text != value) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return InkWell(
      onTap: !_isLoading ? _pickProfileImage : null,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              image:
                  _profileImage != null
                      ? DecorationImage(
                        image: FileImage(_profileImage!),
                        fit: BoxFit.cover,
                      )
                      : null,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child:
                _profileImage == null
                    ? Icon(
                      Icons.camera_alt_outlined,
                      size: 40.0,
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                    : null,
          ),
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Icon(
              Icons.add,
              size: 20.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool showPassword,
    required VoidCallback toggleShowPassword,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !showPassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            showPassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: toggleShowPassword,
        ),
      ),
      validator: validator,
      enabled: !_isLoading,
    );
  }

  Widget _buildSignInButton() {
    return TextButton(
      onPressed: !_isLoading ? _simulateRegister : null,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size(double.infinity, 0),
      ),
      child:
          _isLoading
              ? SizedBox(
                height: 21.0,
                width: 21.0,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  strokeWidth: 3.0,
                ),
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
          onPressed: !_isLoading ? () => Navigator.of(context).pop() : null,
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}
