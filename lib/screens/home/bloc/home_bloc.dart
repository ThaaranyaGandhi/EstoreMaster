import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/network/models/category.dart';
import 'package:fresh_store_ui/network/models/main_data.dart';
import 'package:fresh_store_ui/network/models/product.dart';
import 'package:fresh_store_ui/network/services/common_service.dart';

import '../../../global.dart';
import '../../../network/models/banner.dart' as banner;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetMainData>(_onGetMainData);
  }

  CommonService service = CommonService();

  void _onGetMainData(GetMainData event, Emitter emit)async{
    emit(Loading());
    try{
      var response = await service.getMain();
      var resultData = response['ResultData'];
      var banners = (resultData['Banner'] as List).map((e) => banner.Banner.fromMap(e)).toList();
      var categories = (resultData['Catlist'] as List).map((e) => Category.fromMap(e)).toList();
      var products = (resultData['Productlist'] as List).map((e) => Product.fromMap(e)).toList();
      var mainData = MainData.fromMap(resultData['Main_Data']);

      Global.mainData = mainData;

      emit(MainDataFetched(
        banners: banners,
        categories: categories,
        products: products,
        mainData: mainData
      ));
    }catch(e){
      emit(Failure());
    }

  }
}
