import 'package:flutter/material.dart';

class NotiStep2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              "MEMBUAT ADUAN",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF01255B)),
            ),
          ),

          SizedBox(height: 40), // Spacing between title and images

          // Horizontal Stair-Step Layout
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 25, // Left-most position
                    top: 0, // Highest position
                    child: _buildMapImage('assets/images/aduan1.png', 120),
                  ),
                  Positioned(
                    left: 145, // Center position
                    top: 60, // Medium height
                    child: _buildMapImage('assets/images/aduan2.png', 120),
                  ),
                  Positioned(
                    left: 265, // Right-most position
                    top: 120, // Lowest position
                    child: _buildMapImage('assets/images/aduan3.png', 120),
                  ),
                ],
              ),
            ),
          ),

          // Noti2 Image at the Bottom
          Image.asset(
            'assets/images/noti2.png',
            width: 310,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 100), // Bottom spacing
        ],
      ),
    );
  }

  Widget _buildMapImage(String assetPath, double width) {
    return Image.asset(
      assetPath,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
