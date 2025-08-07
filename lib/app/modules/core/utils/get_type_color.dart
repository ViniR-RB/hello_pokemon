import 'package:flutter/material.dart';

Color getTypeColor(String type) {
  switch (type.toLowerCase()) {
    case 'fire':
      return Colors.red;
    case 'water':
      return Colors.blue;
    case 'grass':
      return Colors.green;
    case 'electric':
      return Colors.yellow[700]!;
    case 'psychic':
      return Colors.pink;
    case 'ice':
      return Colors.lightBlue;
    case 'dragon':
      return Colors.indigo;
    case 'dark':
      return Colors.brown;
    case 'fairy':
      return Colors.pink[300]!;
    case 'fighting':
      return Colors.red[800]!;
    case 'poison':
      return Colors.purple;
    case 'ground':
      return Colors.orange[800]!;
    case 'flying':
      return Colors.blue[300]!;
    case 'bug':
      return Colors.lightGreen;
    case 'rock':
      return Colors.grey[600]!;
    case 'ghost':
      return Colors.deepPurple;
    case 'steel':
      return Colors.blueGrey;
    default:
      return Colors.grey;
  }
}
