import 'package:flutter/material.dart';

class BuyerAlertScreen extends StatefulWidget {
  const BuyerAlertScreen({super.key});
  @override
  CreateAlertScreenState createState() => CreateAlertScreenState();
}

class CreateAlertScreenState extends State<BuyerAlertScreen> {
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
          color: Colors.white, // Set your desired background color
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
                  buildTextField("First Name", "Enter First Name"),
                  buildTextField("Last Name", "Enter Last Name"),
                  buildTextField(
                    "Phone Number",
                    "Enter Phone Number",
                    keyboardType: TextInputType.phone,
                  ),
                  buildTextField(
                    "Email",
                    "Enter Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  buildDropdownField(
                    "Religion",
                    ["Hindu", "Muslim", "Christian", "Other"],
                    (value) {
                      setState(() => selectedReligion = value);
                    },
                  ),
                  buildDropdownField("Gender", ["Male", "Female", "Other"], (
                    value,
                  ) {
                    setState(() => selectedGender = value);
                  }),
                  buildTextField(
                    "Cost",
                    "Enter Cost of Land",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
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
        ));
  }

  Widget buildTextField(
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        ),
      ),
    );
  }

  Widget buildDropdownField(
    String label,
    List<String> options,
    Function(String?) onChanged,
  ) {
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
      ),
    );
  }
}
