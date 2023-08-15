import 'package:placeholder_ufra_app/domain/abstraction/abstract_converter.dart';

class CredentialsDTO implements AbstractConverter {
  late String name;
  late String username;
  late String matricula;
  late String curso;
  late String nivel;
  late double ira;
  late double mc;
  late List<String> roles;
  late String accessToken;
  late String tokenType;

  CredentialsDTO();

  CredentialsDTO.named({
    required this.name,
    required this.username,
    required this.roles,
    required this.accessToken,
    required this.tokenType,
    required this.matricula,
    required this.curso,
    required this.nivel,
    required this.ira,
    required this.mc,
  });

  @override
  void fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    roles = json['roles'].cast<String>();
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    matricula = json['matricula'];
    curso = json['curso'];
    nivel = json['nivel'];
    ira = json['ira'];
    mc = json['mc'];
  }

  @override
  CredentialsDTO entityFromJson(Map<String, dynamic> json) {
    return CredentialsDTO.named(
      name: json['name'],
      username: json['username'],
      roles: json['roles'].cast<String>(),
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
      matricula: json['userInfo']['matricula'],
      curso: json['userInfo']['curso'],
      nivel: json['userInfo']['nivel'],
      ira: json['userInfo']['ira'],
      mc: json['userInfo']['mc'],
    );
  }

  @override
  List<CredentialsDTO> fromJsonList(List<dynamic> jsonList) {
    List<CredentialsDTO> list = List.empty(growable: true);
    for (Map<String, dynamic> json in jsonList) {
      list.add(entityFromJson(json));
    }

    return list;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['roles'] = roles;
    data['accessToken'] = accessToken;
    data['tokenType'] = tokenType;
    data['matricula'] = matricula;
    data['curso'] = curso;
    data['nivel'] = nivel;
    data['ira'] = ira;
    data['mc'] = mc;
    return data;
  }
}
