import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AutosProvider {
  //final String apiURL = 'http://10.0.2.2:8000/api'; // PARA ANDROID
  final String apiURL = 'http://127.0.0.1:8000/api'; // PARA CHROME

  get SharedPrerefences => null;

//para enviar los datos o credenciales de acceso
// desde el cliente vía post a la api (eamil y password)

  //método para listar los autos enviando el token de acceso

  Future<List<dynamic>> getAutos() async {
    //1 acceder al token de acceso
    SharedPreferences sp = await SharedPreferences.getInstance();

    String token = sp.getString('access_token') ?? '';
    //llamar a una dirección
    var uri = Uri.parse('$apiURL/autos');
    var respuesta =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>?> addAuto(
      String vin, String marca, String modelo, int ano, int precio) async {
    var url = Uri.parse(apiURL);
    var respuesta = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'vin': vin,
          'marca': marca,
          'modelo': modelo,
          'año': ano,
          'precio': precio
        }));
    if (respuesta.body.isNotEmpty) {
      return jsonDecode(respuesta.body);
    } else {
      return null;
    }
  }

  Future<http.Response> borrarAuto(String vin) async {
    var url = Uri.parse('$apiURL/$vin');
    return await http.delete(url);
    print('ok');
  }
}