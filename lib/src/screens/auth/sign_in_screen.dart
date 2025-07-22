import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }

  Future<void> _setLoginStatus({required bool isLoggedIn}) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void habdleSignIn() async {
    if (!_signInFormKey.currentState!.validate()) {
      _showSnackBar('Please fill in the required fields');

      return;
    }

    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(seconds: 2));
    await _setLoginStatus(isLoggedIn: true);

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildHeader(),
              const SizedBox(height: 20.0),
              _buildSignInForm(),
              const SizedBox(height: 20.0),
              _buildSignUpPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Welcome Back!',
      style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: <Widget>[
          _buildEmailField(),
          const SizedBox(height: 20.0),
          _buildPasswordField(),
          const SizedBox(height: 20.0),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailTextController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
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
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: !_isPasswordVisible,
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

  Widget _buildSignInButton() {
    return FilledButton(
      onPressed: !_isSubmitting ? habdleSignIn : null,
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
                'Sign In',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed:
              !_isSubmitting
                  ? () => Navigator.pushNamed(context, '/sign-up')
                  : null,
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}
