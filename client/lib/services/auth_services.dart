import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/global_variables.dart';

class AuthService {
  static signUpApi(String email, String password, String username) async {
    //try {} catch (e) {}
    Map body = {"username": username, "email": email, "password": password};
    print(body);
    var res = await http.Client()
        .post(Uri.parse(api_url + "/api/signup"), body: body);

    return res;
  }

  static signInApi(
    String email,
    String password,
  ) async {
    //try {} catch (e) {}
    //try {} catch (e) {}
    Map body = {"email": email, "password": password};
    print(body);
    var res = await http.Client()
        .post(Uri.parse(api_url + "/api/signin"), body: body);

    return res;
  }
}
