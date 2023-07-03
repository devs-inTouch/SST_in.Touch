import 'package:google_maps_flutter/google_maps_flutter.dart';

class Parks {
  static final Marker departamental = Marker(
    markerId: const MarkerId('Departamental'),
    position: const LatLng(38.6630312, -9.2082881),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );
  static final Marker DepInformatica = Marker(
    markerId: const MarkerId('Departamento de Informatica'),
    position: const LatLng(38.6622897, -9.2035236),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );
  static final Marker sportClub = Marker(
    markerId: const MarkerId('sportClub'),
    position: const LatLng(38.6591732, -9.2042961),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );
  static final Marker FCTDromedo = Marker(
    markerId: const MarkerId('FCTDromedo'),
    position: const LatLng(38.6592905, -9.2056908),
    infoWindow: const InfoWindow(
      title: 'Google FCT',
      snippet: 'Google teste',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );
}
