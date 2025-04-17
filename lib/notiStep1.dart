import 'package:flutter/material.dart';

class NotiStep1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Responsive top space
          SizedBox(height: screenSize.height * 0.12), // ~12% of screen height

          // Map Image - takes 60% of remaining space
          Expanded(
            flex: 6, // 60% of available space
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/map2.png',
                  width: screenSize.width * 0.72, // 70% of screen width
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Notification Image - takes 40% of remaining space
          Expanded(
            flex: 4, // 40% of available space
            child: Center(
              child: Image.asset(
                'assets/images/noti1.png',
                width: screenSize.width * 0.72, // 72% of screen width
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
