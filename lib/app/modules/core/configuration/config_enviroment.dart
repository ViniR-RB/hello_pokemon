sealed class ConfigEnviroment {
  static const String _apiUrl = String.fromEnvironment("API_URL");
  static String get apiUrl => _apiUrl;

  static void validate() {
    if (_apiUrl.isEmpty) {
      throw AssertionError('A variável de ambiente API_URL não está definida');
    }
  }
}
