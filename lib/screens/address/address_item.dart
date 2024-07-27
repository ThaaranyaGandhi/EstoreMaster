import 'package:flutter/material.dart';
import 'package:fresh_store_ui/network/models/address.dart';
import 'package:line_icons/line_icons.dart';

import 'add_address.dart';

class AddressIem extends StatelessWidget {
  final Address address;
  final String groupValue;
  final ValueChanged onChanged;

  const AddressIem({super.key, required this.address, required this.groupValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RadioListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        secondary: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pushNamed(context, AddAddressScreen.route(), arguments: address);
          }, icon: const Icon(LineIcons.editAlt)),
        tileColor: const Color(0xFFeeeeee),
        value: address.name,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        title: Text(address.name),
        subtitle: Text('${address.no}, ${address.society}, ${address.area}, ${address.landmark}, ${address.pincode}'),
        groupValue: groupValue,
        onChanged: onChanged),
    );
  }
}