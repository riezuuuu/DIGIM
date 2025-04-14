import 'package:flutter/material.dart';

class NotiStep3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Container(
                    height: 30,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "CARIAN ADUAN",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF01255B),
                      ),
                    ),
                  ),

                  // Image Stack - Maintaining your exact positioning ratios
                  Container(
                    height: screenHeight * 0.5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // First image (top-left)
                        Positioned(
                          left: screenWidth * 0.025, // ~15/360
                          top: screenHeight * 0.075, // ~48/400
                          child: _buildImage(
                              'assets/images/cari1.png', screenWidth * 0.3),
                        ),
                        // Second image (middle-right)
                        Positioned(
                          left: screenWidth * 0.325, // ~135/360
                          top: screenHeight * 0.19, // ~150/400
                          child: _buildImage(
                              'assets/images/cari2.png', screenWidth * 0.3),
                        ),
                        // Third image (bottom-left)
                        Positioned(
                          left: screenWidth * 0.625, // ~255/360
                          top: screenHeight * 0.10, // ~75/400
                          child: _buildImage(
                              'assets/images/cari3.png', screenWidth * 0.3),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Image (noti3)
                  Container(
                    padding: EdgeInsets.only(bottom: 75),
                    child: Image.asset(
                      'assets/images/noti3.png',
                      width: screenWidth * 0.8, // ~270/360
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(String assetPath, double width) {
    return Image.asset(
      assetPath,
      width: width,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          color: Colors.grey[200],
          child: Center(
            child: Text('Image not found', style: TextStyle(color: Colors.red)),
          ),
        );
      },
    );
  }
}
