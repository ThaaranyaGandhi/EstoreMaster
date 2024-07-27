import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: ColorsConst.secondColor,
        //    color: Color(0xFFf3f3f3),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Center(
        child: TextField(
          onChanged: (value) => log(value),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product...",
            prefixIcon: ImageIcon(
              AssetImage('assets/icons/search_1.png'),
              color: Colors.black87,
            ),
            /*Icon(Icons.search)*/
            hintStyle: TextStyle(
              fontSize: 16, color: Colors.black54,
              //  color: Color(0xFFBDBDBD),
            ),
            labelStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ),
    );
  }
}
