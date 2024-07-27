import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/global.dart';

class MostPupularCategory extends StatefulWidget {
  final ValueChanged onCategoryChanged;
  const MostPupularCategory({super.key, required this.onCategoryChanged});

  @override
  State<MostPupularCategory> createState() => MostPupularCategoryState();
}

class MostPupularCategoryState extends State<MostPupularCategory> {
  late final datas = Global.categories;
  static int? selectIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        itemCount: datas.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildItem,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final data = datas[index];
    final isActive = selectIndex == index;
    const radius = BorderRadius.all(Radius.circular(10));
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: const Color(0xFF101010), width: 1),
        color: isActive ?/* const Color(0xFF101010)*/ ColorsConst.firstColor: const Color(0xFFFFFFFF),
      ),
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: radius,
        onTap: (){
          widget.onCategoryChanged(data.id);
          print('cdsd');
          print(data.id);
          _onTapItem(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            data.catname,
            style: const TextStyle(
              color: Colors.black87 /*isActive ? const Color(0xFFFFFFFF) : const Color(0xFF101010)*/,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // user interact the item of special offers.
  void _onTapItem(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}

class MostPopularTitle extends StatelessWidget {
  const MostPopularTitle({
    Key? key,
    required this.onTapseeAll,
  }) : super(key: key);

  final Function onTapseeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Most Popular', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF212121),),),
        TextButton(
          onPressed: () => onTapseeAll(),
          child: const Text(
            'See All',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ],
    );
  }
}
