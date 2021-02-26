import 'package:flutter/material.dart';
import 'package:ripconciv_app/src/models/form_model.dart';
import 'package:ripconciv_app/src/providers/form_provider.dart';

import 'home_page.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final formKey = GlobalKey<FormState>();
  final formProvider = new FormProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _lista(),    
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   Widget _lista() {
    return FutureBuilder(
      future: formProvider.getForm(),
      builder: (BuildContext context, AsyncSnapshot<Preguntas> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else{
          return ListBuilder(preguntas: snapshot.data, formKey: formKey);
        }
      }
    );
  }

}

class ListBuilder extends StatefulWidget {
  bool aceptacion = false;
  final Preguntas preguntas;
  final formKey;
  ListBuilder({@required this.preguntas, this.formKey});
  Preguntas preguntasGlobal = Preguntas();
  bool _enableTextForm = false;
  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<TextEditingController> _controllers;
  @override
  void initState(){
    widget.preguntasGlobal = widget.preguntas;
    widget.preguntasGlobal.secciones[0].preguntas.forEach((f){
      f.respuestas[0].seleccionada = false;
      f.respuestas[1].seleccionada = true;
    });
    _controllers = List<TextEditingController>.generate(
        widget.preguntas.secciones[0].preguntas.length, (index) => TextEditingController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
       children: <Widget>[
        Text('ENCUESTA SALUD OCUPACIONAL COVID-19', style: TextStyle(fontSize: 18.0, fontFamily: "OpenSans-ExtraBold"), textAlign: TextAlign.center),
        SizedBox(height: 15.0),
        // Text(widget.preguntas.secciones[0].titulo, style: TextStyle(fontSize: 16.0, fontFamily: "OpenSans-Bold"), textAlign: TextAlign.left),
        // SizedBox(height: 10.0),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true, 
          itemCount: widget.preguntas.secciones[0].preguntas.length,
          itemBuilder: (BuildContext context, int i){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.preguntas.secciones[0].preguntas[i].descripcion, style: TextStyle(fontFamily: "OpenSans-Bold")),
                RadioButtom(
                  onRadioChange: (bool value){
                    if(value){
                      widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].seleccionada = true;
                      widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].seleccionada = false;
                      if(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta != null){
                        widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.respuestas[0].respuestaValor = widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta.respuestas[0].respuestaValor;
                        widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta.respuestas[0].respuestaValor = "";
                      }
                    }else if(!value){
                      widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].seleccionada = true;
                      widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].seleccionada = false;
                      if(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta != null){
                        widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta.respuestas[0].respuestaValor = widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.respuestas[0].respuestaValor;
                        widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.respuestas[0].respuestaValor = "";  
                      } else {
                        _controllers[i].text = "";
                      }
                    }
                    if(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.obligatoria){
                      _enabledTextFrom(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].seleccionada);
                    }
                  }
                ),
                TextFormField(
                  controller: _controllers[i],
                  enabled: (widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.obligatoria) ? ((widget._enableTextForm) ? true :  false) : true,
                  validator: (value) {
                    if ((value.isEmpty || value.trim() == "")&& widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.obligatoria && widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].seleccionada) {
                      return 'Por favor ingrese el texto';  
                    } else { 
                      return null; 
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontFamily: "OpenSans-Regular", color: Color(0xffe81935)),
                    hintMaxLines: 500,
                    hintText: widget.preguntas.secciones[0].preguntas[i].respuestas[0].pregunta.descripcion,
                    hintStyle: TextStyle(fontFamily: "OpenSans-Regular", fontSize: 14.0),
                  ),
                  onChanged: (value){
                    if(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].seleccionada){
                      widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.respuestas[0].respuestaValor = value;
                      if(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta != null){
                        widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta.respuestas[0].respuestaValor = "";
                      }
                    }else if(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].seleccionada){
                      if(widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta != null){
                        widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[1].pregunta.respuestas[0].respuestaValor = value;
                        widget.preguntasGlobal.secciones[0].preguntas[i].respuestas[0].pregunta.respuestas[0].respuestaValor = "";
                      }
                    }
                  },
                ),
                SizedBox(height: 15.0)
              ],
            ); 
          }
        ),
        _acceptCheck(widget.preguntas.secciones[1].preguntas[0].descripcion), 
        _buttom()
      ],
    );
  }

  void _enabledTextFrom(bool value){
    if(value) {
      setState(() {
        widget._enableTextForm = true;
      });
    } else {
      setState(() {
        widget._enableTextForm = false;
      });
    }
  }

  Widget _buttom(){
  final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: size.height * 0.07,
      width: size.width * 0.8,
      child: RaisedButton.icon(
        label: Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "OpenSans-Bold")),
        color: Color(0XFF1C77ED),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        icon: Icon(Icons.save, color: Colors.white),
        onPressed: _submit
      ),
    );
  }
  
  void _submit(){
    if(!widget.formKey.currentState.validate()) return;
    if(widget.formKey.currentState.validate() && widget.aceptacion == true){
      final formProvider = new FormProvider();
      widget.preguntasGlobal.secciones[1].preguntas[0].respuestas[0].seleccionada = true;
      formProvider.enviarFormulario(widget.preguntasGlobal).then((opt){
        print(opt);
        if(opt['estado'] == true){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    }
  }

  Widget _acceptCheck(String statement){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Checkbox(
              value: widget.aceptacion,
              onChanged: (bool value) {
                setState(() { 
                  widget.aceptacion = value; 
                });
              },
            ),
            Flexible(
              child: Text(
                statement,
                style: TextStyle(color: Colors.black, fontSize: 14.0, fontFamily: "OpenSans-Regular"), textAlign: TextAlign.justify,
              ),
            ),
          ]
        ),
        SizedBox(height: 5.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Opacity(
              opacity: 0.0,
              child: Checkbox(
                value: true,
                onChanged: (value){},
              ),
            ),
            Visibility(
              visible: (!widget.aceptacion) ? true : false,
              child: Text('Acepte los términos de la encuesta!', style: TextStyle(color: Color(0xffe81935), fontFamily: "OpenSans-Regular", fontSize: 12.0))
            ),
          ],
        )
      ],
    );
  }

}

class RadioButtom extends StatefulWidget {
  final Function(bool) onRadioChange;
  RadioButtom({@required this.onRadioChange});
  @override
  _RadioButtomState createState() => _RadioButtomState();
}

class _RadioButtomState extends State<RadioButtom> {
  bool _radioValue = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: true,
          groupValue: _radioValue,
          onChanged: (value){
            setState(() {
              _radioValue = value;
              widget.onRadioChange(value);
            });
          }
        ),
        Text('Sí', style: TextStyle(fontSize: 12.0, fontFamily: "OpenSans-Regular")),
        Radio(
          value: false,
          groupValue: _radioValue,
          onChanged: (value){
            _radioValue = value;
            setState(() {
              widget.onRadioChange(value);
            });
          }
        ),
        Text('No', style: TextStyle(fontSize: 12.0, fontFamily: "OpenSans-Regular"))
      ],
    );
  }
}

