import 'package:flutter/material.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/screens/profile/myprofile_header.dart';



class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  static String route()=>'/myProfile';

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: MyProfileHeader(),
              ),
            ]),
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 6,),
                Text(LocalDB.getUserName(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16,),
                const Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 6,),
                Text(LocalDB.getEmail(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16,),
                const Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 6,),
                Text(LocalDB.getMobile(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16,),
              ],
            );
          },
          childCount: 1,
        ),
      ),
    );
  }
}