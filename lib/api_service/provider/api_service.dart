import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newhandy/helper/constant.dart';

Future<dynamic> getRequest(String url) async {
  try {
    dynamic response = await http.get(Uri.parse(mainUrl + "$url"), headers: {
      "Accept": "application/json",
      "Authorization":
          "Basic bWlzaGFxdWVAZ21haS5jb206VlBSTUI4dnkyREI3c0pRa3JuMmdCc1E3R0VaZUJwMEo="
    });

    if (response.statusCode == 200) {
      dynamic res = jsonDecode(response.body);
      return res;
    } else {
      my_toast("Technical error #" + response.statusCode.toString(), "error");
      return "error";
    }
  } on SocketException catch (e) {
    my_toast("Internet is not working !", "error");
  } catch (err) {
    my_toast("Catch Error" + err.toString(), "error");
  }
}

Future<dynamic> postRequest(String url, dynamic body) async {
  try {
    dynamic response = await http.post(
      Uri.parse(mainUrl + "$url"),
      body: (body),
    );
    dynamic res = jsonDecode(response.body);
    return res;

  } catch (err) {
    my_toast("Catch Error" + err.toString(), "error");
  }
}

Future<dynamic> postMultipart(
    String url, Map<String, String> body, dynamic filename) async {
  var headers = {'Accept': 'application/json'};
  try {
    var request = http.MultipartRequest('POST', Uri.parse(mainUrl + '$url'));
    request.files.add(await http.MultipartFile.fromPath('photo', filename));
    request.fields.addAll(body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return "done";
    } else {
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      my_toast("Technical Error" + response.statusCode.toString(), "error");
    }
  } catch (err) {
    my_toast("Catch Error" + err.toString(), "error");
  }
}
