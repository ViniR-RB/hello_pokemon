sealed class ConfigEnviroment {
  static late final String apirUrl;

  static void load() async {
    apirUrl = _getEnviroment("API_URL");

    validate();
  }

  static String _getEnviroment<T>(String key) {
    final value = String.fromEnvironment(key);

    if (value.isEmpty) {
      throw AssertionError("Environment variable '$key' is not set.");
    }
    return value;
  }

  static void validate() {
    if (apirUrl.isEmpty) {
      throw AssertionError("API_URL is not set.");
    }
  }
}
