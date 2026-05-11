import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 20),
              Text(
                "Introduction",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to Heapware. Your privacy is critically important to us. This Privacy Policy explains how we collect, use, and protect your data when using our app.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Information We Collect",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Heapware may collect both personal and technical information, including your name, email address, device details, performance logs, and user interactions. This helps us optimize system tools and provide a personalized experience.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "How We Use Your Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "1. To improve app performance and efficiency.\n"
                    "2. To offer system usage analytics and insights.\n"
                    "3. To send notifications about system alerts or new features.\n"
                    "4. To prevent unauthorized access or misuse.\n"
                    "5. To comply with applicable legal requirements.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Data Security",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We implement robust security measures to safeguard your information. Despite our efforts, no data transmission over the internet is completely secure. Use of the app is at your own risk.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Changes to This Policy",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We may revise this Privacy Policy from time to time to reflect changes in legal obligations, technology, or our services. Updates will be posted within the app.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "If you have any questions or concerns about this Privacy Policy, feel free to reach out at support@heapware.com.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
