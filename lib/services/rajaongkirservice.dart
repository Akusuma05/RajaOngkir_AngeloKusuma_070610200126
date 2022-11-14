part of 'services.dart';

class RajaOngkirServices {
  static Future<http.Response> getOngkir() {
    return http.post(Uri.https(Const.baseUrl, "/starter/cost"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey,
        },
        body: jsonEncode(<String, dynamic>{
          'origin': '501',
          'destination': '114',
          'weight': 2500,
          'courier': 'jne',
        }));
  }

  static Future<http.Response> sendemail(String email) {
    return http.post(
      Uri.https(
          Const.smtpurl, "/week5/cirestapi/cirestapi/api/Mahasiswa/sendmail"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-KEY': 'AFL_Angelo_02-11-22',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );
  }

  static Future<List<Costs>> getMyOngkir(
      dynamic ori, dynamic des, int weight, dynamic courier) async {
    var response = await http.post(
      Uri.https(Const.baseUrl, "/starter/cost"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
      body: jsonEncode(<String, dynamic>{
        'origin': ori,
        'destination': des,
        'weight': weight,
        'courier': courier,
      }),
    );

    var job = json.decode(response.body);
    List<Costs> costs = [];

    if (response.statusCode == 200) {
      costs = (job['rajaongkir']['results'][0]['costs'] as List)
          .map((e) => Costs.fromJson(e))
          .toList();
    }

    return costs;
  }
}
