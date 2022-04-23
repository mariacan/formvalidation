//import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ], //
    ) //
        ); //
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
//
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            //Espacio
            /**/ height: 185.0, //De la parte de arriba
          ) //
              ), //

          Container(
            //Cajita
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                //Decoración
                color: Colors.white, //Color
                borderRadius: BorderRadius.circular(5.0), //Borde
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 0.5)
                ] //
                ), //
            child: Column(
              //CONTENIDO/CAJITA
              children: [
                //TEXTO DE LA CAJITA
                Text('Ingreso', style: TextStyle(fontSize: 22.0)),
                SizedBox(height: 50.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
              ], //
            ), //
          ),
          Text('¿Olvido la contraseña?'), //TEXTO DESPUES DE LA CAJITA
          SizedBox(height: 100.0)
        ], //
      ), //
    ); //
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.orange,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email_rounded, //icono
                    color: Colors.orange),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electronico',
                counterText: snapshot.data,
                errorText: (snapshot.error == null)
                  ? null
                  : snapshot.error.toString()),
            onChanged: bloc.changeEmail,
          ), //
        ); //
      }, //
    ); //
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline_rounded, //icono
                    color: Colors.orange),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: (snapshot.error == null)
                  ? null
                  : snapshot.error.toString()), //
            onChanged: bloc.changePassword,
          ), //
        ); //
      }, //
    ); //
  }

  Widget _crearBoton(LoginBloc bloc) {
    //formValidStream
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        ); //
      }, //
    ); //
  }

  _login(LoginBloc bloc, BuildContext context) {
    print('= = = = = = = =');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('= = = = = = = =');
    Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(//GRADINTE DEL COLOR
              colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromARGB(255, 65, 54, 114)
      ] //
              ) //
          ), //
    );
    //Circulos de decoración
    final circulo = Container(
      //CIRCULO(S)
      width: 100.0, //Ancho
      height: 100.0, //Altura
      decoration: BoxDecoration(
          //Borde
          borderRadius: BorderRadius.circular(100.0), //# Borde
          color: Color.fromRGBO(255, 255, 255, 0.05) //Color del circulo
          ),
    );
    //
    return Stack(
      children: [
        fondoMorado, //  Abajo   Izq/dere   FORMA
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: 160.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -50.0, child: circulo),
        Positioned(bottom: 100.0, right: 30.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle_rounded,
                  color: Colors.white, size: 100.0),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text('Maria Can',
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ],
          ),
        )
      ], //
    );
  }
}
