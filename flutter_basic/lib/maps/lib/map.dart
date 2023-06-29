import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/maps/lib/restaura%C3%A7%C3%A3o.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'edificios.dart';
import 'entrances.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => GMapState();
}

class GMapState extends State<GMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> _markers = Set<Marker>();
  final Set<Polyline> _polylines = <Polyline>{};

  int _polylineIdCounter = 1;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.661555, -9.205579),
    zoom: 16,
  );

  List<Polygon> buildings = [
    Edificios.edI,
    Edificios.edII,
    Edificios.edVII,
    Edificios.biblioteca,
    Edificios.departamental,
    Edificios.edX
  ];

  List<List<Marker>> buildingMarkers = [
    [Entrances.edIP, Entrances.edILat],
    [
      Entrances.edIIP,
      Entrances.edIILAtI,
      Entrances.edIILatII,
      Entrances.edIIMat,
      Entrances.edIIS
    ],
    [Entrances.edVIIP, Entrances.edVIIT],
    [Entrances.biblioteca],
    [Entrances.departamental],
    [Entrances.edX]
  ];

  List<Polygon> catering = [
    Restauracao.Biblioteca,
    Restauracao.Cantina,
    Restauracao.Casa_Pessoal,
    Restauracao.MiniNova,
    Restauracao.MySpot,
    Restauracao.Solucao,
    Restauracao.Tanto_Faz,
  ];

  int _lastDisplayedPolygonIndex = -1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<bool> buildingsVisibility;
  late List<List<bool>> buildMarkersVisibility;

  @override
  void initState() {
    super.initState();
    buildMarkersVisibility = List.generate(
        buildings.length,
        (index) => List.generate(
            buildingMarkers[index].length, (markerIndex) => false));
    buildingsVisibility = List.generate(buildings.length,
        (index) => false); // Set initial visibility of polygons
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  polylines: _polylines,
                  markers: Set<Marker>.from(
                    buildingMarkers.expand(
                      (markers) => markers.where(
                        (marker) => buildMarkersVisibility[buildingMarkers
                            .indexOf(markers)][markers.indexOf(marker)],
                      ),
                    ),
                  ),
                  polygons: Set<Polygon>.from(buildings.where(
                    (polygon) =>
                        buildingsVisibility[buildings.indexOf(polygon)],
                  )),
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    mini: true,
                    backgroundColor: const Color.fromARGB(255, 33, 2, 154),
                    child: const Icon(
                      Icons.menu,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ExpansionTile(
              title: const Text('Edifícios'),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: buildings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(buildings[index].polygonId.value),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Hide the last displayed polygon (if any)
                          if (_lastDisplayedPolygonIndex != -1) {
                            setState(() {
                              buildingsVisibility[_lastDisplayedPolygonIndex] =
                                  false;
                            });
                          }

                          // Hide the last displayed markers (if any)
                          if (_lastDisplayedPolygonIndex != -1) {
                            for (int i = 0;
                                i <
                                    buildingMarkers[_lastDisplayedPolygonIndex]
                                        .length;
                                i++) {
                              setState(() {
                                buildMarkersVisibility[
                                    _lastDisplayedPolygonIndex][i] = false;
                              });
                            }
                          }

                          // Show the selected polygon
                          setState(() {
                            buildingsVisibility[index] = true;
                            _lastDisplayedPolygonIndex = index;
                          });

                          // Show the markers associated with the selected polygon
                          for (int i = 0;
                              i < buildingMarkers[index].length;
                              i++) {
                            setState(() {
                              buildMarkersVisibility[index][i] = true;
                            });
                          }

                          // Change the camera position to the respective building
                          _goToBuilding(
                            buildingMarkers[index][0].position.latitude,
                            buildingMarkers[index][0].position.longitude,
                          );

                          _scaffoldKey.currentState?.closeDrawer();
                        },
                        child: const Text('Mostrar onde'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const ExpansionTile(
              title: Text('Other Dropdown'),
              children: [
                // Widgets and functionality for the second dropdown button
              ],
            ),
          ],
        ),
      ),
    );
  }

  void requestLocationPermissions() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      print("Location permissions granted.");
    } else {
      print("Location permissions not granted.");
    }
  }

  Future<void> _goToPlace(
    // Map<String, dynamic> place,
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }

  Future<void> _goToBuilding(
    double lat,
    double lng,
  ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 18.5,
        ),
      ),
    );
  }
}

          /* Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: const InputDecoration(hintText: ' Origin'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    TextFormField(
                      controller: _destinationController,
                      decoration:
                          const InputDecoration(hintText: ' Destination'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  requestLocationPermissions();
                  var position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  print("++++++++");
                  print(position);
                  print("++++++++");
                  var directions = await LocationService().getDirections(
                    _originController.text,
                    _destinationController.text,
                  );
                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline(directions['polyline_decoded']);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ), */
