import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nex2u/viewModel/forgot_password_view_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../page_routing/app_routes.dart';

class ValidateOtpScreen extends StatefulWidget {
  const ValidateOtpScreen({super.key});

  @override
  State<ValidateOtpScreen> createState() => _ValidateOtpScreenState();
}

class _ValidateOtpScreenState extends State<ValidateOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool isButtonEnabled = false; // Initially disabled

  @override
  void initState() {
    super.initState();
    _otpController.addListener(() {
      setState(() {
        isButtonEnabled = _otpController.text.length == 5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final forgotProvider = Provider.of<ForgotPasswordViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section: Login Frame with Logo
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 420,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8280FF),
                        Color(0xFF8280FF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/loginbg.svg',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset('assets/logo.png', height: 90),
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome to Green Land Capital",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 120),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Validate OTP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Please enter the code received to your\nRegistered Mail",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // OTP Field
                    PinCodeTextField(
                      appContext: context,
                      controller: _otpController,
                      length: 5,
                      obscureText: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        inactiveColor: const Color(0xFF7B69EE),
                        activeColor: const Color(0xFF7B69EE),
                        selectedColor: const Color(0xFF7B69EE),
                        fieldWidth: 50,
                        fieldHeight: 50,
                      ),
                      cursorColor: Colors.white,
                      animationDuration: const Duration(milliseconds: 300),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          isButtonEnabled = value.length == 5;
                        });
                      },
                    ),

                    const SizedBox(height: 150),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled
                              ? const Color(0xFF7B69EE)
                              : Colors.grey, // Disabled color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: isButtonEnabled
                            ? () async {
                                // Handle OTP validation
                                // await forgotProvider
                                //     .validateOtp(_otpController.text);

                                Navigator.pushNamed(
                                    context, AppRoutes.password);
                              }
                            : null, // Disable button if OTP is not 5 digits
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
