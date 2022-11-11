import 'dart:convert';
import 'dart:io';
import '../../app/routes/app_pages.dart';
import '../../app/store/store_service.dart';
import '../../app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../app/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

///
/// 基础数据请求Axios
///
class Axios {
  static final Request request = Request(Config.baseUrl);
  static final Dio instance = request.dio;
}

///
/// 设置用户Token
///

setSessionToken(String token) {
  Axios.instance.options.headers['Authorization'] = 'Bearer $token';
  GetStorage().write('token', token);
}

clearSessionToken() {
  Axios.instance.options.headers.remove('Authorization');
  GetStorage().remove('token');
}

///
/// 服务器请求拦截器
///

class Request {
  Dio dio = Dio();
  var _baseUrl = "";

  Request(String baseUrl) {
    _baseUrl = baseUrl;
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        contentType: Headers.jsonContentType));

    /// 添加请求拦截器
    dio.interceptors.add(HttpInterceptors());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true));
  }

  /// 处理 Dio 异常
  static String _dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.receiveTimeout:
        return "服务器异常，请稍后重试！";
      case DioErrorType.sendTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.response:
        return "服务器异常，请稍后重试！";
      case DioErrorType.cancel:
        return "请求已被取消，请重新请求";
      case DioErrorType.other:
        return "网络异常，请稍后重试！";
      default:
        return "Dio异常";
    }
  }

  /// 处理 Http 错误码
  static void _handleHttpError(int errorCode) {
    String message;
    switch (errorCode) {
      case 400:
        message = '请求语法错误';
        break;
      case 401:
        message = '未授权，请登录';
        break;
      case 403:
        message = '拒绝访问';
        break;
      case 404:
        message = '请求出错';
        break;
      case 408:
        message = '请求超时';
        break;
      case 500:
        message = '服务器异常';
        break;
      case 501:
        message = '服务未实现';
        break;
      case 502:
        message = '网关错误';
        break;
      case 503:
        message = '服务不可用';
        break;
      case 504:
        message = '网关超时';
        break;
      case 505:
        message = 'HTTP版本不受支持';
        break;
      default:
        message = '请求失败，错误码：$errorCode';
    }
    EasyLoading.showError(message);
  }

  Request setContentType(String contentType) {
    dio.options.contentType = contentType;
    return this;
  }

  /// get 请求
  Future<dynamic> get(String path) async {
    Response response = await dio.get(path);
    return response.data;
  }

  /// post 请求
  Future<dynamic> post(String path, dynamic data) async {
    Response response = await dio.post(path, data: data);
    return response.data;
  }

  /// put 请求
  Future<dynamic> put(String path, dynamic data) async {
    Response response = await dio.put(path, data: data);
    return response.data;
  }

  /// delete 请求
  Future<dynamic> delete(String path, dynamic data) async {
    Response response = await dio.delete(path, data: data);
    return response.data;
  }

  /// head 请求
  Future<dynamic> head(String path, dynamic data) async {
    Response response = await dio.head(path, data: data);
    return response.data;
  }

  ///patch 请求
  Future<dynamic> patch(String path, dynamic data) async {
    Response response = await dio.patch(path, data: data);
    return response.data;
  }

  /// download 请求
  Future<dynamic> download(String urlPath, String savePath,
      {required Function(int, int) onReceiveProgress}) async {
    Response response = await dio.download(urlPath, savePath,
        onReceiveProgress: onReceiveProgress);
    return response.data;
  }

  Future<dynamic> uploadFile(String path, MultipartFile file) async {
    Response response =
        await dio.post(path, data: FormData.fromMap({'file': file}));
    return response.data;
  }
}

/// 请求拦截器 请按照Api的规范自行封装
class HttpInterceptors extends InterceptorsWrapper {
  /// 请求前做一些操作
  /// 注：一般针对请求头部以及封装token进行一些处理
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  /// 请求结束后返回数据前做一些操作
  /// 注：针对返回的数据进行进行一些返回的封装
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response != null) {
      return handler.next(response);
    }

    return null;
  }

  /// 请求异常时进行一些操作
  /// 注：一般针对error做一些提示性的提示弹窗和日志的输出
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Response? response = err.response;

    if (response != null) {
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000)
        ..indicatorType = EasyLoadingIndicatorType.fadingCircle
        ..loadingStyle = EasyLoadingStyle.dark
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..maskColor = Colors.blue.withOpacity(0.5)
        ..userInteractions = true
        ..dismissOnTap = false;

      ///执行加载动画
      EasyLoading.show();

      if (response.statusCode == 401) {
        // 清理缓存
        clearStoreData();
      }

      Request._handleHttpError(response.statusCode!);
    }

    /// 处理Dio请求错误
    // EasyLoading.showError(Request._dioError(err));
  }
}
