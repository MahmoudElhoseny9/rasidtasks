import 'package:flutter/material.dart';
import 'package:rasidtasks/core/utils/colors.dart';

class LatLngSearchForm extends StatefulWidget {
  const LatLngSearchForm(
      {super.key,
      required this.latitudeController,
      required this.longitudeController,
      this.handleSearch});
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final void Function()? handleSearch;

  @override
  State<LatLngSearchForm> createState() => _LatLngSearchFormState();
}

class _LatLngSearchFormState extends State<LatLngSearchForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.latitudeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Latitude',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter latitude';
              }
              double? lat = double.tryParse(value);
              if (lat == null || lat < -90 || lat > 90) {
                return 'Latitude must be between -90 and 90';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.longitudeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Longitude',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter longitude';
              }
              double? lng = double.tryParse(value);
              if (lng == null || lng < -180 || lng > 180) {
                return 'Longitude must be between -180 and 180';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: widget.handleSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
