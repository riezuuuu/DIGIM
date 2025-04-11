import 'package:flutter/material.dart';

class NotiStep1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 120), // Add space at the top

          // Map Image
          Expanded(
            flex: 3, // Takes 3 parts of available space
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/map2.png',
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Notification Image
          Expanded(
            flex: 2, // Takes 2 parts of available space
            child: Center(
              child: Image.asset(
                'assets/images/noti1.png',
                width: 260,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
