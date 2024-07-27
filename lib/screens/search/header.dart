import 'package:flutter/material.dart';
import 'package:fresh_store_ui/screens/widgets/input_field.dart';


class SearchAppBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged onChanged;
  const SearchAppBar({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InputField(
      icon: Icons.search,
      onChanged: onChanged,
      controller: controller,
      hintText: 'Search here...',
    );
  }
}
