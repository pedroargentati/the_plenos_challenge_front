import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double circleRadius = 4000; // Raio inicial do círculo em metros

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 127, 127, 127),
        title: const Text(
          'Mapa',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Comfortaa',
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-23.574165, -46.623128),
          zoom: 9.2,
          onPositionChanged: (MapPosition position, bool hasGesture) {
            setState(() {
              final zoom = position.zoom;
              // Defina uma lógica para ajustar o raio com base no nível de zoom
              // Por exemplo, você pode fazer o raio diminuir à medida que o zoom aumenta
              circleRadius = 2000 / zoom!;
            });
          },
        ),
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: LatLng(-23.574165, -46.623128),
                radius: circleRadius,
                useRadiusInMeter: true,
                color: const Color.fromARGB(128, 0, 2, 118),
                borderColor: const Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
