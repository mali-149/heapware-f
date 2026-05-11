import 'package:flutter/material.dart';
import './auth/login_screen.dart'; // Import your login screen

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.jpg",
      "title": "Welcome to Heapware",
      "description": "AI-powered solutions for the future.",
      "extra": "Experience cutting-edge AI technology that revolutionizes the way you interact with data and automation.",
    },
    {
      "image": "assets/images/onboarding2.jpg",
      "title": "Seamless Automation",
      "description": "Automate your workflows efficiently.",
      "extra": "Our platform provides smart automation tools to enhance productivity and reduce manual efforts.",
    },
    {
      "image": "assets/images/onboarding3.jpg",
      "title": "Future-Ready Solutions",
      "description": "Stay ahead with AI-driven analytics.",
      "extra": "Make informed decisions with intelligent insights and predictive analytics tailored for your business.",
    },
  ];

  void nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin(); // Navigate to Login when last page is reached
    }
  }

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to Login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      onboardingData[index]["image"]!,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Dark overlay for better readability
                  Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.7)),
                  ),

                  // Text content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          onboardingData[index]["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          onboardingData[index]["description"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          onboardingData[index]["extra"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white60,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom Navigation
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                        (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 10,
                      width: _currentPage == index ? 25 : 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.tealAccent : Colors.white54,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),

                // Buttons Row (Skip & Next)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip Button (Navigates to Login)
                    TextButton(
                      onPressed: goToLogin,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Next Button
                    GestureDetector(
                      onTap: nextPage,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
