import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'pengenalan.dart';

class Utama extends StatefulWidget {
  @override
  _UtamaState createState() => _UtamaState();
}

class _UtamaState extends State<Utama> {
  final TextEditingController _searchController = TextEditingController();
  late MapController _mapController;
  LatLng _center = LatLng(4.2105, 101.9758);
  List<Polyline> _stateBoundaries = [];
  int _selectedIndex = 1;
  String _tileLayerUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
  bool _showBasemapSelector = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _loadStateBoundaries();
  }

  Future<void> _loadStateBoundaries() async {
    try {
      String geoJsonString =
          await rootBundle.loadString('assets/malaysia.geojson');
      Map<String, dynamic> geoJsonData = json.decode(geoJsonString);

      List<Polyline> boundaries = [];
      for (var feature in geoJsonData['features']) {
        var geometry = feature['geometry'];
        var properties = feature['properties'];

        if (geometry['type'] == 'LineString') {
          _addLineStringBoundary(
              boundaries, geometry['coordinates'], properties['name']);
        } else if (geometry['type'] == 'MultiLineString') {
          for (var line in geometry['coordinates']) {
            _addLineStringBoundary(boundaries, line, properties['name']);
          }
        }
      }

      setState(() => _stateBoundaries = boundaries);
    } catch (e) {
      print("Error loading GeoJSON: $e");
    }
  }

  void _addLineStringBoundary(
      List<Polyline> boundaries, List coordinates, String name) {
    try {
      List<LatLng> points = coordinates
          .map<LatLng>(
              (coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
          .toList();

      boundaries.add(Polyline(
        points: points,
        color: Colors.red,
        strokeWidth: 2.0,
      ));
    } catch (e) {
      print("Error processing $name: $e");
    }
  }

  void _moveMap(LatLng center, double zoom) {
    _mapController.move(center, zoom);
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;

    final encodedQuery = Uri.encodeFull(query);
    final url =
        "https://nominatim.openstreetmap.org/search?q=$encodedQuery&format=json&limit=1";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'MyFlutterMapApp/1.0'},
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List && data.isNotEmpty) {
          final result = data.first;
          final lat = double.tryParse(result['lat'] ?? '');
          final lon = double.tryParse(result['lon'] ?? '');

          if (lat != null && lon != null) {
            final newCenter = LatLng(lat, lon);
            setState(() => _center = newCenter);
            _moveMap(newCenter, 13.0);
            return;
          }
        }
        _showError("Location not found");
      } else {
        _showError("Server error: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Error: ${e.toString()}");
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showBasemapSelectorDialog() {
    setState(() {
      _showBasemapSelector = true;
    });
  }

  void _hideBasemapSelector() {
    setState(() {
      _showBasemapSelector = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to Notifications
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Utama()),
        );
        break;
      case 2:
        // Navigate to Charts
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pengenalan()),
        );
        break;
    }
  }

  Widget _buildIconButton(String assetPath, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Image.asset(
              assetPath,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(String assetPath, int index) {
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

    return Container(
      width: 70, // Fixed width for all items
      height: 70, // Increased height to accommodate text
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _onItemTapped(index),
            child: Image.asset(
              assetPath,
              width: 40, // Slightly reduced image size
              height: 40,
              fit: BoxFit.contain,
              color: _selectedIndex == index ? Color(0xFFB6D7E7) : Colors.white,
            ),
          ),
          SizedBox(height: 0), // Space between image and text
          Text(
            getLabel(index),
            style: TextStyle(
              color: _selectedIndex == index ? Color(0xFFB6D7E7) : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasemapOption(
      String imagePath, String title, String urlTemplate) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tileLayerUrl = urlTemplate;
          _showBasemapSelector = false;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 55,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 7.5,
            ),
            children: [
              TileLayer(
                urlTemplate: _tileLayerUrl,
              ),
              PolylineLayer(polylines: _stateBoundaries),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _center,
                    width: 40.0,
                    height: 40.0,
                    child:
                        Icon(Icons.location_pin, color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),

          // Search Bar
          Positioned(
            top: 68,
            left: 15,
            right: 90,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3)),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Find address or places",
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                      onSubmitted: _searchLocation,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.grey),
                    onPressed: () => _searchLocation(_searchController.text),
                  ),
                ],
              ),
            ),
          ),

          // Vertical Buttons
          Positioned(
            top: 60,
            right: 15,
            child: Column(
              children: [
                _buildIconButton("assets/images/layer.png", () {}),
                _buildIconButton(
                    "assets/images/zoomIn.png",
                    () => _moveMap(_mapController.camera.center,
                        _mapController.camera.zoom + 1)),
                _buildIconButton(
                    "assets/images/zoomOut.png",
                    () => _moveMap(_mapController.camera.center,
                        _mapController.camera.zoom - 1)),
                _buildIconButton("assets/images/home.png",
                    () => _moveMap(LatLng(4.2105, 101.9758), 7.5)),
                _buildIconButton(
                    "assets/images/basemap.png", _showBasemapSelectorDialog),
              ],
            ),
          ),

          // Basemap Selector Dialog - Fixed Version
          if (_showBasemapSelector)
            Positioned(
              top: 135,
              right: 98,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.68,
                padding: EdgeInsets.only(top: 0, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  // Add this to prevent overflow issues
                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Grey Header
                      Container(
                        margin: EdgeInsets.only(left: 0, right: 0, bottom: 4),
                        padding: EdgeInsets.only(
                          left: 16,
                          right:
                              30, // Add extra padding on right for the button
                          top: 16,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFece8e8),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 1,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.none, // Allow overflow
                          children: [
                            Center(
                              child: Text(
                                "Basemap Galeri",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              top: 0,
                              child: IgnorePointer(
                                ignoring:
                                    false, // Ensure this widget can receive touches
                                child: GestureDetector(
                                  onTap: _hideBasemapSelector,
                                  child: Image.asset(
                                    "assets/images/close_button.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Content
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23),
                        child: Column(
                          children: [
                            SizedBox(height: 4),
                            _buildBasemapOption(
                              "assets/images/osm_preview.png",
                              "Open Street Map",
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            ),
                            _buildBasemapOption(
                              "assets/images/imagery_preview.png",
                              "Imagery",
                              "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom Navigation Bar
          Positioned(
            bottom: -14,
            left: -12,
            right: -12,
            child: Container(
              height: 100, // Increased height for the navigation bar
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/navbar.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavBarItem("assets/images/notifikasi.png", 0),
                  _buildNavBarItem("assets/images/utama.png", 1),
                  _buildNavBarItem("assets/images/carta.png", 2),
                  _buildNavBarItem("assets/images/pengenalan.png", 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
