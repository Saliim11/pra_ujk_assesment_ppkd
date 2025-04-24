import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/geo/geo_service.dart';

class LocationProvider with ChangeNotifier {
  String _lokasi = "unknown";
  String get lokasi => _lokasi;

  Future<void> ambilLokasi() async {
    Position? posisi = await GeoService().determineUserLocation();

    if (posisi != null) {
      print("Latitude: ${posisi.latitude}");
      print("Longitude: ${posisi.longitude}");
      _lokasi = "${posisi.latitude}, ${posisi.longitude}";

    } else {
      // Tampilkan snackbar atau alert jika lokasi gagal diambil
      print("Lokasi tidak tersedia.");
    }
  }
}