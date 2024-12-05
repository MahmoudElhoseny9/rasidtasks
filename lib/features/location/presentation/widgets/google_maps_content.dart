import 'package:flutter/material.dart';
import 'package:rasidtasks/core/utils/colors.dart';

class GoogleMapsContent extends StatelessWidget {
  final TextEditingController searchController;
  final void Function()? onPress;
  const GoogleMapsContent(
      {super.key, required this.searchController, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Enter google maps link',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text('Search'),
        ),
      ],
    );
  }
}
