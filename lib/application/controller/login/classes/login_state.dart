

import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoggedOutState extends LoginState {}

class LoggingInState extends LoginState {}

class LoggedInState extends LoginState {
  final String usuario;
  final String token;
  final String matricula;
  final String curso;
  final String nivel;
  final double ira;
  final double mc;

  LoggedInState({
    required this.usuario,
    required this.token,
    required this.matricula,
    required this.curso,
    required this.nivel,
    required this.ira,
    required this.mc,
  });
}
