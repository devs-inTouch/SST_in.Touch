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

  static const Marker solucao = Marker(
      markerId: MarkerId('Solução'),
      infoWindow: InfoWindow(title: 'Solução', snippet: 'Entrada'),
      position: LatLng(38.6614252, -9.2051368));

  static const Marker mini_nova = Marker(
      markerId: MarkerId('Mini-Nova'),
      infoWindow: InfoWindow(title: 'Mini-Nova', snippet: 'Entrada'),
      position: LatLng(38.6613885, -9.2053594));

  static const Marker casaPessoal = Marker(
      markerId: MarkerId('casaPessoal'),
      infoWindow: InfoWindow(title: 'Casa do Pessoal', snippet: 'Entrada'),
      position: LatLng(38.6617474, -9.2054718));

  static const Marker mySpot = Marker(
      markerId: MarkerId('mySpot'),
      infoWindow: InfoWindow(title: 'MySpot', snippet: 'Entrada'),
      position: LatLng(38.6604851, -9.2056921));

  static const Marker cantina = Marker(
      markerId: MarkerId('cantina'),
      infoWindow: InfoWindow(title: 'Cantina', snippet: 'Entrada'),
      position: LatLng(38.6615049, -9.204734));

  static const Marker tantoFaz = Marker(
      markerId: MarkerId('tantoFaz'),
      infoWindow: InfoWindow(title: 'Tanto Faz', snippet: 'Entrada'),
      position: LatLng(38.6615252, -9.2067804));

  static const Marker paragemMetro = Marker(
      markerId: MarkerId('paragemMetro'),
      infoWindow: InfoWindow(title: 'Paragem de metro'),
      position: LatLng(38.663525, -9.2074946));

  static const Marker paragemAutocarroI = Marker(
      markerId: MarkerId('paragemAutocarro'),
      infoWindow: InfoWindow(title: 'Paragem de Autocarro'),
      position: LatLng(38.6604378, -9.2026715));

  static const Marker paragemAutocarroII = Marker(
      markerId: MarkerId('paragemAutocarro'),
      infoWindow: InfoWindow(title: 'Paragem de Autocarro'),
      position: LatLng(38.6592173, -9.2028349));

  static const Marker paragemAutocarroIII = Marker(
      markerId: MarkerId('paragemAutocarro'),
      infoWindow: InfoWindow(title: 'Paragem de Autocarro'),
      position: LatLng(38.6638168, -9.2066822));
}
