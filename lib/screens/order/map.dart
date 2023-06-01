import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController? mapController;
  List<LatLng> points = [
    LatLng(45.5231, -122.6765), // Điểm 1
    LatLng(45.5244, -122.6699), // Điểm 2
  ];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: points[0], // Tọa độ trung tâm của bản đồ là điểm đầu tiên
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          // Tạo Marker cho 2 điểm
          MarkerLayerOptions(
            markers: [
              Marker(
                  width: 50,
                  height: 50,
                  point: points[0], // Điểm đầu tiên
                  builder: (ctx) => Stack(
                        children: [
                          // Icon(
                          //   Icons.location_pin,
                          //   color: Colors.red,
                          //   size: 50,
                          // ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image: NetworkImage(
                                    'https://www.tutorialkart.com/img/hummingbird.png'),
                              ),
                            ),
                          )
                        ],
                        alignment: Alignment.center,
                      )),
              Marker(
                width: 50,
                height: 50,
                point: points[1], // Điểm thứ hai
                builder: (ctx) => Icon(
                  Icons.location_pin,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ],
          ),
          // Tạo Polyline nối 2 điểm
          PolylineLayerOptions(
            polylines: [
              Polyline(
                  points: points,
                  color: Color.fromARGB(255, 129, 1, 171),
                  strokeWidth: 7.0,
                  isDotted: true),
            ],
          ),
        ],
      ),
    );
  }
}
