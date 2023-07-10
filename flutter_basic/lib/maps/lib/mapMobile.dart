import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/maps/lib/polygons/restaura%C3%A7%C3%A3o.dart';
import 'package:flutter_basic/myAppBar.dart';
import 'package:flutter_basic/myAppBarMobile.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../bottomAppBarMobile.dart';
import 'markers/parks.dart';
import 'polygons/edificios.dart';
import 'markers/entrances.dart';
import 'markers/multibancos.dart';

class GMapMobile extends StatefulWidget {
  const GMapMobile({super.key});

  @override
  State<GMapMobile> createState() => GMapState();
}

class GMapState extends State<GMapMobile> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Set<Marker> _markers = Set<Marker>();
  final Set<Polyline> _polylines = <Polyline>{};

  int _polylineIdCounter = 1;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.661555, -9.205579),
    zoom: 16,
  );
  bool isCancelButtonVisible = true;

  List<Polygon> buildings = [
    Edificios.edI,
    Edificios.edII,
    Edificios.edVII,
    Edificios.biblioteca,
    Edificios.departamental,
    Edificios.edX
  ];

  List<List<Marker>> transportMarkers = [
    [Entrances.paragemMetro],
    [
      Entrances.paragemAutocarroIII,
      Entrances.paragemAutocarroI,
      Entrances.paragemAutocarroII,
    ],
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

  List<List<Marker>> cateringMarkers = [
    [Entrances.biblioteca],
    [
      Entrances.convivioLatD,
      Entrances.convivioLatE,
      Entrances.convivioP,
      Entrances.cantina
    ],
    [Entrances.casaPessoal],
    [Entrances.mini_nova],
    [Entrances.mySpot],
    [Entrances.solucao],
    [Entrances.tantoFaz],
  ];

  List<Marker> ATMsMarkers = [
    ATMs.Departamental,
    ATMs.EdI,
    ATMs.EdII,
    ATMs.Lidl
  ];

  List<Marker> parksMarkers = [
    Parks.departamental,
    Parks.DepInformatica,
    Parks.sportClub,
    Parks.FCTDromedo
  ];

  int _lastDisplayedBuildingIndex = -1;
  int _lastDisplayedCateringIndex = -1;
  int _lastDisplayedATMsIndex = -1;
  int _lastDisplayedParksIndex = -1;
  int _lastDisplayedTransportIndex = -1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<bool> buildingsVisibility;
  late List<List<bool>> builMarkersVisibility;
  late List<bool> cateringVisibility;
  late List<List<bool>> cateringMarkersVisibility;
  late List<bool> ATMsMarkersVisibility;
  late List<bool> parksMarkersVisibility;
  late List<List<bool>> transportMarkersVisibility;
  late bool isAnyElementDisplayed;

  @override
  void initState() {
    super.initState();
    isAnyElementDisplayed = false;

    transportMarkersVisibility = List.generate(
        transportMarkers.length,
            (index) => List.generate(
            transportMarkers[index].length, (markerIndex) => false));

    builMarkersVisibility = List.generate(
        buildings.length,
            (index) => List.generate(
            buildingMarkers[index].length, (markerIndex) => false));
    buildingsVisibility = List.generate(buildings.length,
            (index) => false);

    cateringMarkersVisibility = List.generate(
        catering.length,
            (index) => List.generate(
            cateringMarkers[index].length, (markerIndex) => false));
    cateringVisibility = List.generate(catering.length,
            (index) => false);

    ATMsMarkersVisibility = List.generate(ATMsMarkers.length, (index) => false);

    parksMarkersVisibility =
        List.generate(parksMarkers.length, (index) => false);
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
    isAnyElementDisplayed = _lastDisplayedBuildingIndex != -1 ||
        _lastDisplayedCateringIndex != -1 ||
        _lastDisplayedATMsIndex != -1 ||
        _lastDisplayedParksIndex != -1 ||
        _lastDisplayedTransportIndex != -1;
    return Scaffold(
      appBar: MyAppBarMobile(),
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
                            (marker) => builMarkersVisibility[buildingMarkers
                            .indexOf(markers)][markers.indexOf(marker)],
                      ),
                    ),
                  )
                      .followedBy(cateringMarkers.expand(
                        (markers) => markers.where(
                          (marker) => cateringMarkersVisibility[cateringMarkers
                          .indexOf(markers)][markers.indexOf(marker)],
                    ),
                  ))
                      .followedBy(transportMarkers.expand(
                        (markers) => markers.where(
                          (marker) => transportMarkersVisibility[
                      transportMarkers.indexOf(markers)]
                      [markers.indexOf(marker)],
                    ),
                  ))
                      .followedBy(
                    ATMsMarkers.where((marker) =>
                    ATMsMarkersVisibility[ATMsMarkers.indexOf(marker)]),
                  )
                      .followedBy(
                    parksMarkers.where((marker) => parksMarkersVisibility[
                    parksMarkers.indexOf(marker)]),
                  )
                      .toSet(),
                  polygons: Set<Polygon>.from(
                    buildings
                        .where((polygon) =>
                    buildingsVisibility[buildings.indexOf(polygon)])
                        .followedBy(catering.where((polygon) =>
                    cateringVisibility[catering.indexOf(polygon)])),
                  ),
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
                if (isAnyElementDisplayed && isCancelButtonVisible)
                  Positioned(
                    top: 50,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        hideLastDisplayedElements();
                        _goToBuilding(
                          _kGooglePlex.target.latitude,
                          _kGooglePlex.target.longitude,
                          16,
                        );
                        setState(() {
                          isCancelButtonVisible = false;
                        });
                      },
                      mini: true,
                      backgroundColor: const Color.fromARGB(255, 33, 2, 154),
                      child: const Icon(
                        Icons.cancel,
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
            ListTile(
              title: const Text("Paragem Metro"),
              trailing: ElevatedButton(
                onPressed: () {
                  hideLastDisplayedElements();
                  _lastDisplayedTransportIndex = 0;
                  for (int i = 0; i < transportMarkers[0].length; i++) {
                    setState(() {
                      transportMarkersVisibility[0][i] = true;
                    });
                  }
                  _goToBuilding(transportMarkers[0][0].position.latitude,
                      transportMarkers[0][0].position.longitude, 18.5);
                  setState(() {
                    isCancelButtonVisible = true;
                  });
                  _scaffoldKey.currentState?.closeDrawer();
                },
                child: const Text('Mostrar onde'),
              ),
            ),
            ListTile(
              title: const Text("Paragens Autocarro"),
              trailing: ElevatedButton(
                onPressed: () {
                  hideLastDisplayedElements();
                  _lastDisplayedTransportIndex = 1;
                  for (int i = 0; i < transportMarkers[1].length; i++) {
                    setState(() {
                      transportMarkersVisibility[1][i] = true;
                    });
                  }
                  _goToBuilding(_kGooglePlex.target.latitude,
                      _kGooglePlex.target.longitude, 16);
                  setState(() {
                    isCancelButtonVisible = true;
                  });
                  _scaffoldKey.currentState?.closeDrawer();
                },
                child: const Text('Mostrar onde'),
              ),
            ),
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
                          hideLastDisplayedElements();

                          setState(() {
                            buildingsVisibility[index] = true;
                            _lastDisplayedBuildingIndex = index;
                          });

                          for (int i = 0;
                          i < buildingMarkers[index].length;
                          i++) {
                            setState(() {
                              builMarkersVisibility[index][i] = true;
                            });
                          }

                          _goToBuilding(
                              buildingMarkers[index][0].position.latitude,
                              buildingMarkers[index][0].position.longitude,
                              18.5);
                          setState(() {
                            isCancelButtonVisible = true;
                          });
                          _scaffoldKey.currentState?.closeDrawer();
                        },
                        child: const Text('Mostrar onde'),
                      ),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Comida & Bebida'),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: catering.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(catering[index].polygonId.value),
                      trailing: ElevatedButton(
                        onPressed: () {
                          hideLastDisplayedElements();

                          setState(() {
                            cateringVisibility[index] = true;
                            _lastDisplayedCateringIndex = index;
                          });

                          for (int i = 0;
                          i < cateringMarkers[index].length;
                          i++) {
                            setState(() {
                              cateringMarkersVisibility[index][i] = true;
                            });
                          }

                          _goToBuilding(
                              cateringMarkers[index][0].position.latitude,
                              cateringMarkers[index][0].position.longitude,
                              18.5);
                          setState(() {
                            isCancelButtonVisible = true;
                          });
                          _scaffoldKey.currentState?.closeDrawer();
                        },
                        child: const Text('Mostrar onde'),
                      ),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Multibancos'),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ATMsMarkers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(ATMsMarkers[index].markerId.value),
                      trailing: ElevatedButton(
                        onPressed: () {
                          hideLastDisplayedElements();

                          setState(() {
                            ATMsMarkersVisibility[index] = true;
                            _lastDisplayedATMsIndex = index;
                          });

                          _goToBuilding(ATMsMarkers[index].position.latitude,
                              ATMsMarkers[index].position.longitude, 18.5);
                          setState(() {
                            isCancelButtonVisible = true;
                          });
                          _scaffoldKey.currentState?.closeDrawer();
                        },
                        child: const Text('Mostrar onde'),
                      ),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Parques de estacionamento'),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ATMsMarkers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(ATMsMarkers[index].markerId.value),
                      trailing: ElevatedButton(
                        onPressed: () {
                          hideLastDisplayedElements();

                          setState(() {
                            parksMarkersVisibility[index] = true;
                            _lastDisplayedParksIndex = index;
                          });

                          _goToBuilding(parksMarkers[index].position.latitude,
                              parksMarkers[index].position.longitude, 18.5);
                          setState(() {
                            isCancelButtonVisible = true;
                          });
                          _scaffoldKey.currentState?.closeDrawer();
                        },
                        child: const Text('Mostrar onde'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),

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
      double dZoom,
      ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: dZoom,
        ),
      ),
    );
  }

  bool isButtonVisible() {
    return _lastDisplayedBuildingIndex == -1 &&
        _lastDisplayedCateringIndex == -1 &&
        _lastDisplayedATMsIndex == -1 &&
        _lastDisplayedParksIndex == -1 &&
        _lastDisplayedTransportIndex == -1;
  }

  void hideLastDisplayedElements() {
    if (_lastDisplayedBuildingIndex != -1) {
      setState(() {
        buildingsVisibility[_lastDisplayedBuildingIndex] = false;
         isAnyElementDisplayed = false;
      });
    }

    if (_lastDisplayedCateringIndex != -1) {
      setState(() {
        cateringVisibility[_lastDisplayedCateringIndex] = false;
        isAnyElementDisplayed = false;

      });
    }

    if (_lastDisplayedTransportIndex != -1) {
      for (int i = 0;
      i < transportMarkers[_lastDisplayedTransportIndex].length;
      i++) {
        setState(() {
          transportMarkersVisibility[_lastDisplayedTransportIndex][i] = false;
          isAnyElementDisplayed = false;

        });
      }
    }

    if (_lastDisplayedBuildingIndex != -1) {
      for (int i = 0;
      i < buildingMarkers[_lastDisplayedBuildingIndex].length;
      i++) {
        setState(() {
          builMarkersVisibility[_lastDisplayedBuildingIndex][i] = false;
          isAnyElementDisplayed = false;
        });
      }
    }

    if (_lastDisplayedCateringIndex != -1) {
      for (int i = 0;
      i < cateringMarkers[_lastDisplayedCateringIndex].length;
      i++) {
        setState(() {
          cateringMarkersVisibility[_lastDisplayedCateringIndex][i] = false;
          isAnyElementDisplayed = false;

        });
      }
    }

    if (_lastDisplayedATMsIndex != -1) {
      setState(() {
        ATMsMarkersVisibility[_lastDisplayedATMsIndex] = false;
        isAnyElementDisplayed = false;

      });
    }

    if (_lastDisplayedParksIndex != -1) {
      setState(() {
        parksMarkersVisibility[_lastDisplayedParksIndex] = false;
        isAnyElementDisplayed = false;
      });
    }
  }
}
