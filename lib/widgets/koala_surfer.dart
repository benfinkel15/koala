import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Cartoon koala on a fish-shaped surfboard, bobbing vertically.
class KoalaSurfer extends StatelessWidget {
  const KoalaSurfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(size: const Size(88, 90), painter: const _KoalaPainter()),
        CustomPaint(size: const Size(110, 24), painter: const _FishBoardPainter()),
      ],
    )
        .animate(onPlay: (c) => c.repeat())
        .moveY(begin: 0, end: -6, duration: 1400.ms, curve: Curves.easeInOut)
        .then()
        .moveY(begin: -6, end: 0, duration: 1400.ms, curve: Curves.easeInOut);
  }
}

// ─── Koala body ───────────────────────────────────────────────────────────────

class _KoalaPainter extends CustomPainter {
  const _KoalaPainter();

  static const _fur = Color(0xFF8C8C8C);
  static const _furDark = Color(0xFF636363);
  static const _furLight = Color(0xFFB8B8B8);
  static const _pink = Color(0xFFF4B8C8);
  static const _nose = Color(0xFF1E1E1E);
  static const _eye = Color(0xFF1A1A1A);

  Paint _p(Color c, {PaintingStyle s = PaintingStyle.fill, double w = 0}) =>
      Paint()..color = c..style = s..strokeWidth = w..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width;
    final h = s.height;

    // Ears (behind head)
    canvas.drawCircle(Offset(w * 0.18, h * 0.14), w * 0.17, _p(_furDark));
    canvas.drawCircle(Offset(w * 0.82, h * 0.14), w * 0.17, _p(_furDark));
    canvas.drawCircle(Offset(w * 0.18, h * 0.14), w * 0.10, _p(_pink));
    canvas.drawCircle(Offset(w * 0.82, h * 0.14), w * 0.10, _p(_pink));

    // Body
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.73), width: w * 0.52, height: h * 0.33),
      _p(_fur),
    );

    // Arms spread wide for balance
    canvas.drawLine(Offset(w * 0.25, h * 0.67), Offset(w * 0.04, h * 0.60), _p(_fur, s: PaintingStyle.stroke, w: w * 0.09));
    canvas.drawLine(Offset(w * 0.75, h * 0.67), Offset(w * 0.96, h * 0.60), _p(_fur, s: PaintingStyle.stroke, w: w * 0.09));

    // Legs
    canvas.drawLine(Offset(w * 0.38, h * 0.85), Offset(w * 0.32, h * 0.96), _p(_fur, s: PaintingStyle.stroke, w: w * 0.08));
    canvas.drawLine(Offset(w * 0.62, h * 0.85), Offset(w * 0.68, h * 0.96), _p(_fur, s: PaintingStyle.stroke, w: w * 0.08));

    // Head
    canvas.drawCircle(Offset(w * 0.50, h * 0.37), w * 0.27, _p(_fur));

    // Eyes
    canvas.drawCircle(Offset(w * 0.37, h * 0.33), w * 0.058, _p(_eye));
    canvas.drawCircle(Offset(w * 0.63, h * 0.33), w * 0.058, _p(_eye));
    // Eye shine
    canvas.drawCircle(Offset(w * 0.39, h * 0.31), w * 0.021, _p(Colors.white));
    canvas.drawCircle(Offset(w * 0.65, h * 0.31), w * 0.021, _p(Colors.white));

    // Nose — big flat oval, characteristic of koalas
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.50, h * 0.42), width: w * 0.24, height: h * 0.12), _p(_nose));
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.50, h * 0.41), width: w * 0.14, height: h * 0.06), _p(const Color(0xFF404040)));

    // Smile
    final smile = Path()
      ..moveTo(w * 0.42, h * 0.47)
      ..quadraticBezierTo(w * 0.50, h * 0.51, w * 0.58, h * 0.47);
    canvas.drawPath(smile, _p(_nose, s: PaintingStyle.stroke, w: 1.8));

    // Belly fur patch
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.73), width: w * 0.32, height: h * 0.20),
      _p(_furLight),
    );
  }

  @override
  bool shouldRepaint(_KoalaPainter _) => false;
}

// ─── Fish surfboard ───────────────────────────────────────────────────────────

class _FishBoardPainter extends CustomPainter {
  const _FishBoardPainter();

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width;
    final h = s.height;

    // Fish shape: nose (left) → wide belly → split tail fins (right)
    final board = Path()
      ..moveTo(w * 0.02, h * 0.50) // nose tip
      ..cubicTo(w * 0.12, h * 0.04, w * 0.68, h * 0.02, w * 0.88, h * 0.22)
      ..lineTo(w * 1.00, h * 0.01)   // upper tail fin
      ..lineTo(w * 0.91, h * 0.50)   // tail notch
      ..lineTo(w * 1.00, h * 0.99)   // lower tail fin
      ..cubicTo(w * 0.88, h * 0.78, w * 0.12, h * 0.96, w * 0.02, h * 0.50)
      ..close();

    // Warm coral-orange fill
    canvas.drawPath(
      board,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFE64A19)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // White edge highlight
    canvas.drawPath(
      board,
      Paint()
        ..color = Colors.white.withAlpha(70)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Decorative centre stripe
    final stripe = Path()
      ..moveTo(w * 0.14, h * 0.40)
      ..lineTo(w * 0.82, h * 0.25);
    canvas.drawPath(
      stripe,
      Paint()
        ..color = Colors.white.withAlpha(130)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_FishBoardPainter _) => false;
}
