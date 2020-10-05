import 'package:dio/dio.dart';

class ApiClient {
  static const baseUrl = 'www.thecocktaildb.com';
  static const apiPath = 'api/json/v1/1/';

  Dio dio = Dio();

  Future<Response> get(Map<String, dynamic> data) async {
    final url = 'https://$baseUrl/$apiPath/${data['path']}';

    try {
      Response res = await dio.get(
        url,
        queryParameters: data['queryParam'],
      );

      return res;
    } catch (e) {
      print(e);
    }
  }
}
