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
  late final PageController _pageController;
  int _currentPage = 0;
  final Color _primaryColor = const Color(0xFF01255B);
  double _logoOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);
    _pageController.addListener(_handlePageScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_handlePageScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageScroll() {
    final page = _pageController.page ?? 0;
    setState(() {
      _logoOpacity = (1 - page).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final List<Widget> _pages = [
      _NotificationStepContent(),
      NotiStep1(),
      NotiStep2(),
      NotiStep3(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content column
          Column(
            children: [
              // Spacer that accounts for logo height
              SizedBox(
                  height: screenSize.height * 0.08 +
                      (_currentPage == 0 ? screenSize.height * 0.02 : 0)),

              // Expanded page view
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: _pages,
                ),
              ),

              // Page indicator
              SizedBox(height: screenSize.height * 0.02),
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
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 14,
                      height: 14,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? _primaryColor
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _currentPage == index
                              ? _primaryColor
                              : Colors.grey,
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
                    context,
                    MaterialPageRoute(builder: (context) => Utama()),
                  );
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

          // Logo with fade animation
          Positioned(
            top: screenSize.height * 0.08,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _logoOpacity,
              duration: Duration(milliseconds: 100),
              child: Center(
                child: Image.asset(
                  'assets/images/disaster_now_logo.png',
                  width: screenSize.width * 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationStepContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize = screenSize.width * 0.20;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Map with scale animation
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.95, end: 1.0),
          duration: Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  'assets/images/map.png',
                  width: screenSize.width * 0.5,
                ),
              ),
            );
          },
        ),
        // Icons with bounce animation
        _buildAnimatedIcon(
          'assets/images/icon5.png',
          iconSize,
          top: screenSize.height * 0.10,
          left: 0,
          right: 0,
          delay: 0,
        ),
        _buildAnimatedIcon(
          'assets/images/icon4.png',
          iconSize,
          top: screenSize.height * 0.20,
          left: screenSize.width * 0.02,
          delay: 100,
        ),
        _buildAnimatedIcon(
          'assets/images/icon2.png',
          iconSize,
          bottom: screenSize.height * 0.20,
          right: screenSize.width * 0.02,
          delay: 200,
        ),
        _buildAnimatedIcon(
          'assets/images/icon1.png',
          iconSize,
          bottom: screenSize.height * 0.20,
          left: screenSize.width * 0.02,
          delay: 150,
        ),
        _buildAnimatedIcon(
          'assets/images/icon3.png',
          iconSize,
          top: screenSize.height * 0.20,
          right: screenSize.width * 0.02,
          delay: 50,
        ),
      ],
    );
  }

  Widget _buildAnimatedIcon(String assetPath, double size,
      {double? top,
      double? bottom,
      double? left,
      double? right,
      int delay = 0}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 500),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Image.asset(
          assetPath,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
