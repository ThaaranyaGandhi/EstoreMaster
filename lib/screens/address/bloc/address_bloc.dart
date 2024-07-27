import 'package:bloc/bloc.dart';
import 'package:fresh_store_ui/global.dart';
import 'package:fresh_store_ui/network/services/address_service.dart';
import 'package:meta/meta.dart';

import '../../../db/local_db.dart';
import '../../../network/models/address.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<AddAddress>(_onAddAddress);
    on<GetAllAddress>(_onGetAllAddress);
    on<UpdateAddress>(_onUpdateAddress);
  }

  var service = AddressService();

  void _onAddAddress(AddAddress event, Emitter emit)async{
    emit(Loading());

    try{
      await service.addAddress(
        hno: event.hno, 
        society: event.society, 
        pincode: event.pincode, 
        area: event.area, 
        landmark: event.landmark, 
        type: event.type, 
        name: event.name
      );

      var response = await service.getAllAddress();
      var addresses = (response["ResultData"] as List).map((e) => Address.fromMap(e)).toList();
       emit(AddressListed(addresses));

      print(addresses);

      emit(AddressCreated());
    }catch(e){
      print('uid${LocalDB.getUserid()}');
      print('failedcfdf');
      emit(Failed());
    }
  }

  void _onGetAllAddress(GetAllAddress event, Emitter emit)async{
    emit(Loading());

    try{
      var response = await service.getAllAddress();
      print('address repose+${response}');
      var addresses = (response["ResultData"] as List).map((e) => Address.fromMap(e)).toList();
      Global.myAddress.value = addresses;
      emit(AddressListed(addresses));
    }catch(e){
      print('failedrrrr');
      emit(Failed());
    }
  }

  void _onUpdateAddress(UpdateAddress event, Emitter emit)async{
    emit(Loading());
    try{
      await service.updateAddress(event.address);
      emit(AddressUpdated());
    }catch(e){
      print('failedqqq');
      emit(Failed());
    }
  }
}
