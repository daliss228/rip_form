import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:ripconciv_app/src/models/form_model.dart';
import 'package:ripconciv_app/src/providers/prefs_provider.dart';

class FormProvider {

  final String _url = 'http://192.168.0.249:8888';
  final PreferenceUser _prefsUser = new PreferenceUser();

  Future<Preguntas> getForm() async {

    final cedula = await _prefsUser.getPrefsCedula();
    final token = await _prefsUser.getPrefsToken();
    final uri = '$_url/api/encuestacolaborador/getencuestasaludocupacional?identificacion=$cedula';
    final response = await http.get(uri, 
          headers: <String, String>{
                'Authorization': 'Bearer $token',
              },
          );
    if(response.statusCode == 200){
      final responseJson = convert.jsonDecode(response.body);
      final preguntas = new Preguntas.fromJson(responseJson);
      return preguntas;
    } else {
      throw Exception('Error al obtener el formulario!');
    }
  }

  Future<dynamic> enviarFormulario(Preguntas preguntas) async{
    print(preguntas);
    final token = await _prefsUser.getPrefsToken();
    final uri = '$_url/api/encuestacolaborador/setencuestasaludocupacional';
    final response = await http.post( uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: convert.jsonEncode(preguntas)
    );
    if(response.statusCode == 200){
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Error al enviar el formulario!');
    }
  }
}