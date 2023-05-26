import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(38.661555, -9.205579),
      zoom: 15.5
  );

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marker = Set<Marker>();
  int id = 1;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  /*@override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body:Column(
        children: [
          Row(
            children: [
              Expanded(child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: "Insere local"),
                onChanged: (value) {
                  print(value);
                },
              )
              ),
              IconButton(
                  onPressed: () async {
                    var place = await LocationService().getPlace(_searchController.text);
                    _goToPlace(place);
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          Expanded(child: GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            onTap: (LatLng latLng) {
              Marker origin = Marker(
                  markerId: MarkerId("$id"),
                  position: LatLng(latLng.latitude, latLng.longitude),
                  infoWindow: InfoWindow(title: "Origin"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed)
              );
              _marker.add(origin);
              id++;
              if(id > 2) {
                _marker = _marker.take(2).toSet();
                id = 2;
              }
              setState(() {

              });

            },
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
            markers: _marker.map((e) => e).toSet(),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: _goToOrigin,
        child: const Icon(Icons.center_focus_strong),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,);
  }

  Future<void> _goToOrigin() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place["geometry"]["location"]["lat"];
    final double lng = place["geometry"]["location"]["lng"];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(lat, lng),
              zoom: 12)
      ),
    );
  }

/*Future<void> getDirections() async {
    final apiKey = googleAPIKey;
    final origin = _marker.first; // Replace with your origin coordinates
    final destination = _marker.last; // Replace with your destination coordinates

    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Process the data and extract the route information as needed
      // Example: Extract the polyline points for drawing the route on the map
      final points = data['routes'][0]['overview_polyline']['points'];
      final decodedPoints = _decodePolyline(points);
      final routeCoordinates = decodedPoints.map((point) {
        return LatLng(point[0], point[1]);
      }).toList();

      // Display the route on the map using a Polyline
      setState(() {
      });
    } else {
      // Handle the error
      print('Error: ${response.statusCode}');
    }
  }

  List<List<double>> _decodePolyline(String encoded) {
    final List<List<double>> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      final LatLng p = LatLng(lat / 1E5, lng / 1E5);
      poly.add([p.latitude, p.longitude]);
    }
    return poly;
  }*/

}