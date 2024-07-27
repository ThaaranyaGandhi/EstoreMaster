import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/screens/search/bloc/search_bloc.dart';
import 'package:fresh_store_ui/screens/search/header.dart';

import '../../components/product_card.dart';
import '../detail/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static String route() => '/search';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var padding = const EdgeInsets.fromLTRB(24, 24, 24, 0);
  late var datas = [];
  late TextEditingController _controller;
  Timer? _debounce;
  String searchValue = '';

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  void _onSearchChanged(v) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if(v!.trim()=='' || searchValue==v){
        return;
      }
      searchValue = v;
      context.read<SearchBloc>().add(Search(keyword: v));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only( right: 15, left: 15),
              sliver: SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: SearchAppBar(controller: _controller, onChanged: (v){
                  _onSearchChanged(v);
                },),
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: _buildPopulars(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopulars() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {

        if(state is SearchDataFetched){
          datas = state.products;
        }else if(state is Failure){
          datas = [];
        }

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 185,
            mainAxisSpacing: 24,
            crossAxisSpacing: 16,
            mainAxisExtent: 270,
          ),
          delegate:
              SliverChildBuilderDelegate(_buildPopularItem, childCount: datas.length),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = datas[index];
    return ProductCard(
      data: data,
      ontap: (data) => Navigator.pushNamed(context, ShopDetailScreen.route(), arguments: data),
    );
  }
}