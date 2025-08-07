import 'package:flutter/material.dart';

class HelloPokemonLogo extends StatelessWidget {
  final double size;
  final Color? textColor;
  final bool showSubtitle;

  const HelloPokemonLogo({
    super.key,
    this.size = 200,
    this.textColor,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo principal com pokébola e texto
        SizedBox(
          width: size,
          height: size * 0.7,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pokébola de fundo
              Positioned(
                left: 0,
                child: Container(
                  width: size * 0.4,
                  height: size * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white,
                        Colors.red.shade400,
                        Colors.red.shade700,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Linha divisória horizontal
                      Container(
                        height: 4,
                        width: size * 0.4,
                        color: Colors.black87,
                      ),
                      // Círculo central
                      Container(
                        width: size * 0.12,
                        height: size * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black87, width: 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Texto "HELLO"
              Positioned(
                right: 0,
                top: size * 0.05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HELLO',
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: size * 0.12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'POKÉMON',
                      style: TextStyle(
                        color: textColor ?? const Color(0xFFFFD700), // Dourado
                        fontSize: size * 0.1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        if (showSubtitle) ...[
          const SizedBox(height: 10),
          Text(
            'Explore o mundo Pokémon',
            style: TextStyle(
              color: (textColor ?? Colors.white).withValues(alpha: 0.8),
              fontSize: size * 0.06,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
            ),
          ),
        ],
      ],
    );
  }
}

// Widget específico para a pokébola isolada
class PokemonBall extends StatelessWidget {
  final double size;
  final List<Color>? colors;

  const PokemonBall({super.key, this.size = 100, this.colors});

  @override
  Widget build(BuildContext context) {
    final ballColors =
        colors ?? [Colors.white, Colors.red.shade400, Colors.red.shade700];

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: ballColors),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: size * 0.15,
            offset: Offset(size * 0.05, size * 0.05),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Parte superior vermelha
          ClipPath(
            clipper: _TopHalfClipper(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ballColors[1],
              ),
            ),
          ),

          // Parte inferior branca
          ClipPath(
            clipper: _BottomHalfClipper(),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),

          // Linha divisória horizontal
          Container(height: size * 0.04, width: size, color: Colors.black87),

          // Círculo central
          Container(
            width: size * 0.3,
            height: size * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.black87, width: size * 0.03),
            ),
            child: Container(
              margin: EdgeInsets.all(size * 0.05),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Clipper para a parte superior da pokébola
class _TopHalfClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(
      Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2),
    );
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Clipper para a parte inferior da pokébola
class _BottomHalfClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height / 2));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
