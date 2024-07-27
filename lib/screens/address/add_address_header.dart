import 'package:flutter/material.dart';


class AddAddressAppBar extends StatelessWidget {
  const AddAddressAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10, top: 30),
      child: Row(
        children: [
          // InkWell(
          //   borderRadius: const BorderRadius.all(Radius.circular(24)),
          //   onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
          //   child: const CircleAvatar(
          //     backgroundImage: AssetImage('$kIconPath/me.png'),
          //     radius: 24,
          //   ),
          // ),
          IconButton(
            icon: Image.asset('assets/icons/back@2x.png', scale: 2),
            onPressed: () => Navigator.pop(context),
          ),
         const Text(
                'Add Address',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
        ],
      ),
    );
  }
}
