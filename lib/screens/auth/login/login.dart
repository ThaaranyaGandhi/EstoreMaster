import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/network/models/user.dart';
import 'package:fresh_store_ui/resources/toast.dart';
import 'package:fresh_store_ui/screens/address/address.dart';
import 'package:fresh_store_ui/screens/auth/signup/signup_screen.dart';
import 'package:fresh_store_ui/screens/tabbar/tabbar.dart';
import 'package:fresh_store_ui/screens/widgets/input_field.dart';

import '../../../constants/assets_const.dart';
import '../bloc/auth_bloc.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String route() => '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is LoginSucess || state is AuthSuccess){
          toast('Login successfull', success: true);
          Navigator.pushNamedAndRemoveUntil(context, FRTabbarScreen.route(), (route) => false);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 // padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      AssetsConst.appLogo,
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Welcome back !',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color:  ColorsConst.firstColor,),),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text('Login to your existing account',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    const SizedBox(
                      height: 32,
                    ),
                    InputField(
                      controller: emailController,
                      icon: Icons.email_outlined,
                      hintText: 'Enter email address',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InputField(
                      controller: passwordController,
                      icon: Icons.lock_outline,
                      hintText: 'Enter password',
                    ),
                    const SizedBox(
                      height: 54,
                    ),
                    buildAddCard(),
                    const SizedBox(
                      height: 34,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SignupScreen.route());
                          },
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color:  ColorsConst.firstColor),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
            onTap: () async {
              FocusScope.of(context).unfocus();
              if(!formKey.currentState!.validate()){
                return;
              }
            //  Emitter.emit(Loading());
              var  url =Uri.parse('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/login2.php');
              final _client = http.Client();

              Map<String, String> body = {
                "email" : emailController.text.trim(),
                "password" : passwordController.text.trim()
              };
              var response = await _client.post(url, body: body, );
              if (response.statusCode == 200) {
                var responseBody = response.body;
                int splitIndex = responseBody.indexOf('}{') + 1;
                String successJson = responseBody.substring(0, splitIndex);
                String detailsJson = responseBody.substring(splitIndex);
                Map<String, dynamic> successResponse = json.decode(successJson);
                bool success = successResponse['success'];
                String message = successResponse['message'];
                Map<String, dynamic> detailsResponse = json.decode(detailsJson);
                List<dynamic> getDetails = detailsResponse['getDetails'];
                var details = getDetails[0];
                LocalDB.saveUserId(details['id']);
                LocalDB.saveUserName(details['name']);
                LocalDB.saveEmail(details['email']);
                LocalDB.saveMobile(details['mobile']);
                LocalDB.saveCode(details['ccode']);

                LocalDB.saveLogin(true);

           //     emit(LoginSucess());
                Navigator.pushNamed(context, AddressScreen.route());
              } else {
                log('statusCode - ${response.statusCode}');
              }

           /*   context.read<AuthBloc>().add(
                Login(
                  email: emailController.text, 
                  password: passwordController.text
                )
              );*/
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login, color: ColorsConst.black),
                SizedBox(width: 10),
                Text(
                  'Login',
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
}
