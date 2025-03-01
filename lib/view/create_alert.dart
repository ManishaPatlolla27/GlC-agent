import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../page_routing/app_routes.dart';

class CreateAlertScreen extends StatefulWidget {
  const CreateAlertScreen({super.key});
  @override
  CreateAlertScreenState createState() => CreateAlertScreenState();
}

class CreateAlertScreenState extends State<CreateAlertScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedReligion;
  String? selectedGender;
  final TextEditingController _dobController = TextEditingController();
  LatLng? selectedLocation; // Stores selected location
  bool locationError = false; // Tracks location validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Farmland Seller Alert',
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
                    "Please share the land owner details.",
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
                    if (!RegExp(r'^\d{10}$').hasMatch(value))
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
                  buildTextField("Date of Birth", "DD/MM/YYYY",
                      controller: _dobController,
                      suffixIcon: Icons.calendar_today, onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dobController.text =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      });
                    }
                  }, validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Date of Birth is required";
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
                    if (value == null || value.isEmpty)
                      return "Cost is required";
                    if (double.tryParse(value) == null)
                      return "Enter a valid amount";
                    return null;
                  }),
                  const SizedBox(height: 20),
                  const Text("Google Location",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final LatLng? result =
                          await Navigator.pushNamed(context, AppRoutes.map)
                              as LatLng?;

                      if (result != null) {
                        setState(() {
                          selectedLocation = result;
                          locationError =
                              false; // Reset error when location is selected
                        });
                      }
                    },
                    icon: Image.asset('assets/googlemap.png', height: 22),
                    label: Text(
                      selectedLocation != null
                          ? "Lat: ${selectedLocation!.latitude}, Lng: ${selectedLocation!.longitude}"
                          : "Add Google Location",
                      style: const TextStyle(color: Color(0xFF8280FF)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: locationError ? Colors.red : Color(0xFF8280FF),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  if (locationError) // Show error if location is missing
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        "Please select a location",
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedLocation == null) {
                          setState(() {
                            locationError = true;
                          });
                          return;
                        }
                        print(
                            "Selected Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}");
                        // Submit data
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8280FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildTextField(String label, String hint,
      {TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      IconData? suffixIcon,
      void Function()? onTap,
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
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        ),
        onTap: onTap,
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
