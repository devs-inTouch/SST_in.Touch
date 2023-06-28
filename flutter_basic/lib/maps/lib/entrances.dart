import 'package:google_maps_flutter/google_maps_flutter.dart';

class Entrances {
  static const Marker edIP = Marker(
      markerId: MarkerId('EdI_principal'),
      infoWindow: InfoWindow(title: 'Edifício I', snippet: 'Entrada principal'),
      position: LatLng(38.6611646, -9.2055584));

  static const Marker edILat = Marker(
      markerId: MarkerId('EdI_lateral'),
      infoWindow: InfoWindow(title: 'Edifício I', snippet: 'Entrada lateral'),
      position: LatLng(38.6611646, -9.2055584));

  static const Marker edIIP = Marker(
      markerId: MarkerId('EdII_principal'),
      infoWindow:
          InfoWindow(title: 'Edifício II', snippet: 'Entrada principal'),
      position: LatLng(38.6606318, -9.2035532));

  static const Marker edIIMat = Marker(
      markerId: MarkerId('EdII_DepMat'),
      infoWindow: InfoWindow(
          title: 'Edifício II', snippet: 'Entrada Departamento Materiais'),
      position: LatLng(38.66122, -9.20406));

  static const Marker edIIS = Marker(
      markerId: MarkerId('EdII_Secretaria'),
      infoWindow: InfoWindow(
          title: 'Edifício II', snippet: 'Entrada Secretaria de Informáticas'),
      position: LatLng(38.66141, -9.2037));

  static const Marker edIILAtI = Marker(
      markerId: MarkerId('EdII_LatI'),
      infoWindow:
          InfoWindow(title: 'Edifício II', snippet: 'Entrada lateral esquerda'),
      position: LatLng(38.66148, -9.20351));

  static const Marker edIILatII = Marker(
      markerId: MarkerId('EdII_LatII'),
      infoWindow:
          InfoWindow(title: 'Edifício II', snippet: 'Entrada lateral direita'),
      position: LatLng(38.66108, -9.20302));

  static const Marker edVIIP = Marker(
      markerId: MarkerId('EdI_principal'),
      infoWindow:
          InfoWindow(title: 'Edifício VII', snippet: 'Entrada principal'),
      position: LatLng(38.6607772, -9.2058718));

  static const Marker edVIIT = Marker(
      markerId: MarkerId('EdVII_traseiras'),
      infoWindow:
          InfoWindow(title: 'Edifício VII', snippet: 'Entrada traseira'),
      position: LatLng(38.6606108, -9.2058339));

  static const Marker edX = Marker(
      markerId: MarkerId('EdX'),
      infoWindow: InfoWindow(title: 'Edifício X', snippet: 'Entrada principal'),
      position: LatLng(38.6607931, -9.2048974));

  static const Marker convivioP = Marker(
      markerId: MarkerId('Convivio_principal'),
      infoWindow: InfoWindow(title: 'Convívio', snippet: 'Entrada principal'),
      position: LatLng(38.6611697, -9.20492));

  static const Marker convivioLatE = Marker(
      markerId: MarkerId('Convivio_LatE'),
      infoWindow: InfoWindow(title: 'Convívio', snippet: 'Entrada lateral'),
      position: LatLng(38.6614186, -9.2049861));

  static const Marker convivioLatD = Marker(
      markerId: MarkerId('Convivio_LatD'),
      infoWindow: InfoWindow(title: 'Convívio', snippet: 'Entrada lateral'),
      position: LatLng(38.6614227, -9.204801));

  static const Marker biblioteca = Marker(
      markerId: MarkerId('Biblioteca'),
      infoWindow: InfoWindow(title: 'Biblioteca', snippet: 'Entrada principal'),
      position: LatLng(38.6625867, -9.2051878));

  static const Marker departamental = Marker(
      markerId: MarkerId('Departamental'),
      infoWindow:
          InfoWindow(title: 'Departamental', snippet: 'Entrada principal'),
      position: LatLng(38.6625998, -9.2075194));
}
