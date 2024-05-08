import 'package:geolocator/geolocator.dart';

class GeoLocator {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static String getDetailText(Position position) {
    return '''
position.longitude: ${position.longitude}
position.latitude: ${position.latitude}
position.timestamp: ${position.timestamp}
position.accuracy: ${position.accuracy}
position.altitude: ${position.altitude}
position.altitudeAccuracy: ${position.altitudeAccuracy}
position.heading: ${position.heading}
position.headingAccuracy: ${position.headingAccuracy}
position.speed: ${position.speed}
position.speedAccuracy: ${position.speedAccuracy}
position.floor: ${position.floor}
position.isMocked: ${position.isMocked}
    ''';
  }
}
