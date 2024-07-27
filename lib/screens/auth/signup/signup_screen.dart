import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/screens/auth/bloc/auth_bloc.dart';
import 'package:fresh_store_ui/screens/auth/login/login.dart';

import '../../../constants/assets_const.dart';
import '../../../constants/colors_const.dart';
import '../../../resources/toast.dart';
import '../../widgets/input_field.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static String route() => '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // if(state is SignupSuccess){
        //   toast('Register successfull!', success: true);
        //   Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route(), (route) => false);
        // }else{
        //   toast('Register failed! Try again later.', success: true);
        // }
      },
      child: SafeArea(
        child: Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                       //   padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                children: [
                  Image.asset(
                    AssetsConst.appLogo,
                    height: 180,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   const Text("Let's get started !",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:  ColorsConst.firstColor),),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text('Create an account to use all features',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    controller: nameController,
                    icon: Icons.person_outline,
                    hintText: 'Enter name',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InputField(
                    controller: emailController,
                    icon: Icons.email_outlined,
                    hintText: 'Enter email address',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildMobileField(),
                  const SizedBox(
                    height: 24,
                  ),
                  InputField(
                    controller: passwordController,
                    icon: Icons.lock_outline,
                    hintText: 'Enter password',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildAddCard(),
                  const SizedBox(
                    height: 34,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account ?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.route());
                        },
                        child: const Text('Login',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold, color:  ColorsConst.firstColor)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color:  ColorsConst.secondColor /*Color(0xFFF3F3F3)*/,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: 1,
                      items: [
                        1,
                      ]
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  '+${e.toString()}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF212121),
                                  ),
                                ),
                              )))
                          .toList(),
                      isExpanded: false,
                      onChanged: (value) {
                        if (value != null) {}
                      }),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: InputField(
            controller: mobileController,
            icon: Icons.phone_android_outlined,
            hintText: 'Enter mobile number',
          ),
        )
      ],
    );
  }

  buildAddCard() => Container(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          color:  ColorsConst.firstColor/*const Color(0xFF101010)*/,
          border: Border.all(color: Colors.black87, width: 1),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 8),
              blurRadius: 20,
              color: const Color(0xFF101010).withOpacity(0.25),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            // splashColor: const Color(0xFFEEEEEE),
            onTap: () {
              // context.read<AuthBloc>().add(CreateAccount(
              //     email: emailController.text,
              //     password: passwordController.text,
              //     name: nameController.text,
              //     mobileNumber: mobileController.text));
              callService();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.create, color: ColorsConst.black),
                SizedBox(width: 10),
                Text(
                  'Signup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      );


  void callService()async{
    showLoaderDialog(context);
    Post newPost = new Post(name: nameController.text, email: emailController.text, password: passwordController.text, mobile: mobileController.text, ccode: '+1', imei: 'abcd');
    log(newPost.toString());
     // await createPost('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/new_register.php',
     await createPost('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/new_register.php',
        body: newPost.toMap());
  }

  Future<Post> createPost(String url, {required Map body}) async {
    return http.post(Uri.parse(url), body: body).then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        log(response.statusCode.toString());
        throw new Exception("Error while fetching data");
      }
      log(response.statusCode.toString());
      if(response.body.contains("successfully")){
        log('aaa');
      }else{
        log('bbb');
      }
      log("sss - ${ response.body}" );
      var jsonList = jsonDecode(response.body);

      if(jsonList['success']){
        log('1111');
      }else{
        log('222');
      }

   //   Navigator.of(context).pop();
   //   var jsonList = jsonDecode(response.body);
      if(jsonList['success'] )
        {
          log('inside');
          toast('Register successful!', success: true);
          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route(), (route) => false);
        }
      else
        {
          toast('Register failed! Try again later.', success: false);
        }
      log("Response:${response.body}");
      return Post.fromJson(json.decode(response.body));
    });
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white,),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      useRootNavigator: false,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}

class Post {
  final String name;
  final String email;
  final String password;
  final String mobile;
  final String ccode;
  final String imei;

  Post({required this.name,required this.email,required this.password,required this.mobile,required this.ccode,required this.imei});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      mobile: json['mobile'],
      ccode: json['ccode'],
      imei: json['imei'],
    );
  }

  Map toMap() {
    var map = new Map<String, String>();
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["mobile"] = mobile;
    map["ccode"] = ccode;
    map["imei"] = imei;

    log("Parameter:::${'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/new_register.php'}${map.toString()}");
    return map;
  }
}