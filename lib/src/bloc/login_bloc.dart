import 'dart:async';

import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  //
  final _emailContrroler    = BehaviorSubject<String>();
  final _passwordContrroler = BehaviorSubject<String>();

  //GET
  //Recuperar los datos del  Stream
  Stream<String> get emailStream    => _emailContrroler.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordContrroler.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
       Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
//
  //Insetar valores al Stream
  Function(String) get changeEmail    => _emailContrroler.sink.add;
  Function(String) get changePassword => _passwordContrroler.sink.add;

  //Obtener el último valor ingresado a los streams
  String get email    => _emailContrroler.value;
  String get password => _passwordContrroler.value; 
  //
  dispose() {
    _emailContrroler?.close();
    _passwordContrroler?.close();
  }
}
