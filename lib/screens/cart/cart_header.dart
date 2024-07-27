import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10, /* top: 15*/
      ),
      child: Row(
        children: [
          IconButton(
            icon: Image.asset('assets/icons/back@2x.png', scale: 2),
            onPressed: () => Navigator.pop(context),
          ),
          // InkWell(
          //   borderRadius: const BorderRadius.all(Radius.circular(24)),
          //   onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
          //   child: const CircleAvatar(
          //     backgroundImage: AssetImage('$kIconPath/me.png'),
          //     radius: 24,
          //   ),
          // ),
          const Text(
            'My Cart',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            textAlign: TextAlign.start,
          ),
          // IconButton(
          //   iconSize: 28,
          //   icon: Image.asset('$kIconPath/notification.png'),
          //   onPressed: () {},
          // ),
          // const SizedBox(width: 16),
          // IconButton(
          //   iconSize: 28,
          //   icon: Image.asset('$kIconPath/light/heart@2x.png'),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
