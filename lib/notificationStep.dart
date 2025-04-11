import 'package:flutter/material.dart';
import 'package:disasternow/utama.dart';
import 'notiStep1.dart';
import 'notiStep2.dart';
import 'notiStep3.dart';

class NotificationStep extends StatefulWidget {
  @override
  _NotificationStepState createState() => _NotificationStepState();
}

class _NotificationStepState extends State<NotificationStep> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Color _primaryColor = const Color(0xFF01255B); // #01255b

  final List<Widget> _pages = [
    _NotificationStepContent(),
    NotiStep1(),
    NotiStep2(),
    NotiStep3(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get consistent sizing for all pages
    final screenSize = MediaQuery.of(context).size;
    final logoSize = screenSize.width * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Logo with consistent sizing (will fade out when swiping)
          AnimatedOpacity(
            opacity: _currentPage == 0 ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.1),
              child: Center(
                child: Image.asset(
                  'assets/images/disaster_now_logo.png',
                  width: logoSize,
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                // Pass consistent sizing to all pages
                return _pages[index];
              },
            ),
          ),

          SizedBox(height: screenSize.height * 0.04),

          // Navigation indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (index) {
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: screenSize.width * 0.03,
                  height: screenSize.width * 0.03,
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
                  decoration: BoxDecoration(
                    color: _currentPage == index ? _primaryColor : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          _currentPage == index ? _primaryColor : Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: screenSize.height * 0.03),

          // Close button
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Utama()));
            },
            child: Image.asset(
              'assets/images/close_button.png',
              width: screenSize.width * 0.08,
              height: screenSize.width * 0.13,
            ),
          ),

          SizedBox(height: screenSize.height * 0.04),
        ],
      ),
    );
  }
}

class _NotificationStepContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize = screenSize.width * 0.21;
    final mapSize = screenSize.width * 0.5;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Map with consistent size
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.asset(
            'assets/images/map.png',
            width: mapSize,
            height: mapSize, // Fixed height to prevent stretching
            fit: BoxFit.cover,
          ),
        ),
        // Icons with consistent positioning
        Positioned(
          top: screenSize.height * 0.05,
          child: _buildCircleIcon('assets/images/icon5.png', iconSize),
        ),
        Positioned(
          top: screenSize.height * 0.17,
          left: screenSize.width * 0.03,
          child: _buildCircleIcon('assets/images/icon4.png', iconSize),
        ),
        Positioned(
          bottom: screenSize.height * 0.16,
          right: screenSize.width * 0.03,
          child: _buildCircleIcon('assets/images/icon2.png', iconSize),
        ),
        Positioned(
          bottom: screenSize.height * 0.16,
          left: screenSize.width * 0.03,
          child: _buildCircleIcon('assets/images/icon1.png', iconSize),
        ),
        Positioned(
          top: screenSize.height * 0.17,
          right: screenSize.width * 0.03,
          child: _buildCircleIcon('assets/images/icon3.png', iconSize),
        ),
      ],
    );
  }

  Widget _buildCircleIcon(String assetPath, double size) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
