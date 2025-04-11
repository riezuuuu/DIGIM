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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          if (_currentPage == 0) ...[
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: Image.asset(
                  'assets/images/disaster_now_logo.png',
                  width: 200,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
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
                return _pages[index];
              },
            ),
          ),
          SizedBox(height: 30),
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
                  width: 14,
                  height: 14,
                  margin: EdgeInsets.symmetric(horizontal: 5),
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
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Utama()));
            },
            child: Image.asset(
              'assets/images/close_button.png',
              width: 30,
              height: 50,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _NotificationStepContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size information
    final screenSize = MediaQuery.of(context).size;
    final iconSize =
        screenSize.width * 0.21; // Adjust this multiplier as needed
    final mapSize = screenSize.width * 0.5; // Adjust this multiplier as needed

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.asset(
            'assets/images/map.png',
            width: mapSize,
          ),
        ),
        Positioned(
          top: screenSize.height * 0.05,
          left: 0,
          right: 0,
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
    );
  }
}
