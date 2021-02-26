import 'dart:convert';

Preguntas preguntasFromJson(String str) => Preguntas.fromJson(json.decode(str));

String preguntasToJson(Preguntas data) => json.encode(data.toJson());

class Preguntas {
    Colaborador colaborador;
    bool completa;
    String id;
    Nombre nombre;
    String numeroFormulario;
    String descripcion;
    List<Seccione> secciones;
    dynamic empresas;
    bool estado;
    dynamic fechaCreacion;
    dynamic responsableCreacion;
    dynamic fechaModificacion;
    dynamic responsableModificacion;

    Preguntas({
        this.colaborador,
        this.completa,
        this.id,
        this.nombre,
        this.numeroFormulario,
        this.descripcion,
        this.secciones,
        this.empresas,
        this.estado,
        this.fechaCreacion,
        this.responsableCreacion,
        this.fechaModificacion,
        this.responsableModificacion,
    });

    factory Preguntas.fromJson(Map<String, dynamic> json) => Preguntas(
        colaborador: Colaborador.fromJson(json["colaborador"]),
        completa: json["completa"],
        id: json["id"],
        nombre: nombreValues.map[json["nombre"]],
        numeroFormulario: json["numeroFormulario"],
        descripcion: json["descripcion"],
        secciones: List<Seccione>.from(json["secciones"].map((x) => Seccione.fromJson(x))),
        empresas: json["empresas"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        responsableCreacion: json["responsableCreacion"],
        fechaModificacion: json["fechaModificacion"],
        responsableModificacion: json["responsableModificacion"],
    );

    Map<String, dynamic> toJson() => {
        "colaborador": colaborador.toJson(),
        "completa": completa,
        "id": id,
        "nombre": nombreValues.reverse[nombre],
        "numeroFormulario": numeroFormulario,
        "descripcion": descripcion,
        "secciones": List<dynamic>.from(secciones.map((x) => x.toJson())),
        "empresas": empresas,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "responsableCreacion": responsableCreacion,
        "fechaModificacion": fechaModificacion,
        "responsableModificacion": responsableModificacion,
    };
}

class Colaborador {
    String id;
    Empresa empresa;
    String identificacion;
    String nombre;
    String sexo;
    String fechaNacimiento;
    String cargo;
    dynamic email;
    dynamic telefono;
    String celular;
    String ciudad;
    bool estado;
    dynamic login;
    dynamic password;
    bool registrado;
    bool bloqueoActivado;

    Colaborador({
        this.id,
        this.empresa,
        this.identificacion,
        this.nombre,
        this.sexo,
        this.fechaNacimiento,
        this.cargo,
        this.email,
        this.telefono,
        this.celular,
        this.ciudad,
        this.estado,
        this.login,
        this.password,
        this.registrado,
        this.bloqueoActivado,
    });

    factory Colaborador.fromJson(Map<String, dynamic> json) => Colaborador(
        id: json["id"],
        empresa: Empresa.fromJson(json["empresa"]),
        identificacion: json["identificacion"],
        nombre: json["nombre"],
        sexo: json["sexo"],
        fechaNacimiento: json["fechaNacimiento"],
        cargo: json["cargo"],
        email: json["email"],
        telefono: json["telefono"],
        celular: json["celular"],
        ciudad: json["ciudad"],
        estado: json["estado"],
        login: json["login"],
        password: json["password"],
        registrado: json["registrado"],
        bloqueoActivado: json["bloqueoActivado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "empresa": empresa.toJson(),
        "identificacion": identificacion,
        "nombre": nombre,
        "sexo": sexo,
        "fechaNacimiento": fechaNacimiento,
        "cargo": cargo,
        "email": email,
        "telefono": telefono,
        "celular": celular,
        "ciudad": ciudad,
        "estado": estado,
        "login": login,
        "password": password,
        "registrado": registrado,
        "bloqueoActivado": bloqueoActivado,
    };
}

class Empresa {
    String id;
    String identificacion;
    String razonSocial;
    String nombreComercial;
    dynamic email;
    bool estado;

    Empresa({
        this.id,
        this.identificacion,
        this.razonSocial,
        this.nombreComercial,
        this.email,
        this.estado,
    });

    factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        id: json["id"],
        identificacion: json["identificacion"],
        razonSocial: json["razonSocial"],
        nombreComercial: json["nombreComercial"],
        email: json["email"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "razonSocial": razonSocial,
        "nombreComercial": nombreComercial,
        "email": email,
        "estado": estado,
    };
}

enum Nombre { ABIERTA, TEXTO, FECHA, DICOTMICAS, ELECCIN_MLTIPLE, LGICA }

final nombreValues = EnumValues({
    "Abierta": Nombre.ABIERTA,
    "Dicotómicas": Nombre.DICOTMICAS,
    "Elección múltiple": Nombre.ELECCIN_MLTIPLE,
    "Fecha": Nombre.FECHA,
    "Lógica": Nombre.LGICA,
    "Texto": Nombre.TEXTO
});

class Seccione {
    String id;
    dynamic encuesta;
    String titulo;
    String descripcion;
    int orden;
    List<Pregunta> preguntas;
    bool estado;
    dynamic fechaCreacion;
    dynamic responsableCreacion;
    dynamic fechaModificacion;
    dynamic responsableModificacion;

    Seccione({
        this.id,
        this.encuesta,
        this.titulo,
        this.descripcion,
        this.orden,
        this.preguntas,
        this.estado,
        this.fechaCreacion,
        this.responsableCreacion,
        this.fechaModificacion,
        this.responsableModificacion,
    });

