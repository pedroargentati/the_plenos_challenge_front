import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<LatLng> coordinates = [
    LatLng(-23.513498, -46.653354),
    LatLng(-23.513494, -46.653365),
    LatLng(-23.509061, -46.652768),
  ];

  double circleRadius = 1000; 

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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Postos de Gasolina',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-23.574165, -46.623128),
                zoom: 12,
                onPositionChanged: (MapPosition position, bool hasGesture) {
                  setState(() {
                    final zoom = position.zoom;
                    circleRadius = 3000 / zoom!;
                  });
                },
              ),
              nonRotatedChildren: [
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
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
                  circles: coordinates.map((coordinate) {
                    return CircleMarker(
                      point: coordinate,
                      radius: circleRadius,
                      useRadiusInMeter: true,
                      color: const Color.fromARGB(128, 0, 2, 118),
                      borderColor: const Color.fromARGB(255, 255, 255, 255),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
