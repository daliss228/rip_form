import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUser {

  setPrefsToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  setPrefsCedula(String cedula) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cedula', cedula);
  }

  getPrefsToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  getPrefsCedula() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('cedula');
    return token;
  }
  
}

// class PreferenceUser {

//   static final PreferenceUser _instance = new PreferenceUser._internal();

//   factory PreferenceUser(){
//     return _instance;
//   }

//   PreferenceUser._internal();

//   SharedPreferences _preferences;

//   initPrefs() async {
//     this._preferences = await SharedPreferences.getInstance();
//   }

//   set prefsToken(String token) {
//     this._preferences.setString('token', token);
//   }

//   set prefsCedula(String cedula) {
//     this._preferences.setString('cedula', cedula);
//   }

//   get prefsToken {
//     return this._preferences.getString('token');
//   }

//   get prefsCedula {
//     return this._preferences.getString('cedula');
//   }
  
// }