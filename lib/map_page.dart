import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapWithGeoJSON extends StatefulWidget {
  const MapWithGeoJSON({super.key});

  @override
  _MapWithGeoJSONState createState() => _MapWithGeoJSONState();
}

class _MapWithGeoJSONState extends State<MapWithGeoJSON> {

  GeoJsonParser myGeoJson = GeoJsonParser();

  @override
  void initState() {
    super.initState();
    fetchGeoJSONData();
  }
    final List<Polygon> polygons = [];

  void onTapMarkerFunction(Map<String, dynamic> map) {
    print('Makrnsyaaaaaa nihh: $map');
  }

  Future<void> fetchGeoJSONData() async {

    final response = await http.get(Uri.parse('https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_110m_admin_1_states_provinces_shp.geojson'));
    

 myGeoJson.parseGeoJsonAsString(response.body);
    myGeoJson.setDefaultMarkerTapCallback(onTapMarkerFunction);
 
 // parse GeoJson data - GeoJson is stored as [String]

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GEO JSON COYY'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37.399458, -92.891637),
          zoom: 5.0,
        ),
        children: [
            TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c']),
                PolygonLayer(polygons: myGeoJson.polygons),
            PolylineLayer(polylines: myGeoJson.polylines),
            MarkerLayer(markers: myGeoJson.markers)
          ],
      ),
    );
  }
}
