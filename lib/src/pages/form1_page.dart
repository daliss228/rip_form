// import 'package:flutter/material.dart';
// import 'package:ripconciv_app/src/models/form1_model.dart';
// import 'package:ripconciv_app/src/providers/form_provider.dart';
// import 'package:ripconciv_app/src/providers/prefs_provider.dart';

// class FormPage extends StatefulWidget {
//   @override
//   _FormPageState createState() => _FormPageState();
// }

// class _FormPageState extends State<FormPage> {

//   final formKey = GlobalKey<FormState>();
//   final formProvider = new FormProvider();
//   final prefsUser = new PrefsUser();
//   bool _ocultarTextForm = true;
  
//   Preguntas preguntasGlobal = Preguntas();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(25.0),
//           child: SafeArea(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: <Widget>[
//                   _lista(),
//                   // SizedBox(height: 25.0),
//                   // _crearBotton(),      
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//    Widget _lista() {
//     return FutureBuilder(
//       future: formProvider.getForm1(),
//       builder: (BuildContext context, AsyncSnapshot<Preguntas> snapshot){
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return Center(child: CircularProgressIndicator());
//         }else{
//           return _questionsList(snapshot.data);
//         }
//       }
//     );
//   }

//   Widget _questionsList(Preguntas preguntas){
//     var questionsList = preguntas.secciones[0].preguntas;
//     List<bool> _answers = List(preguntas.secciones[0].preguntas.length);
//     return Column(
//        children: <Widget>[
//         Text('ENCUESTA SALUD OCUPACIONAL COVID-19', style: TextStyle(fontSize: 18.0, fontFamily: "OpenSans-ExtraBold"), textAlign: TextAlign.center),
//         SizedBox(height: 15.0),
//         Text(preguntas.secciones[0].titulo, style: TextStyle(fontSize: 16.0, fontFamily: "OpenSans-Bold"), textAlign: TextAlign.left),
//         SizedBox(height: 10.0),
//         ListView.builder(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true, 
//           itemCount: preguntas.secciones[0].preguntas.length,
//           itemBuilder: (BuildContext context, int i){
//             final pregunta = questionsList[i];
//             _answers[i]??= false;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(pregunta.descripcion, style: TextStyle(fontFamily: "OpenSans-Bold")),
//                 RadioButtom(
//                   onRadioChange: (bool value){
//                     // print(value);
//                     _answers[i] = value;
//                     print('radios');
//                     print(_answers);
//                     // _showTextForm(value);
//                   }
//                 ),
//                 TextFormField(
//                   // enabled: (_ocultarTextForm) ? true : false,
//                   enabled: (_answers[i]) ? true : false,
//                   validator: (value) {
//                     if ((value.isEmpty || value.trim() == '') && (pregunta.respuestas[0].pregunta.obligatoria && _answers[i])) {
//                       return 'Por favor ingrese texto';  
//                     } else { return null; }
//                     // return null;
//                   },
//                   decoration: InputDecoration(
//                     hintMaxLines: 500,
//                     hintText: pregunta.respuestas[0].pregunta.descripcion,
//                     hintStyle: TextStyle(fontFamily: "OpenSans-Regular", fontSize: 14.0),
//                   ),
//                   onChanged: (value){
//                     preguntasGlobal = preguntas;
//                     // preguntasGlobal.secciones[0].preguntas[i].respuestas[0].respuesta = _answers[i];
//                     // preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.respuestas[0].respuestaValor = value;
//                   },
//                 ),
//                 SizedBox(height: 15.0)
//               ],
//             ); 
//           }
//         ),
//         AcceptCheck(statement: preguntas.secciones[1].preguntas[0].descripcion), 
//         _crearBotton()
//       ],
//     );
    
//   }

//   Widget _crearBotton(){
//   // final  size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20.0),
//       // height: size.height * 0.07,
//       // width: size.width * 0.8,
//       child: RaisedButton.icon(
//         label: Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "OpenSans-Bold")),
//         color: Color(0XFF1C77ED),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//         icon: Icon(Icons.save, color: Colors.white),
//         onPressed: _submit
//       ),
//     );
//   }
  

//   void _submit(){
//     if(!formKey.currentState.validate()) {
//       print('No enviar data');
//     }
//     if(formKey.currentState.validate()){
//       // var data = convert.jsonEncode(preguntasGlobal);
//       // var data1 = "{ \"colaborador\": { \"identificacion\": \"2350642886\"}, \"preguntas\": $data }";
//       print('Enviar data');
//       // formProvider.enviarFormulario1(preguntasGlobal);
//     }
//     // print('Enviar data');
//   }

// }


// // class RadioButtom extends StatefulWidget {
// //   @override
// //   _RadioButtomState createState() => _RadioButtomState();
// //   RadioButtom({this.value, this.onChanged});
// //   final bool value;
// //   final ValueChanged<bool> onChanged;
// // }

// // class _RadioButtomState extends State<RadioButtom> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: <Widget>[
// //         Radio(
// //           value: true,
// //           groupValue: widget.value,
// //           onChanged: widget.onChanged,
// //         ),
// //         Text('Sí', style: TextStyle(fontSize: 12.0, fontFamily: "OpenSans-Regular")),
// //         Radio(
// //           value: false,
// //           groupValue: widget.value,
// //           onChanged: widget.onChanged,
// //         ),
// //         Text('No', style: TextStyle(fontSize: 12.0, fontFamily: "OpenSans-Regular"))
// //       ],
// //     );
// //   }
// // }

// class RadioButtom extends StatefulWidget {
//   @override
//   _RadioButtomState createState() => _RadioButtomState();
//   RadioButtom({@required this.onRadioChange});
//   final Function(bool) onRadioChange;
// }

// class _RadioButtomState extends State<RadioButtom> {
//   bool _radioValue = false;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Radio(
//           value: true,
//           groupValue: _radioValue,
//           onChanged: (value){
//             setState(() {
//               _radioValue = value;
//               widget.onRadioChange(value);
//             });
//           }
//         ),
//         Text('Sí', style: TextStyle(fontSize: 12.0, fontFamily: "OpenSans-Regular")),
//         Radio(
//           value: false,
//           groupValue: _radioValue,
//           onChanged: (value){
//             _radioValue = value;
//             setState(() {
//               widget.onRadioChange(value);
//             });
//           }
//         ),
//         Text('No', style: TextStyle(fontSize: 12.0, fontFamily: "OpenSans-Regular"))
//       ],
//     );
//   }
// }

// class AcceptCheck extends StatefulWidget {
//   final String statement;
//   AcceptCheck({@required this.statement});
//   @override
//   _AcceptCheckState createState() => _AcceptCheckState();
// }

// class _AcceptCheckState extends State<AcceptCheck> {
//   bool _aceptacion = false;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Checkbox(
//           value: _aceptacion,
//           onChanged: (bool value) {
//             // _aceptacion = value; 
//             // print(_aceptacion);  
//             setState(() { 
//               _aceptacion = value; 
//               print(_aceptacion);  
//             });
//           },
//         ),
//         Flexible(
//           child: Text(
//             widget.statement,
//             style: TextStyle(color: Colors.black, fontSize: 14.0, fontFamily: "OpenSans-Regular"), textAlign: TextAlign.justify,
//           ),
//         ),
//       ]
//     );
//   }
// }
