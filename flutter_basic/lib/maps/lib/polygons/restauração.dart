import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restauracao {
  static const Polygon Tanto_Faz = Polygon(
    polygonId: PolygonId('Tanto_Faz'),
    points: [
      LatLng(38.6615108, -9.2068035),
      LatLng(38.6615412, -9.2067552),
      LatLng(38.6615632, -9.206778),
      LatLng(38.6616396, -9.206664),
      LatLng(38.6617757, -9.2068169),
      LatLng(38.661671, -9.2069792),
      LatLng(38.6615108, -9.2068035),
    ],
    //onTap creates a pop-up
    fillColor: Color.fromARGB(157, 38, 99, 156),
    strokeColor: Colors.teal,
    strokeWidth: 3,
  );

  static const Polygon Cantina = Polygon(
    polygonId: PolygonId('Cantina'),
    points: [
      LatLng(38.6616608, -9.2046702),
      LatLng(38.6616629, -9.2052428),
      LatLng(38.6614995, -9.2052401),
      LatLng(38.6614995, -9.2046742),
      LatLng(38.6614555, -9.2046715),
      LatLng(38.6614597, -9.2043134),
      LatLng(38.6615498, -9.2043148),
      LatLng(38.6615466, -9.2043724),
      LatLng(38.6615697, -9.2043724),
      LatLng(38.6615686, -9.2043134),
      LatLng(38.6616618, -9.2043148),
      LatLng(38.6616608, -9.2046702),
    ],
    fillColor: Color.fromARGB(157, 38, 99, 156),
    strokeColor: Colors.teal,
    strokeWidth: 3,
  );

  static const Polygon MySpot = Polygon(
    polygonId: PolygonId('MySpot'),
    points: [
      LatLng(38.660603, -9.205647),
      LatLng(38.6604951, -9.2056456),
      LatLng(38.6604961, -9.2055384),
      LatLng(38.6606051, -9.2055424),
      LatLng(38.660603, -9.205647),
    ],
    fillColor: Color.fromARGB(157, 38, 99, 156),
    strokeColor: Colors.teal,
    strokeWidth: 3,
  );

  static const Polygon Casa_Pessoal = Polygon(
    polygonId: PolygonId('Casa_Pessoal'),
    points: [
      LatLng(38.6618008, -9.2054684),
      LatLng(38.6617998, -9.2055972),
      LatLng(38.6616668, -9.2055958),
      LatLng(38.6616668, -9.2054644),
      LatLng(38.6618008, -9.2054684),
    ],
    fillColor: Color.fromARGB(157, 38, 99, 156),
    strokeColor: Colors.teal,
    strokeWidth: 3,
  );

  static const Polygon Biblioteca = Polygon(
    polygonId: PolygonId('Biblioteca'),
    points: [
      LatLng(38.6628048, -9.205137),
      LatLng(38.662809, -9.2054052),
      LatLng(38.6626478, -9.2054065),
      LatLng(38.6626425, -9.2051383),
      LatLng(38.6628048, -9.205137),
    ],
    fillColor: Color.fromARGB(157, 38, 99, 156),
    strokeColor: Colors.teal,
    strokeWidth: 3,
  );

  static const Polygon MiniNova = Polygon(
    polygonId: PolygonId('MiniNova'),
    points: [
      LatLng(38.6613864, -9.2054917),
      LatLng(38.6613026, -9.2054903),
      LatLng(38.6613037, -9.2053079),
      LatLng(38.6613874, -9.2053106),
      LatLng(38.6613864, -9.2054917),
    ],
    fillColor: Color.fromARGB(157, 38, 99, 156),
    strokeColor: Colors.teal,
    strokeWidth: 3,
  );

  static const Polygon Solucao = Polygon(
    polygonId: PolygonId('Solucao'),
    points: [
      LatLng(38.661422, -9.205143),
      LatLng(38.6614189, -9.2051014),
      LatLng(38.6614649, -9.2051014),
      LatLng(38.6614649, -9.205143),
      LatLng(38.661422, -9.205143),
    ],
    fillColor: Color.fromARGB(157, 38, 99, 156),
    strokeColor: Colors.teal,
    strokeWidth: 3,
  );
}
