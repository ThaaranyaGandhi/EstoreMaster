import 'package:flutter/material.dart';
import 'package:fresh_store_ui/network/models/address.dart';
import 'package:line_icons/line_icons.dart';

import 'add_address.dart';

class MyAddressIem extends StatelessWidget {
  final Address address;
  const MyAddressIem({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        trailing: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pushNamed(context, AddAddressScreen.route(), arguments: address);
          }, icon: const Icon(LineIcons.editAlt)),
        tileColor: const Color(0xFFeeeeee),
        contentPadding: const EdgeInsets.fromLTRB(20, 12, 0, 12),
        title: Text(address.name),
        subtitle: Text('${address.no}, ${address.society}, ${address.area}, ${address.landmark}, ${address.pincode}')));
  }
}