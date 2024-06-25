import 'package:http/http.dart' as http;

class NetworkHelper {
  static const loginEndPoint =
      "https://central-backend-e6ln.onrender.com/api/devtest/login";
  static const productsEndPoint =
      "https://central-backend-e6ln.onrender.com/api/devtest/products";

  static Future<http.Response> makeloginRequest(
      {required String username, required String password}) async {
    dynamic url = Uri.parse(loginEndPoint);
    try {
      final response = await http
          .post(url, body: {"username": username, "password": password});
      return response;
    } catch (e) {
      throw "Failed to Login. Check Network and try again";
    }
  }

  static Future<http.Response> makeProductRequest(
      {required String token}) async {
    dynamic url = Uri.parse(productsEndPoint);
    try {
      final response = await http.get(url, headers: {"x-access-token": token});
      return response;
    } catch (e) {
      throw "Timed out fetching products. check network";
    }
  }
}
