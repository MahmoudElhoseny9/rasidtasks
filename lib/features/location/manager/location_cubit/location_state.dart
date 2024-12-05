part of 'location_cubit.dart';

class LocationState {
  final Map<String, dynamic> posetion;
  final String errMessage;
  final bool isLoading;
  final String address;

  LocationState({
    required this.posetion,
    required this.errMessage,
    required this.isLoading,
    required this.address,
  });

  LocationState copyWith({
    final Map<String, dynamic>? posetion,
    final String? errMessage,
    final bool? isLoading,
    final String? address,
  }) {
    return LocationState(
      posetion: posetion ?? this.posetion,
      errMessage: errMessage ?? this.errMessage,
      isLoading: isLoading ?? this.isLoading,
      address: address ?? this.address,
    );
  }
}
