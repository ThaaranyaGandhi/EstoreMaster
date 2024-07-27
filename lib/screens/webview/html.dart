import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlScreen extends StatefulWidget {
  const HtmlScreen({super.key});

  static String route() => '/html';

  @override
  State<HtmlScreen> createState() => _HtmlScreenState();
}

class _HtmlScreenState extends State<HtmlScreen> {

  late String htmlContent;

  @override
  void didChangeDependencies() {
    htmlContent = ModalRoute.of(context)!.settings.arguments as String;
    print(htmlContent);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('',style: TextStyle(color: Colors.black),),centerTitle: true
          ,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: HtmlWidget(htmlContent),
        ),
      ),
    );
  }
}