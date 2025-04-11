import 'package:flutter/material.dart';
import 'notificationStep.dart'; // Import your next page file

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/disaster_now_logo.png',
              width: 250,
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/images/loading_custom.gif',
              width: 60,
            ),
            SizedBox(height: 130),
            MouseRegion(
              cursor: SystemMouseCursors.click, // Changes the cursor on hover
              child: GestureDetector(
                onTap: () {
                  // Navigate to the next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationStep()),
                  );
                },
                child: Image.asset(
                  'assets/images/button_next.png',
                  width: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
