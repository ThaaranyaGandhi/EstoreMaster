import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/components/app_bar.dart';
import 'package:fresh_store_ui/components/product_card.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/global.dart';
import 'package:fresh_store_ui/screens/home/most_popular.dart';
import 'package:fresh_store_ui/screens/mostpopular/bloc/product_bloc.dart';
import 'package:fresh_store_ui/screens/search/search_screen.dart';

import '../detail/detail_screen.dart';

class MostPopularScreen extends StatefulWidget {
  const MostPopularScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<MostPopularScreen> createState() => MostPopularScreenState();
}

class MostPopularScreenState extends State<MostPopularScreen> {
  late var datas = [];
  static int selectedindex = 0;

  @override
  void initState() {
    if (Global.categories.isNotEmpty) {
      context
          .read<ProductBloc>()
          .add(GetProducts(cid: Global.categories[selectedindex].id));
    }
    MostPupularCategoryState.selectIndex = selectedindex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('hbhj${datas.length}');
    const padding = EdgeInsets.fromLTRB(24, 20, 24, 0);
    return Scaffold(
      appBar: AppBar(
      //  context,
        backgroundColor: ColorsConst.firstColor,
       leadingWidth: 30,
        title: const Text('Products', style: TextStyle(fontWeight: FontWeight.w600),),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/search_1.png',
              color: Colors.black87, /*scale: 2.0*/
            ),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.route());
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) => MostPupularCategory(
                      onCategoryChanged: (cid) {
                        context.read<ProductBloc>().add(GetProducts(cid: cid));
                      },
                    )),
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: padding,
            sliver: _buildPopulars(),
          ),
          const SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildPopulars() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        datas = [];
        if (state is ProductsFetched) {
          datas = state.products;
          print('data${datas}');
        }
        print('data${datas}');
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 185,
            mainAxisSpacing: 0,
            crossAxisSpacing: 16,
            mainAxisExtent: 265,
          ),
          delegate: SliverChildBuilderDelegate(_buildPopularItem,
              childCount: datas.length),
        );
      },
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = datas[index % datas.length];
    return ProductCard(
      data: data,
      ontap: (data) => Navigator.pushNamed(context, ShopDetailScreen.route(),
          arguments: data),
    );
  }
}
