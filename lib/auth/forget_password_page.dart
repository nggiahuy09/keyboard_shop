import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/auth/login_page.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_error_text.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_input_textfield.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_loading_widget.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  bool _isValidEmail = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPW() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();

    !email.contains('@') ? _isValidEmail = false : _isValidEmail = true;

    if (_isValidEmail) {
      try {
        setState(() {
          _isLoading = false;
        });

        await authInstance.sendPasswordResetEmail(email: email);
        
        Utils.showToast(msg: 'Send Email to Reset Password');
      } on FirebaseAuthException catch (err) {
        if (mounted) {
          Utils.showSnackBar(context, msg: err.message!);
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const LoginPage();
              },
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: CusLoadingWidget(
        isLoading: _isLoading,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CusInputTextField(
                    editingController: _emailController,
                    hintText: 'Email Address',
                  ),
                  if (!_isValidEmail)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: CusErrorText(text: 'Your Email must contains @'),
                    ),
                  const SizedBox(height: 40),
                  CusMaterialButton(
                    content: 'Reset',
                    fontSizeContent: 20,
                    onTap: _resetPW,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
