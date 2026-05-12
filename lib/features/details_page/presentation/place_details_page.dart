import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:placefinder/resources/app_color.dart';

class PlaceDetailsPage extends StatefulWidget {
  final Map<String, dynamic> place;

  const PlaceDetailsPage({super.key, required this.place});

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  final MapController _mapController = MapController();

  Position? userPosition;
  bool isLoadingLocation = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  Future<void> initLocation() async {
    try {
      final status = await Permission.location.request();

      if (status.isDenied || status.isPermanentlyDenied) {
        setState(() {
          errorMessage = "Location permission denied";
          isLoadingLocation = false;
        });
        return;
      }

      if (status.isGranted) {
        userPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      }
    } catch (e) {
      errorMessage = "Something went wrong with location";
    }

    setState(() {
      isLoadingLocation = false;
    });
  }

  void openGoogleMaps(double lat, double lng) async {
    final url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Google Maps error: $e");
    }
  }

  void goToMyLocation() {
    if (userPosition == null) return;

    _mapController.move(
      LatLng(userPosition!.latitude, userPosition!.longitude),
      16,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double lat = (widget.place["lat"] ?? 0).toDouble();
    final double lng = (widget.place["lng"] ?? 0).toDouble();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          widget.place["name"] ?? "Place Details",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // IMAGE HEADER
            Stack(
              children: [
                Image.network(
                  widget.place["image"] ?? "",
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
                Container(height: 220, color: Colors.black.withOpacity(0.3)),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Text(
                    widget.place["category"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildCard(
              title: "Description",
              child: Text(widget.place["description"] ?? "No description"),
            ),

            _buildCard(
              title: "Address",
              child: Text(widget.place["address"] ?? "No address"),
            ),

            _buildCard(
              title: "Coordinates",
              child: Text(
                "Lat: $lat\nLng: $lng",
                style: const TextStyle(fontFamily: "monospace"),
              ),
            ),

            const SizedBox(height: 10),

            // MAP SECTION
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Location Map",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 8),

                Stack(
                  children: [
                    GestureDetector(
                      onTap: () => openGoogleMaps(lat, lng),
                      child: Container(
                        height: 320,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),

                          child: errorMessage != null
                              ? Center(
                                  child: Text(
                                    errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                )
                              : isLoadingLocation
                              ? const Center(child: CircularProgressIndicator())
                              : FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    initialCenter: LatLng(lat, lng),
                                    initialZoom: 15,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          "https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
                                    ),

                                    MarkerLayer(
                                      markers: [
                                        // PLACE MARKER (RED)
                                        Marker(
                                          point: LatLng(lat, lng),
                                          width: 50,
                                          height: 50,
                                          child: const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                            size: 50,
                                          ),
                                        ),

                                        // USER MARKER (BLUE)
                                        if (userPosition != null)
                                          Marker(
                                            point: LatLng(
                                              userPosition!.latitude,
                                              userPosition!.longitude,
                                            ),
                                            width: 40,
                                            height: 40,
                                            child: const Icon(
                                              Icons.my_location,
                                              color: Colors.blue,
                                              size: 30,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    // FLOATING BUTTON (MY LOCATION)
                    Positioned(
                      bottom: 25,
                      right: 30,
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.blue,
                        onPressed: goToMyLocation,
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
