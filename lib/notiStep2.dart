import 'package:flutter/material.dart';

class NotiStep2 extends StatelessWidget {
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
                    padding: EdgeInsets.only(top: 0),
                    alignment: Alignment.center,
                    child: Text(
                      "MEMBUAT ADUAN",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF01255B),
                      ),
                    ),
                  ),

                  // Image Stack
                  Container(
                    height: screenHeight * 0.5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: screenWidth * 0.025,
                          top: screenHeight * 0.04,
                          child: _buildImage(
                              'assets/images/aduan1.png', screenWidth * 0.3),
                        ),
                        Positioned(
                          left: screenWidth * 0.325,
                          top: screenHeight * 0.14,
                          child: _buildImage(
                              'assets/images/aduan2.png', screenWidth * 0.3),
                        ),
                        Positioned(
                          left: screenWidth * 0.625,
                          top: screenHeight * 0.22,
                          child: _buildImage(
                              'assets/images/aduan3.png', screenWidth * 0.3),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Image (noti2)
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Image.asset(
                      'assets/images/noti2.png',
                      width: screenWidth * 0.8,
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
