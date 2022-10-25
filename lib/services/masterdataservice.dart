part of 'services.dart';

class MasterDataService {
  static Future<Map<String, dynamic>> getProvince() async {
    var response = await http.get(
      Uri.https(Const.baseUrl, "/starter/province"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
    );

    var job = json.decode(response.body);
    Map<String, dynamic> result = {};
    result['status'] = job['rajaongkir']['status']['code'];
    result['message'] = job['rajaongkir']['status']['description'];
    if (result['status'] == 200) {
      result['data'] = job['rajaongkir']['results'];
    }

    return result;
  }

  static Future<Map<String, dynamic>> getCity() async {
    var response = await http.get(
      Uri.https(Const.baseUrl, "/starter/city"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
    );

    var job = json.decode(response.body);
    Map<String, dynamic> result = {};
    result['status'] = job['rajaongkir']['status']['code'];
    result['message'] = job['rajaongkir']['status']['description'];
    if (result['status'] == 200) {
      result['data'] = job['rajaongkir']['results'];
    }

    return result;
  }
}
