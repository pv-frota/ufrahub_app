import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/domain/provider/util/classes/http_client.dart';

final httpClientProvider =
    StateNotifierProvider<HttpClientProvider, HttpClient>(
        (ref) => HttpClientProvider());

class HttpClientProvider extends StateNotifier<HttpClient> {
  HttpClientProvider() : super(HttpClient(Dio()));

  bool initialized = false;

  void initialize() {
    String url = dotenv.get('API_URL');
    Dio instance = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: 10000
      ),
    );
    state = HttpClient(instance);
    initialized = true;
  }

  void afterLogin(String token) {
    BaseOptions options = state.options.copyWith(
      headers: {'Authentication': 'Bearer $token'},
    );

    state = HttpClient(
      Dio(options),
    );
  }
}
