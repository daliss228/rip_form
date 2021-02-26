import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ripconciv_app/src/pages/form_page.dart';
import 'package:ripconciv_app/src/providers/login_provider.dart';
import 'package:ripconciv_app/src/providers/prefs_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final loginProvider = new LoginProvider();
  final prefsUser = new PreferenceUser();
  bool _ocultarPass = true;
  bool _ocultarPassConfirm = true;
  bool _validateUserId = true;
  bool _validateUserPass = false;
  bool _validateUserPassConfirm = false;
  String _cedula = "";
  String _pass = "";
  String _passConfirm = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0XFF00326C),
      body: Stack(
        children: <Widget>[
          Align(alignment: Alignment.center, child: _containerMain(size)),
          Align(alignment: Alignment.center, child: _inputsContainer(size)),
        ],
      ),
    );
  }

  Widget _containerMain(size) {
    return Container(
      width: size.width * 0.80,
      height: size.height * 0.60,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(1.0, 10.0)
          )
        ],
      ),
    );
  }

  Widget _inputsContainer(size){
    return Container(
      width: size.width * 0.7,
      height: size.height * 0.55,
      child: Column(
        children: <Widget>[
          _imagen(size),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _inputCedula(),
                SizedBox(height: 10.0),
                Opacity(opacity: (_validateUserPass) ? 1.0 : 0.5, child: _inputPassword()),
                SizedBox(height: 10.0),
                Visibility(
                  visible: (_validateUserPassConfirm) ? true : false,
                  child: _inputPasswordConfirm(),
                ),  
              ],
            )
          ),
          _buttomLogin()
        ],
      ),
    );
  }

  Widget _imagen(size) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Image.asset(
        'assets/img/logo-header.png',
        width: size.width * 0.6,
        height: size.height * 0.16,
      ),
    );
  }

  Widget _inputCedula(){
    return TextFormField(
      onChanged: (value){
        setState(() {
          this._cedula = value;
        });
      },
      enabled: _validateUserId,
      style: TextStyle(fontFamily: "OpenSans-Bold", fontSize: 16.0, color: Colors.black),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Cédula',
        hintStyle: TextStyle(fontFamily: "OpenSans-Bold", fontSize: 16.0),
        prefixIcon: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.account_circle)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
    );
  }

  Widget _inputPassword(){
    return TextFormField(
      onChanged: (value){
        setState(() {
          this._pass = value;
        });
      },
      enabled: (_validateUserPass) ? true : false,
      obscureText: _ocultarPass,
      style: TextStyle(fontFamily: "OpenSans-Bold", fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Contraseña',
        hintStyle: TextStyle(fontFamily: "OpenSans-Bold", fontSize: 16.0),
        prefixIcon: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.lock)),
        suffixIcon: GestureDetector(
          onTap: _showPass,
          child: Icon(
            _ocultarPass ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            size: 15.0
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
    );
  }

  Widget _inputPasswordConfirm(){
    return TextFormField(
      onChanged: (value){
        setState(() {
          this._passConfirm = value;
        });
      },
      obscureText: _ocultarPassConfirm,
      style: TextStyle(fontFamily: "OpenSans-Bold", fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Confirmar',
        hintStyle: TextStyle(fontFamily: "OpenSans-Bold", fontSize: 16.0),
        prefixIcon: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.lock)),
        suffixIcon: GestureDetector(
          onTap: _showPassConfirm,
          child: Icon(
            _ocultarPassConfirm ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            size: 15.0
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
    );
  }

  void _showPass() {
    setState(() {
      _ocultarPass = !_ocultarPass;
    });
  }

  void _showPassConfirm() {
    setState(() {
      _ocultarPassConfirm = !_ocultarPassConfirm;
    });
  }

  void messageSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: "OpenSans-Bold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(milliseconds: 2000),
    ));
  }

  void _validarUsuarioRegistrado(){
    loginProvider.validateUser(_cedula).then((opt) {
      if(opt[0]['registrado'] == true){
        setState(() {
          _validateUserPass = true;
          _validateUserPassConfirm = false;
          _validateUserId = false;
          messageSnackBar('Ingrese la contraseña!');
        });
      }else{
        setState(() {
          messageSnackBar('Registre su usuario!');
          _validateUserId = false;
          _validateUserPass = true;
          _validateUserPassConfirm = true;
        });
      }
    });
  }

  void _validarUsuarioLogin() {
    loginProvider.getToken(_cedula, _pass).then((opt){
      if(opt['access_token'].toString().length != 4){
        prefsUser.setPrefsCedula(_cedula);
        prefsUser.setPrefsToken(opt['access_token']);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FormPage()));
      } else if(opt['access_token'].toString().length == 4){
        messageSnackBar('Contraseña incorrecta');
      }
    });
  }

  Widget _buttomLogin(){
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        color: Color(0XFF00326C)
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 20.0),
            child: Text( _validateUserPass
              ? "Iniciar Sesión" : "Continuar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: "OpenSans-Bold"),
            ),
          ),
          onPressed: (){
            if (_cedula.length == 10 && _validateUserPass == false) {
              _validarUsuarioRegistrado();
            }
            if (_validateUserPassConfirm) {
              if (_pass != "" && _passConfirm != "") {
                if (_pass == _passConfirm){
                  loginProvider.registerUser(_cedula, _pass);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  messageSnackBar('Las constraseñas no coinciden!');
                }
              } else {
                messageSnackBar('Llene todos los campos!');
              }
            } else {
              if (_pass != "") {
                _validarUsuarioLogin();
              }
            }
          },    
      ),
    );
  }

}


