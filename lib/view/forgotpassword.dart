import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nex2u/viewModel/forgot_password_view_model.dart';
import 'package:provider/provider.dart';

import '../page_routing/app_routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final loginProvider =
            Provider.of<ForgotPasswordScreen>(context, listen: false);
      },
    );
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
                      ], // Replace with your desired colors
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/loginbg.svg', // Replace with your SVG file path
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/logo.png',
                      height: 90,
                    ), // Logo overlaid on the login frame
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome to Green Land Capital",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 120),

                    // Moved "Sign in to your Account" Below "Welcome"
                    Container(
                      width: double.infinity, // Makes it span the full width
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      alignment:
                          Alignment.centerLeft, // Aligns text to the left
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Left-align text
                        children: [
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      "Please enter your Registered Email Id",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!RegExp(
                          r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
                        ).hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 150),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7B69EE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await forgotProvider
                                .requestOtp(_emailController.text);

                            if (forgotProvider.otpSent) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                if (!context.mounted) return;
                                Navigator.pushNamed(
                                    context, AppRoutes.validate);
                              });
                            }
                          }
                        },
                        child: const Text(
                          "Send Code",
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
