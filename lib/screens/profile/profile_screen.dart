import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/screens/address/my_address.dart';
import 'package:fresh_store_ui/screens/auth/login/login.dart';
import 'package:fresh_store_ui/screens/profile/header.dart';
import 'package:fresh_store_ui/screens/profile/view_profile.dart';
import 'package:fresh_store_ui/screens/webview/html.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import '../../global.dart';
import '../address/bloc/address_bloc.dart';
import '../address/my_addressnew.dart';
import '../home/Contactus.dart';

typedef ProfileOptionTap = void Function();

class ProfileOption {
  String title;
  String icon;
  IconData? iconData;
  Color? titleColor;
  ProfileOptionTap? onClick;
  Widget? trailing;

  ProfileOption({
    required this.title,
    required this.icon,
    this.onClick,
    this.iconData,
    this.titleColor,
    this.trailing,
  });

  ProfileOption.arrow({
    required this.title,
    required this.icon,
    this.iconData,
    this.onClick,
    this.titleColor = const Color(0xFF212121),
    this.trailing = const Image(
        image: AssetImage('assets/icons/profile/arrow_right@2x.png'),
        width: 24,
        height: 24),
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String route() => '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static _profileIcon(String last) => 'assets/icons/profile/$last';

  bool _isDark = false;

  get datas => <ProfileOption>[
        if (LocalDB.getUserName() != null)
          ProfileOption.arrow(
              title: 'View Profile', icon: _profileIcon('show@2x.png')),
        ProfileOption.arrow(
            title: 'Address', icon: _profileIcon('location@2x.png')),
        // ProfileOption.arrow(title: 'Notification', icon: _profileIcon('notification@2x.png')),
        // ProfileOption.arrow(title: 'Payment', icon: _profileIcon('wallet@2x.png')),
        ProfileOption.arrow(
            title: 'Contact us', icon: '', iconData: LineIcons.envelope),
        ProfileOption.arrow(
            title: 'Share', icon: '', iconData: LineIcons.share),
        ProfileOption.arrow(
            title: 'About', icon: _profileIcon('info_square@2x.png')),
        ProfileOption.arrow(
            title: 'Privacy Policy', icon: _profileIcon('shield_done@2x.png')),
        ProfileOption.arrow(
            title: 'Terms and Conditions', icon: '', iconData: LineIcons.check),
        if (LocalDB.getLogin() != null && LocalDB.getLogin())
          ProfileOption.arrow(
              title: 'Delete Account', icon: '', iconData: Icons.delete),
        // _languageOption(),
        // _darkModel(),
        // ProfileOption.arrow(title: 'Invite Friends', icon: _profileIcon('user@2x.png')),
        ProfileOption(
          title: LocalDB.getLogin() != null && LocalDB.getLogin()
              ? 'Logout'
              : 'Login',
          icon: _profileIcon('logout@2x.png'),
          titleColor: const Color(0xFFF75555),
        ),
      ];

  _languageOption() => ProfileOption(
      title: 'Language',
      icon: _profileIcon('more_circle@2x.png'),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'English (US)',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF212121)),
            ),
            const SizedBox(width: 16),
            Image.asset('assets/icons/profile/arrow_right@2x.png', scale: 2)
          ],
        ),
      ));

  _darkModel() => ProfileOption(
      title: 'Dark Mode',
      icon: _profileIcon('show@2x.png'),
      trailing: Switch(
        value: _isDark,
        activeColor: const Color(0xFF212121),
        onChanged: (value) {
          setState(() {
            _isDark = !_isDark;
          });
        },
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverList(
            delegate: SliverChildListDelegate.fixed([
              ProfileHeader(),
            ]),
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final data = datas[index];
            return _buildOption(context, index, data);
          },
          childCount: datas.length,
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index, ProfileOption data) {
    return ListTile(
      leading: data.iconData != null
          ? Icon(
              data.iconData!,
              color: ColorsConst.firstColor,
            )
          : Image.asset(
              data.icon,
              scale: 2,
              color: ColorsConst.firstColor,
            ),
      title: Text(
        data.title,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: data.titleColor),
      ),
      trailing: data.trailing,
      onTap: () {
        switch (data.title) {
          case 'Login':
            Navigator.pushNamed(context, LoginScreen.route());
            break;
          case 'Logout':
            LocalDB.clearDB();
           // Navigator.pushNamed(context, LoginScreen.route());
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route(), (route) => false);
            break;
          case 'Share':
            Share.share(
                'Let me recommend you this application\nhttps://apps.apple.com/us/app/sk-paper-products/id6463164842');
            break;
          case 'Privacy Policy':
            Navigator.pushNamed(context, HtmlScreen.route(),
                arguments: Global.mainData?.privacyPolicy);
            break;
          case 'About':
            Navigator.pushNamed(context, HtmlScreen.route(),
                arguments: Global.aboutus);
            break;
          case 'Terms and Conditions':
            Navigator.pushNamed(context, HtmlScreen.route(),
                arguments: Global.termsAndConditions);
            break;
          case 'Address':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAddressScreenNew()),
            );
            break;
          case 'View Profile':
            Navigator.pushNamed(context, ViewProfileScreen.route());
            break;
          case 'Contact us':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => contactusScreen()),
            );
            break;
          case 'Delete Account':
            callService();
        }
      },
    );
  }

  void callService() async {
    (Loading());
    Post newPost = new Post(uid: LocalDB.getUserid().toString());
    Post postRequest = await createPost(
        'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/delete_user.php',
        body: newPost.toMap());
  }

  Future<Post> createPost(String url, {required Map body}) async {
    return http
        .post(Uri.parse(url), body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(response.statusCode);
        throw new Exception("Error while fetching data");
      }
      print(response.statusCode);
      print("sss" + response.body);
      //final MaOtp = LaunchSubmitModelFromJson(response.body);
      LocalDB.clearDB();
      Navigator.pushNamed(context, LoginScreen.route());
      print("Response:${response.body}");
      return Post.fromJson(json.decode(response.body));
    });
  }
}

class Post {
  final String uid;

  Post({required this.uid});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uid: json['uid'],
    );
  }

  Map toMap() {
    var map = new Map<String, String>();
    map["uid"] = uid;
    //print("Parameter:::${LocalStrings.SubmitLaunchPost}${map.toString()}");
    return map;
  }
}
