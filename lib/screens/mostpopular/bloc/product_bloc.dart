import 'package:bloc/bloc.dart';
import 'package:fresh_store_ui/network/models/product.dart';
import 'package:meta/meta.dart';

import '../../../network/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProducts>(_onGetProducts);
  }

  void _onGetProducts(GetProducts event, Emitter emit)async{
    emit(Loading());

    try{
      var response = await ProductService().getProducts(event.cid);
      var products = (response['data'] as List).map((product)=>Product.fromMap(product)).toList();
      emit(ProductsFetched(products));

    }catch(e){
      emit(Failure());
    }

  }

}
