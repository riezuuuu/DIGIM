import 'package:disasternow/utama.dart';
import 'package:flutter/material.dart';

class Pengenalan extends StatefulWidget {
  const Pengenalan({super.key});

  @override
  State<Pengenalan> createState() => _PengenalanState();
}

class _PengenalanState extends State<Pengenalan> {
  int _selectedIndex = 3; // 3 for Pengenalan since it's the 4th item

  void _onItemTapped(int index, BuildContext context) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to Notifications
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Utama()),
          (route) => false,
        );
        break;
      case 2:
        // Navigate to Charts
        break;
      case 3:
        // Already on Pengenalan screen
        break;
    }
  }

  Widget _buildNavBarItem(String assetPath, int index, BuildContext context) {
    // Added BuildContext parameter
    String getLabel(int index) {
      switch (index) {
        case 0:
          return "Notifikasi";
        case 1:
          return "Utama";
        case 2:
          return "Carta";
        case 3:
          return "Pengenalan";
        default:
          return "";
      }
    }

    return GestureDetector(
      onTap: () => _onItemTapped(index, context),
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              color: _selectedIndex == index ? Color(0xFFB6D7E7) : Colors.white,
            ),
            SizedBox(height: 4), // Added some spacing
            Text(
              getLabel(index),
              style: TextStyle(
                color:
                    _selectedIndex == index ? Color(0xFFB6D7E7) : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pengenalan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/disaster_now_logo.png',
                    width: 200,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Aplikasi DisasterNow adalah platform untuk memperkukuh pengurusan bencana dan penglibatan rakyat melalui kemaskini masa nyata di platform terbuka, integrasi maklumat geospatial ke platform DGIM bagi tujuan Common Operating Picture (COP), dan pengurusan bantuan bagi menyokong respon segera serta kolaborasi lebih baik semasa kecemasan. Aplikasi bertujuan untuk menyokong Agensi Pengurusan Bencana Negara (NADMA) dalam mengatasi bencana dan krisis negara',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 370),
                ],
              ),
            ),
            // Bottom Navigation Bar
            Positioned(
              bottom: -14, // Changed from -18 to 0 for better alignment
              left: -12,
              right: -12,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/navbar.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavBarItem(
                        "assets/images/notifikasi.png", 0, context),
                    _buildNavBarItem("assets/images/utama.png", 1, context),
                    _buildNavBarItem("assets/images/carta.png", 2, context),
                    _buildNavBarItem(
                        "assets/images/pengenalan.png", 3, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
