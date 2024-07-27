import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/resources/toast.dart';
import '../../../db/local_db.dart';
import '../../../network/models/user.dart';
import '../../../network/services/auth_service.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CreateAccount>(_onCreateAccount);
    on<Login>(_onLogin);
    on<orderhis>(orderhistory);

  }

  void _onCreateAccount(CreateAccount event, Emitter emit)async{
    emit(Loading());
    try{
      var response = await AuthService().register(event.email, event.password, event.name, event.mobileNumber);
      log(response);
      if(response["ResponseCode"] == 200)
        {
          emit(SignupSuccess());
        }
    }catch(e){
      emit(Failure(message: e.toString()));
    }
  }

  void _onLogin(Login event, Emitter emit)async{
    emit(Loading());
    try{
      log('_onLogin');
      var response = await AuthService().login(event.email, event.password);
      log("response - $response");
      User user = User.fromMap(response['user']);

      LocalDB.saveUserId(user.id);
      LocalDB.saveUserName(user.name);
      LocalDB.saveEmail(user.email);
      LocalDB.saveMobile(user.mobile);
      LocalDB.saveCode(user.ccode);

      LocalDB.saveLogin(true);

      emit(LoginSucess());
    }catch(e){
      log('fail');
      toast('Invalid Email / Mobile no', success: false);
      emit(Failure(message: e.toString()));
    }
  }

  void orderhistory(orderhis event, Emitter emit)async{
    emit(Loading());
    try{
      var response = await AuthService().orderhis(event.uid, event.orderid);
      print(response);
      emit(HistorySucess());
    }catch(e){
      emit(Failure(message: e.toString()));
    }
  }
}
