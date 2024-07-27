import 'package:bloc/bloc.dart';
import 'package:fresh_store_ui/network/models/product.dart';
import 'package:fresh_store_ui/network/services/common_service.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<Search>(_onSearch);
  }

  void _onSearch(Search event, Emitter emit)async{
    emit(Loading());
    try{
      var response = await CommonService().search(event.keyword);
      print(response);
      if(response["Result"]!=null && response["Result"]==false){
        SearchDataFetched(const []);
      }
      var products = (response['data'] as List).map((e) => Product.fromMap(e)).toList();
      emit(SearchDataFetched(products));
    }catch(e){
      emit(Failure());
    }

  }
}
