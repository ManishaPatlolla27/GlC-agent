import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../models/createAlert/create_alert_request.dart';
import '../res/validation_alert.dart';
import '../viewModel/create_alert_view_model.dart';

class BuyerAlertScreen extends StatefulWidget {
  const BuyerAlertScreen({super.key});
  @override
  BuyerAlertScreenState createState() => BuyerAlertScreenState();
}

class BuyerAlertScreenState extends State<BuyerAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  FlutterSecureStorage storage = FlutterSecureStorage(); // Initialize once
  String? farmid = "";

  // TextEditingControllers for each input field
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  String? selectedReligion;
  String? selectedGender;

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      farmid = await storage.read(key: "farmid");
      setState(() {}); // Update the UI after retrieving the farm ID
    });
  }

  @override
  Widget build(BuildContext context) {
    final createProvider = Provider.of<CreateAlertViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Farmland Buyer Alert',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  "Please share the land buyer details.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                buildTextField("First Name", "Enter First Name",
                    controller: _firstNameController, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "First Name is required";
                  }
                  if (value.length < 2) return "Enter at least 2 characters";
                  return null;
                }),
                buildTextField("Last Name", "Enter Last Name",
                    controller: _lastNameController, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Last Name is required";
                  }
                  return null;
                }),
                buildTextField("Phone Number", "Enter Phone Number",
                    controller: _phoneController,
                    keyboardType: TextInputType.phone, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone Number is required";
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return "Enter a valid 10-digit number";
                  }
                  return null;
                }),
                buildTextField("Email", "Enter Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                }),
                buildDropdownField(
                    "Religion",
                    ["Hindu", "Muslim", "Christian", "Other"],
                    (value) => setState(() => selectedReligion = value),
                    validator: (value) =>
                        value == null ? "Religion is required" : null),
                buildDropdownField("Gender", ["Male", "Female", "Other"],
                    (value) => setState(() => selectedGender = value),
                    validator: (value) =>
                        value == null ? "Gender is required" : null),
                buildTextField("Cost", "Enter Cost of Land",
                    controller: _costController,
                    keyboardType: TextInputType.number, validator: (value) {
                  if (value == null || value.isEmpty) return "Cost is required";
                  if (double.tryParse(value) == null) {
                    return "Enter a valid amount";
                  }
                  return null;
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the button
                  children: [
                    SizedBox(
                      width: 150, // Adjust the width as needed
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String genderInitial = selectedGender != null
                                ? selectedGender![0]
                                : "";
                            CreateAlertRequest request = CreateAlertRequest(
                                farmlandId: farmid,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                contactNumber: _phoneController.text,
                                contactMail: _emailController.text,
                                religion: selectedReligion,
                                gender: genderInitial,
                                landCost: _costController.text);

                            await createProvider.createBuyerAlert(
                                request, context);
                            if (createProvider.otpSent) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                if (!context.mounted) return;
                                _showSuccessDialog("Lead Submitted", context);
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8280FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: const Text("Submit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint,
      {TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
      ),
    );
  }

  Widget buildDropdownField(
      String label, List<String> options, Function(String?) onChanged,
      {String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
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
