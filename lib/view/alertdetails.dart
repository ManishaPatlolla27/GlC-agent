import 'package:flutter/material.dart';
import 'package:nex2u/models/alerts/alert_response.dart';

class AlertViewScreen extends StatelessWidget {
  final AlertsList farm;
  const AlertViewScreen({super.key, required this.farm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Alert ID: ${farm.alertCode}",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Land owner details.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildTextField("First Name", farm.firstName.toString()),
            _buildTextField("Last Name", farm.lastName.toString()),
            _buildTextField("Phone Number", farm.contactNumber.toString()),
            _buildTextField("Email", farm.contactEmail.toString()),
            _buildTextField("Date of Birth", farm.dob.toString(),
                icon: Icons.calendar_today),
            _buildTextField("Religion", farm.religion.toString()),
            _buildTextField("Gender", farm.gender.toString()),
            _buildTextField("Cost", farm.landCost.toString()),
            const SizedBox(height: 16),
            const Text(
              "Google Location",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 6),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_pin, color: Colors.red),
                hintText: "${farm.landLatitude},${farm.landLongitude}",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        controller: TextEditingController(text: value),
      ),
    );
  }
}
