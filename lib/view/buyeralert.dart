import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class BuyerAlertScreen extends StatefulWidget {
  const BuyerAlertScreen({super.key});
  @override
  BuyerAlertScreenState createState() => BuyerAlertScreenState();
}

class BuyerAlertScreenState extends State<BuyerAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedReligion;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
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
                    validator: (value) {
                  if (value == null || value.isEmpty)
                    return "First Name is required";
                  if (value.length < 2) return "Enter at least 2 characters";
                  return null;
                }),
                buildTextField("Last Name", "Enter Last Name",
                    validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Last Name is required";
                  return null;
                }),
                buildTextField("Phone Number", "Enter Phone Number",
                    keyboardType: TextInputType.phone, validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Phone Number is required";
                  if (!RegExp(r'^\d{10}\$').hasMatch(value))
                    return "Enter a valid 10-digit number";
                  return null;
                }),
                buildTextField("Email", "Enter Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Email is required";
                  if (!EmailValidator.validate(value))
                    return "Enter a valid email";
                  return null;
                }),
                buildDropdownField(
                    "Religion", ["Hindu", "Muslim", "Christian", "Other"],
                    (value) {
                  setState(() => selectedReligion = value);
                },
                    validator: (value) =>
                        value == null ? "Religion is required" : null),
                buildDropdownField("Gender", ["Male", "Female", "Other"],
                    (value) {
                  setState(() => selectedGender = value);
                },
                    validator: (value) =>
                        value == null ? "Gender is required" : null),
                buildTextField("Cost", "Enter Cost of Land",
                    keyboardType: TextInputType.number, validator: (value) {
                  if (value == null || value.isEmpty) return "Cost is required";
                  if (double.tryParse(value) == null)
                    return "Enter a valid amount";
                  return null;
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit action
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8280FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
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
}
