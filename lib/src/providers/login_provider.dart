import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LoginProvider {

  final String _url = 'http://192.168.0.249:8888';
  
  Future<List<dynamic>> validateUser(String cedula) async {
    final url = '$_url/api/colaborador/validaridentidad?identificacion=$cedula';
    final response = await http.get(url);
    if(response.statusCode == 200){
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Error al validar usuario!');
    }
  }

  Future<http.Response> registerUser(String cedula, String password) {
    final url = '$_url/api/colaborador/registrar';
    return http.post( url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'login': cedula,
        'password': password
      }),
    );
  }

  Future<dynamic> getToken(String cedula, String password) async {
    final url ='$_url/token';
    final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: 
            'username=$cedula&password=$password&grant_type=password'
          );
    if(response.statusCode == 200 || response.statusCode == 400){
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener el token!');
    }
  }

}