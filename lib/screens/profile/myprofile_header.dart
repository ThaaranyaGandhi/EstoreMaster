import 'package:flutter/material.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:line_icons/line_icons.dart';

class MyProfileHeader extends StatelessWidget {
  const MyProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24, right: 12),
          child: Row(
            children: [
              // Image.asset('assets/icons/profile/logo@2x.png', scale: 2),
              // const SizedBox(width: 16),
              Expanded(
                child: Text('My Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              // IconButton(
              //   iconSize: 28,
              //   icon: const Icon(LineIcons.edit),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
        const SizedBox(height: 30),
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
        const SizedBox(height: 12),
        Text(LocalDB.getUserName() ?? 'Guest', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 8),
        if(LocalDB.getMobile()!=null)
         Text(LocalDB.getMobile() ?? '99 300 00 00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
