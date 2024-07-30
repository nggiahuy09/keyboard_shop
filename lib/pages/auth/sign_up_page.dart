import 'package:flutter/material.dart';
import 'package:keyboard_shop/pages/auth/login_page.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_error_text.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_input_textfield.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPWController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isShowPassword = false;
  bool _isShowConfirmPW = false;
  bool _isValidEmail = true;
  bool _isValidPassword = true;
  bool _isValidConfirmPW = true;
  bool _isValidAddress = true;
  bool _isValidUsername = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPWController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();
    final confirmPW = _confirmPWController.text.trim();
    final address = _addressController.text.trim();

    setState(() {
      !email.contains('@') ? _isValidEmail = false : _isValidEmail = true;
      password.length < 8 ? _isValidPassword = false : _isValidPassword = true;
      username.isEmpty ? _isValidUsername = false : _isValidUsername = true;
      confirmPW != password ? _isValidConfirmPW = false : _isValidConfirmPW = true;
      address.isEmpty ? _isValidAddress = false : _isValidAddress = true;
    });

    final canSignUp = _isValidAddress && _isValidConfirmPW && _isValidUsername && _isValidEmail && _isValidPassword;
    if (canSignUp) {
      // todo: do something in here
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      //   return const MyBottomBarPage();
      // }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Utils(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeaderSignUp(),

                  const SizedBox(height: 72),
                  CusInputTextField(
                    editingController: _usernameController,
                    hintText: 'Username',
                  ),
                  if (!_isValidUsername)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: CusErrorText(text: 'Username cannot be empty'),
                    ),
                  const SizedBox(height: 8),
                  CusInputTextField(
                    editingController: _emailController,
                    hintText: 'Email',
                  ),
                  if (!_isValidEmail)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: CusErrorText(text: 'Email must be contain @'),
                    ),
                  const SizedBox(height: 8),
                  CusInputTextField(
                    editingController: _passwordController,
                    hintText: 'Password',
                    obscureText: !_isShowPassword,
                    suffix: IconButton(
                      onPressed: () => setState(() {
                        _isShowPassword = !_isShowPassword;
                      }),
                      icon: _isShowPassword
                          ? Icon(
                              Icons.visibility_off,
                              color: Utils(context).primaryColor,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Utils(context).primaryColor,
                            ),
                    ),
                  ),
                  if (!_isValidPassword)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: CusErrorText(text: 'Password must be at least 8 characters'),
                    ),
                  const SizedBox(height: 8),
                  CusInputTextField(
                    editingController: _confirmPWController,
                    hintText: 'Confirm your password',
                    obscureText: !_isShowConfirmPW,
                    suffix: IconButton(
                      onPressed: () => setState(() {
                        _isShowConfirmPW = !_isShowConfirmPW;
                      }),
                      icon: _isShowConfirmPW
                          ? Icon(
                              Icons.visibility_off,
                              color: Utils(context).primaryColor,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Utils(context).primaryColor,
                            ),
                    ),
                  ),
                  if (!_isValidConfirmPW)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: CusErrorText(text: 'Confirm Password is incorrect'),
                    ),
                  const SizedBox(height: 8),
                  CusInputTextField(
                    editingController: _addressController,
                    hintText: 'Address',
                  ),
                  if (!_isValidAddress)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: CusErrorText(text: 'Address cannot be empty'),
                    ),
                  const SizedBox(height: 40),
                  CusMaterialButton(
                    content: 'Sign Up',
                    height: 56,
                    fontSizeContent: 20,
                    onTap: _signUp,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Already a user?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage())),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 18,
                            color: Utils(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSignUp extends StatelessWidget {
  const _HeaderSignUp();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/app_icon.png',
          height: 72,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, my bro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Utils(context).primaryColor,
              ),
            ),
            Text(
              'Create your account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Utils(context).primaryColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}

