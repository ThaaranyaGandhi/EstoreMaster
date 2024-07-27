import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/db/local_db.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 85,
          width: double.infinity,
          color: ColorsConst.firstColor,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Profile',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Stack(
        //   children: [
        //     const CircleAvatar(
        //       radius: 60,
        //       backgroundImage: AssetImage('assets/icons/me.png'),
        //     ),
        //     Positioned.fill(
        //       child: Align(
        //         alignment: Alignment.bottomRight,
        //         child: InkWell(
        //           child: Image.asset('assets/icons/profile/edit_square@2x.png', scale: 2),
        //           onTap: () {},
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        Text(
          LocalDB.getUserName() ?? 'Guest',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: ColorsConst.firstColor),
        ),
        Text(
          LocalDB.getMobile() ?? '99 300 00 00',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          color: const Color(0xFFEEEEEE),
          height: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        )
      ],
    );
  }
}
