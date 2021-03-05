import 'package:http/http.dart' as http;

class Api {
  static const _api_base_url = '91.107.21.29:8080';
  static const _api = '/api/';

  static String imageCDNPath([String path = '']) =>
      Uri.http(_api_base_url, _api + path).toString();

  static Future<http.Response> getMethod(String path,
      [Map<String, String> queryString]) async {
    var url = Uri.http(_api_base_url, _api + path, queryString);
    return await http.get(url);
  }
}
