part of 'services.dart';

class RajaOngkirServices {
  static Future<http.Response> getOngkir() {
    return http.post(
      Uri.https(Const.baseUrl, "/starter/cost"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
      body: jsonEncode(<String, dynamic>{
        'origin': '501',
        'destination': '114',
        'weight': 1700,
        'courier': 'jne',
      }),
    );
  }

  static Future<http.Response> sendemail() {
    return http.post(
      Uri.https(
          Const.baseUrl, "/week5/cirestapi/cirestapi/api/Mahasiswa/sendemail"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': 'angelo_kusuma@yahoo.com',
      }),
    );
  }
}
