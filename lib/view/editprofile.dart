import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController(text: "Ram");
  TextEditingController lastNameController = TextEditingController(text: "Kishore");
  TextEditingController phoneController = TextEditingController(text: "+91-9123456789");
  TextEditingController emailController = TextEditingController(text: "ramkishore@gmail.com");
  TextEditingController dobController = TextEditingController(text: "01/04/1976");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {  Navigator.pop(context);},
        ),
        title: Text("Edit Profile", style: TextStyle(color: Colors.black, fontSize: 18)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage("assets/farmland.png"), // Profile image
    ),
    SizedBox(width: 8), // Spacing between image and text
    TextButton.icon(
      onPressed: () {},
      icon: Icon(Icons.edit, color: Color(0xFF8280FF), size: 18),
      label: Text("Upload image", style: TextStyle(color: Color(0xFF8280FF))),
    ),
  ],
),

              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Agent Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
              _buildTextField("First Name", firstNameController),
               SizedBox(height: 20),
              _buildTextField("Last Name", lastNameController),
               SizedBox(height: 20),
              _buildTextField("Phone Number", phoneController),
               SizedBox(height: 20),
              _buildTextField("Email", emailController),
               SizedBox(height: 20),
              _buildTextFieldWithIcon("Date of Birth", dobController, Icons.calendar_today),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xFF8280FF),
              side: BorderSide(color: Color(0xFF8280FF)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text("Cancel"),
          ),
                  SizedBox(width: 12),
                  _buildButton("Save", Color(0xFF8280FF), Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          suffixIcon: Icon(icon, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      ),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}
