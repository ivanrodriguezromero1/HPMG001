import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hpmg001/models/scenery/screen.dart';
import 'package:xml/xml.dart' as xml;

class Xml {
  static Future<List<List<Vector2>>> createBodiesFromXml() async {
    final polygons = <List<Vector2>>[];
    final String xmlString = await rootBundle.loadString('assets/xml/path.xml');
    final document = xml.XmlDocument.parse(xmlString);
    final bodyElement = document.findAllElements('body').first;
    final fixtureElement = bodyElement.findAllElements('fixture').first;
    final polygonsElements  = fixtureElement.findAllElements('polygon');
    double minX = double.infinity;
    double maxY = -double.infinity;
    for (final polygon in polygonsElements) {
      final vertexes = polygon.findAllElements('vertex');
      final polygonVertices = <Vector2>[];
      for (final vertex in vertexes) {
        final xAttribute = vertex.getAttribute('x');
        final yAttribute = vertex.getAttribute('y');
        if (xAttribute != null && yAttribute != null) {
          final x = double.parse(xAttribute)*334.4/2452;
          final y = double.parse(yAttribute)*39.3/288;
          minX = min(minX, x);
          maxY = max(maxY, y);
          polygonVertices.add(Vector2(x, y));
        }
      }
      polygons.add(polygonVertices);
    }
    return polygons.map((polygon) {
        return polygon.map((vertex) => vertex - Vector2(minX, maxY - Screen.worldSize.y)).toList();
    }).toList();
  }
}
