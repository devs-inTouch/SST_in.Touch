import 'package:google_maps_flutter/google_maps_flutter.dart';

class ATMs {
  static final Marker EdI = Marker(
    markerId: const MarkerId('EdI'),
    position: const LatLng(38.6611747, -9.2055894),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );

  static final Marker EdII = Marker(
    markerId: const MarkerId('EdII'),
    position: const LatLng(38.660927, -9.2035093),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );

  static final Marker Departamental = Marker(
    markerId: const MarkerId('Departamental'),
    position: const LatLng(38.6626081, -9.2075934),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );

  static final Marker Lidl = Marker(
    markerId: const MarkerId('Lidl'),
    position: const LatLng(38.659098, -9.2033212),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );
}
