import 'dart:convert';
import 'package:http/http.dart' as http;

// API Reference  https://developers.google.com/maps/documentation/geocoding/overview?hl=ja

const String geoCodingApiRoute =
    "https://maps.googleapis.com/maps/api/geocode/json";
const String apiKey = "";

class ReverseGeoCoding {
  final Map<String, dynamic> geoData;

  ReverseGeoCoding({
    required this.geoData,
  });

  factory ReverseGeoCoding.fromJson(Map<String, dynamic>? json) {
    if (json == null || json['plus_code'] == null) {
      return ReverseGeoCoding(geoData: {});
    }
    return ReverseGeoCoding(
      geoData: Map<String, dynamic>.from(json['plus_code']),
    );
  }
}

Future<ReverseGeoCoding> fetchReverseGeoCoding(String latitude, String longitude) async {
  final res = await http
      .get(Uri.parse('$geoCodingApiRoute?latlng=$latitude,$longitude&language=en&key=$apiKey'));
  if (res.statusCode == 200) {
    return ReverseGeoCoding.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load ReverseGeoCoding');
  }
}
