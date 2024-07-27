import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../constants/urls_const.dart';
import '../resources/toast.dart';

class ApiClient {
  late Dio dio;

  final String path;
  final bool loader;
  final bool errToast;

  final Map<String, String>? additionalHeaders;

  ApiClient(this.path, {this.loader=true, this.errToast=true,this.additionalHeaders}){
    dio = Dio();
    dio.options.baseUrl = UrlsConst.apiHost;
   //  dio.options.baseUrl = 'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/newapi/new_login.php';
   //  dio.options.baseUrl = 'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/newapi/new_login.php';
    log('url - dio.options.baseUrl - ${dio.options.baseUrl}');
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(ApiInterceptors(
      dio: dio, 
      additionalHeaders: additionalHeaders,
      loader: loader,
      errToast: errToast
    ));
  }

  Future<dynamic> gets({Map<String, dynamic>? query}) async {
    return _process(await dio.get(path, queryParameters: query));
  }

  Future post({dynamic data = const {}, Map<String, dynamic>? query}) async {
    return _process(await dio.post(path, data: data));
  }

  Future<dynamic> put({dynamic data = const {}, Map<String, dynamic>? query}) async {
    return _process(await dio.put<Map>(path, data: data));
  }

  Future<dynamic> delete({dynamic data = const {}, Map<String, dynamic>? query}) async {
    return _process(await dio.delete<Map>(path, data: data));
  }

  _process(Response response){
    return response.data is String ? json.decode(response.data) : response.data;
  }
}  

class ApiInterceptors extends Interceptor {
  final Dio dio;
  final Map<String, String>? additionalHeaders;
  final bool loader;
  final bool errToast;

  ApiInterceptors({
    required this.dio,
    required this.additionalHeaders,
    required this.errToast,
    required this.loader  
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    if (loader) showLoader();
    
    options.headers["Content-Type"] = "application/json";

    if (additionalHeaders != null){
      for (var element in additionalHeaders!.keys) { 
        options.headers[element] = additionalHeaders![element];
      }
    }

    return handler.next(options);
  }

  bool isRefreshing = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async{
    if (loader) hideLoader();
    
    if(err.response?.statusCode==401){
      try {
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      } finally {
        isRefreshing = false;
      }
    } 

    if (err.response?.data is Map && err.response!.data.containsKey('message')) {
      if (errToast) toast(err.response?.data['message'].toString(), success: false);
    } else {
      if (errToast) toast(err.toString(), success: false);
    }

    if(err.response?.statusCode==401){
      return;
    }else {
      return handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    if (loader) hideLoader();

    if(response.data!=null){
      return handler.next(response);
    }
  }

}