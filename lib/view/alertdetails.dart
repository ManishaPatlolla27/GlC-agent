import 'package:flutter/material.dart';

class AlertDetailsScreen extends StatefulWidget {
  const AlertDetailsScreen({super.key});
  @override
  AlertDetailsScreenState createState() => AlertDetailsScreenState();
}

class AlertDetailsScreenState extends State<AlertDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedReligion;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Alert ID: ALRTSOS 02',
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
                    "Land owner details.",
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
                  buildTextField(
                    "Date of Birth",
                    "DD/MM/YYYY",
                    suffixIcon: Icons.calendar_today,
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
                  const Text(
                    "Google Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/googlemap.png',
                      height: 22,
                    ),
                    label: const Text(
                      "123456.23, 456789.23",
                      style: TextStyle(color: Color(0xFF8280FF)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF8280FF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
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
