import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit()
      : super(LocationState(
            posetion: {}, errMessage: '', isLoading: false, address: ''));

  Future<void> getCurrentPosition() async {
    emit(state.copyWith(isLoading: true));
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(errMessage: 'Location services are disabled.'));
        // return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(errMessage: 'Location permissions are denied'));
          // return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(
            errMessage:
                'Location permissions are permanently denied, we cannot request permissions.'));

        // return Future.error(
        //     'Location permissions are permanently denied, we cannot request permissions.');
      }
      var posetion = await Geolocator.getCurrentPosition();
      await getAddressFromCoordinates(posetion.latitude, posetion.longitude);
    } on Exception catch (e) {
      emit(state.copyWith(errMessage: e.toString()));
    }
  }

  Future<void> getAddressFromCoordinates(
      double latitude, double longitude) async {
    emit(state.copyWith(isLoading: true));
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        emit(
          state.copyWith(posetion: {
            'latitude': latitude,
            'longitude': longitude,
          }, address: '${place.street}, ${place.locality}, ${place.country}'),
        );
      }
    } catch (e) {
      emit(state.copyWith(errMessage: e.toString()));
    }
  }

  Future<void> getAddressFromGoogleMaps(String url) async {
    emit(state.copyWith(isLoading: true));
    try {
      final coordinates = _extractCoordinates(url);
      if (coordinates != null) {
        await getAddressFromCoordinates(
            coordinates['Latitude'], coordinates['Longitude']);
      } else {
        emit(state.copyWith(errMessage: 'Invalid Google Maps link'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(errMessage: e.toString()));
    }
  }

  Map<String, dynamic>? _extractCoordinates(String url) {
    final RegExp regex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final match = regex.firstMatch(url);
    if (match != null) {
      final latitude = match.group(1);
      final longitude = match.group(2);
      return {'Latitude':  double.parse(latitude!), 'Longitude': double.parse(longitude!)};
    }
    return null;
  }
}
