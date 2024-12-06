import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rasidtasks/core/utils/dialog.dart';
import 'package:rasidtasks/features/location/manager/location_cubit/location_cubit.dart';
import 'package:rasidtasks/features/location/presentation/widgets/address_display_widget.dart';
import 'package:rasidtasks/features/location/presentation/widgets/google_maps_content.dart';
import 'package:rasidtasks/features/location/presentation/widgets/lat_lng_search_form.dart';

class GeoHomePage extends StatefulWidget {
  static const String routeName = '/locationScreen';
  const GeoHomePage({
    super.key,
  });

  @override
  State<GeoHomePage> createState() => _GeoHomePageState();
}

class _GeoHomePageState extends State<GeoHomePage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final _key = GlobalKey<ExpandableFabState>();

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state.errMessage.isNotEmpty) {
            showCustomDialog(context, state.errMessage);
          }
          if (state.posetion.isNotEmpty) {
            _mapController.move(
              LatLng(state.posetion['latitude'], state.posetion['longitude']),
              13,
            );
          }
        },
        builder: (context, state) {
          return mapBody(state);
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: expandFab(context),
    );
  }

  Widget mapBody(LocationState state) {
    return SafeArea(
      child: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: LatLng(0, 0),
          initialZoom: 4,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          if (state.posetion.isNotEmpty)
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(
                      state.posetion['latitude'], state.posetion['longitude']),
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          if (state.address.isNotEmpty)
            Align(
              alignment: const Alignment(0, 0.4),
              child: AddressDisplayWidget(address: state.address),
            )
        ],
      ),
    );
  }

  Widget expandFab(BuildContext context) {
    return ExpandableFab(
      key: _key,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.menu),
        fabSize: ExpandableFabSize.regular,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.small,
        shape: const CircleBorder(),
      ),
      children: [
        // Get Location from Coordinates
        FloatingActionButton(
          onPressed: () async {
            showCustomBottomSheet(
                context,
                LatLngSearchForm(
                  latitudeController: _latitudeController,
                  longitudeController: _longitudeController,
                  handleSearch: () async {
                    Navigator.pop(context);
                    await context
                        .read<LocationCubit>()
                        .getAddressFromCoordinates(
                            double.parse(_latitudeController.text),
                            double.parse(_longitudeController.text));
                    _latitudeController.clear();
                    _longitudeController.clear();
                  },
                ));
          },
          heroTag: null,
          child: const Icon(Icons.add_location),
        ),
        // Google maps
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            showCustomBottomSheet(
              context,
              GoogleMapsContent(
                searchController: _searchController,
                onPress: () async {
                  Navigator.pop(context);
                  await context
                      .read<LocationCubit>()
                      .getAddressFromGoogleMaps(_searchController.text);
                  _searchController.clear();
                },
              ),
            );
          },
          child: const Icon(Icons.link),
        ),
        // Get Current Location

        FloatingActionButton(
          heroTag: null,
          onPressed: () async {
            await context.read<LocationCubit>().getCurrentPosition();
          },
          child: const Icon(Icons.my_location),
        ),
      ],
    );
  }
}
