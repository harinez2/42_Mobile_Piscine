import 'dart:convert';
import 'package:http/http.dart' as http;

const int maxId = 1010;
const String geoCodingApiRoute = "https://geocoding-api.open-meteo.com/v1/search";

class GeoCoding {
  final String name;
  final int count;
  final String format;
  final String language;
  final String apikey;

  GeoCoding({
    required this.name,
    required this.count,
    required this.format,
    required this.language,
    required this.apikey,
  });

  factory GeoCoding.fromJson(Map<String, dynamic> json) {
    return GeoCoding(
      name: json['name'],
      count: json['count'],
      format: json['format'],
      language: json['language'],
      apikey: json['apikey'],
    );
  }
}

Future<GeoCoding> fetchGeoCoding(String cityName) async {
  final res = await http.get(Uri.parse('$geoCodingApiRoute?name=$cityName'));
    print(res.body);
  if (res.statusCode == 200) {
    return GeoCoding.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load GeoCoding');
  }
}
