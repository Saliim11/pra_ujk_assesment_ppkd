import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/geo/geo_service.dart';

class LocationProvider with ChangeNotifier {
  String _lokasi = "unknown";
  String get lokasi => _lokasi;

  String _jalan = "";
  String _kelurahan = "";
  String _kecamatan = "";
  String _kota = "";
  String _provinsi = "";
  String _negara = "";
  String _kodePos = "";

  String get jalan => _jalan;
  String get kelurahan => _kelurahan;
  String get kecamatan => _kecamatan;
  String get kota => _kota;
  String get provinsi => _provinsi;
  String get negara => _negara;
  String get kodePos => _kodePos;

  Future<void> ambilLokasi() async {
    Position? posisi = await GeoService().determineUserLocation();

    if (posisi != null) {
      // print("Latitude: ${posisi.latitude}");
      // print("Longitude: ${posisi.longitude}");
      // _lokasi = "${posisi.latitude}, ${posisi.longitude}";

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(posisi.latitude, posisi.longitude);

        if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        _lokasi =
               "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}, ${place.country}, ${place.isoCountryCode}";
               
        _jalan = place.street!;
        _kelurahan = place.subLocality!;
        _kecamatan = place.locality!;
        _kota = place.subAdministrativeArea!;
        _provinsi = place.administrativeArea!;
        _negara = "${place.country}, ${place.isoCountryCode}";
        _kodePos = place.postalCode!;

        notifyListeners();
      }

      } catch (e) {
        print("Error reverse geocoding: $e");
      }

    } else {
      // Tampilkan snackbar atau alert jika lokasi gagal diambil
      print("Lokasi tidak tersedia.");
    }
  }
}