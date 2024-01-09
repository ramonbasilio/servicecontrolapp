import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Http {
  Future<void> callCloudFunc(String pdf) async {
    String url =
        "https://us-central1-servicecontrolapp.cloudfunctions.net/helloword";
    var response = await http.post(Uri.parse(url), body: {
      "email": "fucsiabeleza@gmail.com",
      "pdf": pdf,
    });
    if (response.statusCode == 200) {
      print(convert.jsonDecode(response.body));
    } else {
      print("Teve erro: ${response.statusCode}");
    }
  }
}
