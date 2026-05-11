import 'package:flutter/material.dart';
import '../auth/signverify.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> signup() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String ageText = _ageController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || ageText.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    int? age = int.tryParse(ageText);
    if (age == null) {
      Fluttertoast.showToast(msg: "Enter a valid age");
      return;
    }

    if (age < 15 || age > 60) {
      Fluttertoast.showToast(msg: "Age must be between 15 and 60");
      return;
    }

    final url = Uri.parse("https://heapware.onrender.com/api/auth/register");

    final Map<String, dynamic> requestBody = {
      "name": name,
      "email": email,
      "password": password,
      "age": age,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Signup successful!");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationPage1(email: email))
        );
      } else {
        final responseBody = json.decode(response.body);
        Fluttertoast.showToast(
            msg: "Signup failed: ${responseBody['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.8)),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 80),
                  SizedBox(height: 40),
                  Container(
                    width: 350,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.greenAccent.withOpacity(0.7)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text("Create your account to get started",
                            style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 20),
                        _buildTextField(_nameController, Icons.person, "Full Name"),
                        SizedBox(height: 10),
                        _buildTextField(_emailController, Icons.email, "Email"),
                        SizedBox(height: 10),
                        _buildTextField(_passwordController, Icons.lock, "Password",
                            isPassword: true),
                        SizedBox(height: 10),
                        _buildTextField(_ageController, Icons.cake, "Age", isNumber: true),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent,
                            minimumSize: Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Or continue with", style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 10),
                        _buildSocialIcons(),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style: TextStyle(color: Colors.white)),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text("Login",
                                  style: TextStyle(color: Colors.tealAccent)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon,
      String hintText,
      {bool isPassword = false, bool isNumber = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType:
      isNumber ? TextInputType.number : TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon("assets/images/google.png"),
        SizedBox(width: 35),
        _socialIcon("assets/images/facebook.png"),
      ],
    );
  }

  Widget _socialIcon(String assetPath) {
    return GestureDetector(
      onTap: () {
        // Add social login logic here
      },
      child: Image.asset(assetPath, width: 40),
    );
  }
}
