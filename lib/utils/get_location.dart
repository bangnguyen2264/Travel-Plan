import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  String currentAddress = '';

  Future<void> determinePosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (currentAddress == '') {
      try {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw Exception('Location services are disabled');
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            throw Exception('Location permissions is denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          throw Exception('Location permissions is denied forever');
        }

        print('Get permission success');

        // int count = 0;
        // Position? position;
        // while (count < 3) {
        //   try {
        //     position = await Geolocator.getCurrentPosition(
        //       desiredAccuracy: LocationAccuracy.lowest,
        //       timeLimit: const Duration(seconds: 10),
        //     ).timeout(Duration(seconds: 10), onTimeout: () {
        //       throw Exception('Get location timeout');
        //     });
        //     print('Position: $position');
        //     break; // Break the loop if position retrieval is successful
        //   } catch (e) {
        //     print('Error fetching position: $e');
        //     count++;
        //   }
        // }
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest,
        );

        if (position == null) {
          throw Exception('Failed to retrieve position after 3 attempts');
        }
        print('Get position success');

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        print('Placemarks: $placemarks');
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          currentAddress =
              "${place.administrativeArea}, ${place.isoCountryCode}";
        } else {
          currentAddress = "No address found";
        }

        await prefs.setString('currentAddress', currentAddress);
      } catch (e) {
        print('Error fetching location: $e');
      }
    } else {
      String? address = prefs.getString('currentAddress');
      currentAddress = address ?? 'No address found';
    }
  }
}
