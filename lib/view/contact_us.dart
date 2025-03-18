import 'package:flutter/material.dart';
import 'package:nex2u/models/resources/create_message.dart';
import 'package:nex2u/viewModel/contact_view_model.dart';
import 'package:provider/provider.dart';

import '../res/validation_alert.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() {}

  @override
  Widget build(BuildContext context) {
    final createProvider = Provider.of<ContactViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// Full Name Field
                const SizedBox(height: 30),
                buildTextField(
                  "Full Name",
                  "Enter your full name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Full Name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                /// Message Field
                buildTextField(
                  "Send Message",
                  "Type your message",
                  controller: _messageController,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Message is required";
                    }
                    return null;
                  },
                  maxLines: 5,
                ),

                const SizedBox(height: 30),

                /// Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8280FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        CreateMessage request = CreateMessage(
                          message: _messageController.text,
                        );

                        await createProvider.createmessage(request, context);
                        if (createProvider.otpSent) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (!context.mounted) return;
                            _showSuccessDialog("Submitted", context);
                          });
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Reusable buildTextField Function
  Widget buildTextField(
    String label,
    String hint, {
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    void Function()? onTap,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        ),
        onTap: onTap,
        validator: validator,
      ),
    );
  }

  void _showSuccessDialog(String message, BuildContext context) {
    ValidationIoSAlert().showAlert(context,
        description: message,
        flag: true); // Implement your success dialog or snackbar here
    debugPrint(message); // or use showDialog, showSnackBar, etc.
  }
}
