import 'package:flutter/material.dart';
import 'package:keyboard_shop/auth/forget_password_page.dart';
import 'package:keyboard_shop/auth/sign_up_page.dart';
import 'package:keyboard_shop/pages/bottom_bar_page.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_error_text.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_input_textfield.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isValidEmail = true;
  bool _isValidPassword = true;
  bool _isShowPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      !email.contains('@') ? _isValidEmail = false : _isValidEmail = true;
      password.length < 8 ? _isValidPassword = false : _isValidPassword = true;
    });

    if (_isValidPassword && _isValidEmail) {
      // todo: do something in here
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const MyBottomBarPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeaderLogin(),
                const SizedBox(height: 72),
                CusInputTextField(
                  editingController: _emailController,
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                ),
                if (!_isValidEmail)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: CusErrorText(text: 'Your Email must contains @'),
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
                    child: CusErrorText(text: 'Your Password must at least 8 characters'),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgetPasswordPage(),
                        ),
                      ),
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                CusMaterialButton(
                  content: 'Sign In',
                  height: 56,
                  fontSizeContent: 20,
                  onTap: _signIn,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: MaterialButton(
                        height: 48,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Utils(context).primaryColor,
                        onPressed: () {},
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/google_icon.png',
                              height: 40,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Google',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: CusMaterialButtonAccent(
                        content: 'Guest',
                        height: 48,
                        fontSizeContent: 18,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      ),
                      child: Text(
                        'Sign up',
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
        ),
      ),
    );
  }
}

class _HeaderLogin extends StatelessWidget {
  const _HeaderLogin();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/app_icon.png',
          height: 88,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Utils(context).primaryColor,
              ),
            ),
            Text(
              'Sign in to continue',
              style: TextStyle(
                fontSize: 22,
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
