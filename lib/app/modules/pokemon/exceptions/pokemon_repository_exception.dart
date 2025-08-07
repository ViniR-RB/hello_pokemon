import 'package:hello_pokemon/app/modules/core/exceptions/app_exception.dart';
import 'package:hello_pokemon/app/modules/core/messages/default_messages.dart';

class PokemonRepositoryException extends AppException {
  PokemonRepositoryException([super.message = UNEXPECTED_ERROR]);
}