    factory Seccione.fromJson(Map<String, dynamic> json) => Seccione(
        id: json["id"],
        encuesta: json["encuesta"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        orden: json["orden"],
        preguntas: List<Pregunta>.from(json["preguntas"].map((x) => Pregunta.fromJson(x))),
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        responsableCreacion: json["responsableCreacion"],
        fechaModificacion: json["fechaModificacion"],
        responsableModificacion: json["responsableModificacion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "encuesta": encuesta,
        "titulo": titulo,
        "descripcion": descripcion,
        "orden": orden,
        "preguntas": List<dynamic>.from(preguntas.map((x) => x.toJson())),
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "responsableCreacion": responsableCreacion,
        "fechaModificacion": fechaModificacion,
        "responsableModificacion": responsableModificacion,
    };
}

class Respuesta {
    String id;
    Pregunta pregunta;
    dynamic respuesta;
    int orden;
    Etiqueta etiqueta;
    String respuestaValor;
    bool seleccionada;
    bool estado;
    dynamic fechaCreacion;
    dynamic responsableCreacion;
    dynamic fechaModificacion;
    dynamic responsableModificacion;

    Respuesta({
        this.id,
        this.pregunta,
        this.respuesta,
        this.orden,
        this.etiqueta,
        this.respuestaValor,
        this.seleccionada,
        this.estado,
        this.fechaCreacion,
        this.responsableCreacion,
        this.fechaModificacion,
        this.responsableModificacion,
    });

    factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
        id: json["id"],
        pregunta: json["pregunta"] == null ? null : Pregunta.fromJson(json["pregunta"]),
        respuesta: json["respuesta"],
        orden: json["orden"],
        etiqueta: etiquetaValues.map[json["etiqueta"]],
        respuestaValor: json["respuestaValor"],
        seleccionada: json["seleccionada"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        responsableCreacion: json["responsableCreacion"],
        fechaModificacion: json["fechaModificacion"],
        responsableModificacion: json["responsableModificacion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pregunta": pregunta == null ? null : pregunta.toJson(),
        "respuesta": respuesta,
        "orden": orden,
        "etiqueta": etiquetaValues.reverse[etiqueta],
        "respuestaValor": respuestaValor,
        "seleccionada": seleccionada,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "responsableCreacion": responsableCreacion,
        "fechaModificacion": fechaModificacion,
        "responsableModificacion": responsableModificacion,
    };
}

class Pregunta {
    String id;
    dynamic seccion;
    Tipo tipo;
    TipoRespuesta tipoRespuesta;
    int orden;
    String descripcion;
    bool obligatoria;
    List<Respuesta> respuestas;
    bool estado;
    dynamic fechaCreacion;
    dynamic responsableCreacion;
    dynamic fechaModificacion;
    dynamic responsableModificacion;
    int tipoBase;

    Pregunta({
        this.id,
        this.seccion,
        this.tipo,
        this.tipoRespuesta,
        this.orden,
        this.descripcion,
        this.obligatoria,
        this.respuestas,
        this.estado,
        this.fechaCreacion,
        this.responsableCreacion,
        this.fechaModificacion,
        this.responsableModificacion,
        this.tipoBase,
    });

    factory Pregunta.fromJson(Map<String, dynamic> json) => Pregunta(
        id: json["id"],
        seccion: json["seccion"],
        tipo: Tipo.fromJson(json["tipo"]),
        tipoRespuesta: TipoRespuesta.fromJson(json["tipoRespuesta"]),
        orden: json["orden"],
        descripcion: json["descripcion"],
        obligatoria: json["obligatoria"],
        respuestas: List<Respuesta>.from(json["respuestas"].map((x) => Respuesta.fromJson(x))),
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        responsableCreacion: json["responsableCreacion"],
        fechaModificacion: json["fechaModificacion"],
        responsableModificacion: json["responsableModificacion"],
        tipoBase: json["tipoBase"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "seccion": seccion,
        "tipo": tipo.toJson(),
        "tipoRespuesta": tipoRespuesta.toJson(),
        "orden": orden,
        "descripcion": descripcion,
        "obligatoria": obligatoria,
        "respuestas": List<dynamic>.from(respuestas.map((x) => x.toJson())),
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "responsableCreacion": responsableCreacion,
        "fechaModificacion": fechaModificacion,
        "responsableModificacion": responsableModificacion,
        "tipoBase": tipoBase,
    };
}

enum Etiqueta { SI, NO, COMENTARIO, MENCIONE_SUS_NOMBRE, INDIQUE_EL_LOS_LUGARES_Y_FECHAS, FECHA }

final etiquetaValues = EnumValues({
    "Comentario:": Etiqueta.COMENTARIO,
    "Fecha:": Etiqueta.FECHA,
    "Indique el/los lugares y fechas:": Etiqueta.INDIQUE_EL_LOS_LUGARES_Y_FECHAS,
    "Mencione sus nombre:": Etiqueta.MENCIONE_SUS_NOMBRE,
    "No": Etiqueta.NO,
    "Si": Etiqueta.SI
});

class Tipo {
    int id;
    dynamic tipo;
    Nombre nombre;
    dynamic descripcion;
    bool estado;
    dynamic fechaCreacion;
    dynamic responsableCreacion;
    dynamic fechaModificacion;
    dynamic responsableModificacion;
    int tipoBase;

    Tipo({
        this.id,
        this.tipo,
        this.nombre,
        this.descripcion,
        this.estado,
        this.fechaCreacion,
        this.responsableCreacion,
        this.fechaModificacion,
        this.responsableModificacion,
        this.tipoBase,
    });

    factory Tipo.fromJson(Map<String, dynamic> json) => Tipo(
        id: json["id"],
        tipo: json["tipo"],
        nombre: nombreValues.map[json["nombre"]],
        descripcion: json["descripcion"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        responsableCreacion: json["responsableCreacion"],
        fechaModificacion: json["fechaModificacion"],
        responsableModificacion: json["responsableModificacion"],
        tipoBase: json["tipoBase"] == null ? null : json["tipoBase"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "nombre": nombreValues.reverse[nombre],
        "descripcion": descripcion,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "responsableCreacion": responsableCreacion,
        "fechaModificacion": fechaModificacion,
        "responsableModificacion": responsableModificacion,
        "tipoBase": tipoBase == null ? null : tipoBase,
    };
}

class TipoRespuesta {
    int id;
    Nombre nombre;
    dynamic descripcion;
    bool estado;
    dynamic fechaCreacion;
    dynamic responsableCreacion;
    dynamic fechaModificacion;
    dynamic responsableModificacion;
    int tipoBase;

    TipoRespuesta({
        this.id,
        this.nombre,
        this.descripcion,
        this.estado,
        this.fechaCreacion,
        this.responsableCreacion,
        this.fechaModificacion,
        this.responsableModificacion,
    });

    factory TipoRespuesta.fromJson(Map<String, dynamic> json) => TipoRespuesta(
        id: json["id"],
        nombre: nombreValues.map[json["nombre"]],
        descripcion: json["descripcion"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        responsableCreacion: json["responsableCreacion"],
        fechaModificacion: json["fechaModificacion"],
        responsableModificacion: json["responsableModificacion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombreValues.reverse[nombre],
        "descripcion": descripcion,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "responsableCreacion": responsableCreacion,
        "fechaModificacion": fechaModificacion,
        "responsableModificacion": responsableModificacion,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
