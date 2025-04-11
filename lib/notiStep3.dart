import 'package:flutter/material.dart';

class NotiStep3 extends StatelessWidget {
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
              "CARIAN ADUAN",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF01255B)),
            ),
          ),

          SizedBox(height: 40),

          // Horizontal Stair-Step Layout
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 25,
                    top: 25,
                    child: _buildMapImage('assets/images/cari1.png', 120),
                  ),
                  Positioned(
                    left: 145,
                    top: 120,
                    child: _buildMapImage('assets/images/cari2.png', 120),
                  ),
                  Positioned(
                    left: 265,
                    top: 45,
                    child: _buildMapImage('assets/images/cari3.png', 120),
                  ),
                ],
              ),
            ),
          ),

          // Noti3 Image
          Image.asset(
            'assets/images/noti3.png',
            width: 270,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 150),
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
