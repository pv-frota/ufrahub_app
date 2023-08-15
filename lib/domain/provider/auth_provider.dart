import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/domain/dto/CredentialsDTO.dart';
import 'package:placeholder_ufra_app/domain/provider/util/http_client_provider.dart';

final authProvider = Provider<AuthProvider>((ref) => AuthProvider(ref));

class AuthProvider {
  final Ref _ref;
  final String _path = '/auth/login';

  AuthProvider(this._ref);

  Future<dynamic> login(String usuario, String senha) async {
    try {
      final response = await _ref.read(httpClientProvider).post(_path, {
        "username": usuario,
        "password": senha,
      });

      if(response is Map<String, dynamic>) {
        return CredentialsDTO().entityFromJson(response);
      } else {
        return response;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
