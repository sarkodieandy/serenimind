import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({super.key});

  @override
  State<SignInSignUpScreen> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  var _hasRequestedOtp = false;
  bool isButtonEnabled = false;

  void _onChanged(String value) {
    setState(() {
      isButtonEnabled = value.length == 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading:
            _hasRequestedOtp
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _hasRequestedOtp = false;
                      _otpController.clear();
                    });
                  },
                )
                : null,
        title: Row(
          children: [
            const SizedBox(width: 40),
            const Icon(Icons.waves, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Serenimind',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            32.0,
            0,
            32.0,
            MediaQuery.of(context).viewInsets.bottom + 32.0,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight -
                  MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _hasRequestedOtp
                    ? _buildOtpVerificationView()
                    : _buildInitialView,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildInitialView {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        SvgPicture.asset(
          'assets/images/login.svg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 50),
        DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF6C5CE7),
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText(
                '◦ Track your mindfulness journey',
                speed: Duration(milliseconds: 100),
              ),
              TyperAnimatedText(
                '◦ Never lose your meditation progress',
                speed: Duration(milliseconds: 100),
                textAlign: TextAlign.center,
              ),
              TyperAnimatedText(
                '◦ Build a lasting meditation practice 💜',
                speed: Duration(milliseconds: 100),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
        const Text(
          "We'll send you a code by email to verify your account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          style: const TextStyle(color: Color(0xFF6C5CE7)),
          decoration: InputDecoration().copyWith(hintText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _hasRequestedOtp = true;
            });
          },

          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'By continuing, you agree to our ',
                    style: TextStyle(fontSize: 12),
                  ),
                  TextSpan(
                    text: 'Terms of Service',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xFF6C5CE7),
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            // TODO: Handle Terms of Service tap
                          },
                  ),
                  const TextSpan(text: ' and ', style: TextStyle(fontSize: 12)),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xFF6C5CE7),
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            // TODO: Handle Privacy Policy tap
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox.square(dimension: 100),
      ],
    );
  }

  Widget _buildOtpVerificationView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/otp.svg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 32),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Enter the code we just sent to ',
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.normal,
                ),
              ),
              TextSpan(
                text: _emailController.text,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),

        TextField(
          controller: _otpController,
          maxLength: 6,
          keyboardType: TextInputType.number,
          onChanged: _onChanged,
          style: const TextStyle(color: const Color(0xFF6C5CE7), fontSize: 20),
          decoration: InputDecoration().copyWith(
            hintText: 'Enter verification code',
          ),
        ),

        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          // isButtonEnabled
          //     ? () {
          //       // TODO: Handle OTP verification
          //     }
          //     : null,
          child: const Text('Continue', style: TextStyle(fontSize: 16)),
        ),

        const SizedBox(height: 20),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 32),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Resend OTP',
            style: TextStyle(color: Color(0xFF6C5CE7), fontSize: 14),
          ),
        ),
      ],
    );
  }
}
