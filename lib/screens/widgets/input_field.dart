
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';

class InputField extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged? onChanged;

  const InputField({
    super.key,
    this.icon,
    this.onChanged,
    required  this.controller,
    required this.hintText  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration:  BoxDecoration(
        color: ColorsConst.secondColor,
       // color: Color(0xFFf3f3f3),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: hintText,
            prefixIcon: icon!=null ? const ImageIcon(
              AssetImage('assets/icons/search_1.png'),
              color: Colors.black87,
            ): null,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6D6D6D),
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ),
    );
  }
}
