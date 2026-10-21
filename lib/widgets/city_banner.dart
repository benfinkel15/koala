import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:koala/widgets/koala_surfer.dart';

// ─── Public entry point ───────────────────────────────────────────────────────

class CityBanner extends StatelessWidget {
  final String langCode;
  final double height;

  const CityBanner({super.key, required this.langCode, this.height = 220});

  @override
  Widget build(BuildContext context) {
    final cfg = _config(langCode);
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(child: CustomPaint(painter: _SkyPainter(cfg: cfg))),
          // City label
          Positioned(
            top: 12,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(55),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _label(langCode),
                style: const TextStyle(
                    color: Colors.white, fontSize: 10,
                    fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
            ),
          ),
          // Koala on the first wave crest (x≈6%, bottom≈40% of height)
          Positioned(
            bottom: height * 0.40,
            left: w * 0.06,
            child: const KoalaSurfer(),
          ),
        ],
      ),
    );
  }

  static String _label(String lang) {
    if (lang == 'nl') return 'AMSTERDAM';
    if (lang == 'da') return 'COPENHAGEN';
    return 'BERLIN';
  }

  static _BannerConfig _config(String lang) {
    if (lang == 'nl') {
      return const _BannerConfig(
        skyTop: Color(0xFFD4683A), skyBottom: Color(0xFFF7C580),
        waveColor: Color(0xFF3D8FA8), waveColor2: Color(0xFF5AB0CC),
        cityColor: Color(0xFF1A1A2E), city: _CityStyle.amsterdam,
      );
    }
    if (lang == 'da') {
      return const _BannerConfig(
        skyTop: Color(0xFF2B5FA8), skyBottom: Color(0xFFF0C060),
        waveColor: Color(0xFF3A8FA0), waveColor2: Color(0xFF5AB8C8),
        cityColor: Color(0xFF1A2A3A), city: _CityStyle.copenhagen,
      );
    }
    return const _BannerConfig(
      skyTop: Color(0xFF1A3050), skyBottom: Color(0xFFC4714A),
      waveColor: Color(0xFF2B7A8A), waveColor2: Color(0xFF4A9DB5),
      cityColor: Color(0xFF0D1B2A), city: _CityStyle.berlin,
    );
  }
}

// ─── Config ───────────────────────────────────────────────────────────────────

enum _CityStyle { berlin, amsterdam, copenhagen }

class _BannerConfig {
  final Color skyTop, skyBottom, waveColor, waveColor2, cityColor;
  final _CityStyle city;
  const _BannerConfig({
    required this.skyTop, required this.skyBottom,
    required this.waveColor, required this.waveColor2,
    required this.cityColor, required this.city,
  });
}

// ─── Painter ──────────────────────────────────────────────────────────────────

class _SkyPainter extends CustomPainter {
  final _BannerConfig cfg;
  const _SkyPainter({required this.cfg});

  // Ground sits at 70% from top; waves fill below ~60%
  static const _gndFrac = 0.70;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final gnd = h * _gndFrac;

    // Sky gradient
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cfg.skyTop, cfg.skyBottom],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // City
    switch (cfg.city) {
      case _CityStyle.berlin:
        _paintBerlin(canvas, w, h, gnd);
      case _CityStyle.amsterdam:
        _paintAmsterdam(canvas, w, h, gnd);
      case _CityStyle.copenhagen:
        _paintCopenhagen(canvas, w, h, gnd);
    }

    // Waves (drawn on top of city)
    _wave(canvas, size, cfg.waveColor2, baseH: 0.47, amp: 0.07, segs: 3);
    _wave(canvas, size, cfg.waveColor,  baseH: 0.35, amp: 0.05, segs: 4);
  }

  // ─── Smooth cubic-bezier wave ──────────────────────────────────────────────
  // baseH = fraction from bottom for calm-water line; first segment is a crest.
  void _wave(Canvas canvas, Size size, Color color,
      {required double baseH, required double amp, required int segs}) {
    final w = size.width;
    final h = size.height;
    final baseY = h * (1.0 - baseH);
    final a = h * amp;
    final sw = w / segs;

    final path = Path()
      ..moveTo(0, h)
      ..lineTo(0, baseY);
    for (int i = 0; i < segs; i++) {
      final x0 = i * sw;
      final x1 = (i + 1) * sw;
      final sign = (i % 2 == 0) ? -1.0 : 1.0;
      path.cubicTo(x0 + sw * 0.3, baseY + sign * a,
                   x0 + sw * 0.7, baseY + sign * a, x1, baseY);
    }
    path.lineTo(w, h);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  // ─── Berlin: dark night-sky silhouette ────────────────────────────────────
  void _paintBerlin(Canvas canvas, double w, double h, double gnd) {
    final p = Paint()..color = cfg.cityColor;

    void b(double x, double bw, double bh) =>
        canvas.drawRect(Rect.fromLTWH(x, gnd - bh, bw, bh), p);

    // Left cluster
    b(w * 0.00, w * 0.07, h * 0.16);
    b(w * 0.06, w * 0.06, h * 0.10);
    b(w * 0.11, w * 0.07, h * 0.20);
    b(w * 0.17, w * 0.05, h * 0.13);

    // Brandenburg Gate
    final gx = w * 0.26;
    final gw = w * 0.13;
    final gh = h * 0.24;
    b(gx, w * 0.022, gh);
    b(gx + w * 0.040, w * 0.020, gh * 0.88);
    b(gx + gw - w * 0.022, w * 0.022, gh);
    canvas.drawRect(Rect.fromLTWH(gx, gnd - gh, gw, h * 0.022), p); // lintel
    _tri(canvas, p, gx, gnd - gh, gx + gw / 2, gnd - gh - h * 0.046, gx + gw, gnd - gh);

    // Mid
    b(w * 0.41, w * 0.05, h * 0.15);
    b(w * 0.45, w * 0.05, h * 0.10);

    // Fernsehturm — column + sphere + antenna
    final tx = w * 0.57;
    canvas.drawRect(Rect.fromLTWH(tx - w * 0.009, gnd - h * 0.54, w * 0.018, h * 0.54), p);
    canvas.drawOval(Rect.fromCenter(center: Offset(tx, gnd - h * 0.42), width: w * 0.068, height: w * 0.062), p);
    canvas.drawRect(Rect.fromLTWH(tx - w * 0.003, gnd - h * 0.60, w * 0.006, h * 0.12), p);

    // Right
    b(w * 0.65, w * 0.07, h * 0.18);
    b(w * 0.71, w * 0.07, h * 0.12);
    b(w * 0.77, w * 0.06, h * 0.20);
    b(w * 0.82, w * 0.07, h * 0.14);
    b(w * 0.88, w * 0.06, h * 0.10);
    b(w * 0.93, w * 0.07, h * 0.17);

    canvas.drawRect(Rect.fromLTWH(0, gnd, w, h - gnd), p);
  }

  // ─── Amsterdam: colourful canal houses + windmill ─────────────────────────
  static const _amstWall = [
    Color(0xFFA93226), Color(0xFF6E2B10), Color(0xFF1F618D),
    Color(0xFF1E8449), Color(0xFF784212), Color(0xFF6C3483), Color(0xFFC0392B),
  ];
  static const _amstGable = [
    Color(0xFF7B2117), Color(0xFF4A1A08), Color(0xFF154360),
    Color(0xFF145A32), Color(0xFF512E0A), Color(0xFF4A235A), Color(0xFF8B2319),
  ];

  void _paintAmsterdam(Canvas canvas, double w, double h, double gnd) {
    // Canal houses
    const specs = [
      (0.00, 0.085, 0.22), (0.08, 0.080, 0.17), (0.15, 0.090, 0.25),
      (0.23, 0.075, 0.19), (0.30, 0.085, 0.22), (0.38, 0.080, 0.16),
      (0.45, 0.085, 0.20),
    ];
    for (var i = 0; i < specs.length; i++) {
      final hx = w * specs[i].$1;
      final hw = w * specs[i].$2;
      final hh = h * specs[i].$3;
      // Body
      canvas.drawRect(Rect.fromLTWH(hx, gnd - hh, hw, hh),
          Paint()..color = _amstWall[i % _amstWall.length]);
      // Windows
      _windows(canvas, hx, gnd, hw, hh);
      // Stepped gable
      _steppedGable(canvas, Paint()..color = _amstGable[i % _amstGable.length],
          hx, gnd - hh, hw);
    }

    // Dark fill right side + ground
    final dp = Paint()..color = const Color(0xFF1A1A2E);
    canvas.drawRect(Rect.fromLTWH(0, gnd, w, h - gnd), dp);

    // Right buildings (dark)
    void db(double x, double bw, double bh) =>
        canvas.drawRect(Rect.fromLTWH(x, gnd - bh, bw, bh), dp);
    db(w * 0.76, w * 0.07, h * 0.15);
    db(w * 0.82, w * 0.07, h * 0.11);
    db(w * 0.88, w * 0.06, h * 0.17);
    db(w * 0.93, w * 0.07, h * 0.13);

    // Windmill body (dark brown)
    final mx = w * 0.62;
    final mh = h * 0.44;
    final mbp = Paint()..color = const Color(0xFF3E2208);
    final mill = Path()
      ..moveTo(mx - w * 0.048, gnd)
      ..lineTo(mx + w * 0.048, gnd)
      ..lineTo(mx + w * 0.028, gnd - mh)
      ..lineTo(mx - w * 0.028, gnd - mh)
      ..close();
    canvas.drawPath(mill, mbp);
    _tri(canvas, mbp, mx - w * 0.028, gnd - mh, mx, gnd - mh - h * 0.065, mx + w * 0.028, gnd - mh);

    // Sails
    final hub = Offset(mx, gnd - mh * 0.90);
    final sp = Paint()..color = const Color(0xFF2A1505)..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.022..strokeCap = StrokeCap.round;
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 + math.pi / 8;
      canvas.drawLine(hub, Offset(hub.dx + w * 0.115 * math.cos(angle),
          hub.dy + w * 0.115 * math.sin(angle)), sp);
    }
  }

  // ─── Copenhagen: colourful Nyhavn row + Vor Frelsers spire ───────────────
  static const _nyhavnWall = [
    Color(0xFFE74C3C), Color(0xFFE67E22), Color(0xFF2980B9), Color(0xFF27AE60),
    Color(0xFFF39C12), Color(0xFF8E44AD), Color(0xFFD35400), Color(0xFF2471A3),
  ];
  static const _nyhavnRoof = [
    Color(0xFFAB3328), Color(0xFFB56118), Color(0xFF1F618D), Color(0xFF1E8449),
    Color(0xFFB7770D), Color(0xFF6C3483), Color(0xFF9B3B0A), Color(0xFF1A5276),
  ];

  void _paintCopenhagen(Canvas canvas, double w, double h, double gnd) {
    // Nyhavn buildings
    const widths  = [0.08, 0.07, 0.09, 0.07, 0.08, 0.07, 0.06, 0.08];
    const heights = [0.24, 0.18, 0.28, 0.21, 0.26, 0.17, 0.22, 0.20];
    var x = 0.0;
    for (var i = 0; i < widths.length; i++) {
      final bw = w * widths[i];
      final bh = h * heights[i];
      canvas.drawRect(Rect.fromLTWH(x, gnd - bh, bw, bh),
          Paint()..color = _nyhavnWall[i % _nyhavnWall.length]);
      _windows(canvas, x, gnd, bw, bh);
      // Triangular roof
      _tri(canvas, Paint()..color = _nyhavnRoof[i % _nyhavnRoof.length],
          x, gnd - bh, x + bw / 2, gnd - bh - h * 0.055, x + bw, gnd - bh);
      x += bw + 2;
    }

    // Ground + right
    final dp = Paint()..color = const Color(0xFF1A2A3A);
    canvas.drawRect(Rect.fromLTWH(0, gnd, w, h - gnd), dp);
    void db(double bx, double bw, double bh) =>
        canvas.drawRect(Rect.fromLTWH(bx, gnd - bh, bw, bh), dp);
    db(w * 0.80, w * 0.07, h * 0.16);
    db(w * 0.86, w * 0.07, h * 0.12);
    db(w * 0.92, w * 0.08, h * 0.18);

    // Vor Frelsers Kirke spire
    final sx = w * 0.72;
    canvas.drawRect(Rect.fromLTWH(sx - w * 0.055, gnd - h * 0.26, w * 0.11, h * 0.26), dp);
    canvas.drawRect(Rect.fromLTWH(sx - w * 0.022, gnd - h * 0.34, w * 0.044, h * 0.08), dp);
    canvas.drawRect(Rect.fromLTWH(sx - w * 0.013, gnd - h * 0.39, w * 0.026, h * 0.05), dp);
    _tri(canvas, dp, sx - w * 0.013, gnd - h * 0.39, sx, gnd - h * 0.66, sx + w * 0.013, gnd - h * 0.39);
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  void _tri(Canvas canvas, Paint p, double x1, double y1, double x2, double y2, double x3, double y3) {
    canvas.drawPath(Path()..moveTo(x1, y1)..lineTo(x2, y2)..lineTo(x3, y3)..close(), p);
  }

  void _windows(Canvas canvas, double x, double gnd, double bw, double bh) {
    final p = Paint()..color = Colors.white.withAlpha(200);
    final ww = bw * 0.20;
    final wh = bh * 0.10;
    final gap = bh * 0.28;
    final rows = ((bh * 0.75) / (wh + gap)).floor().clamp(1, 3);
    for (var r = 0; r < rows; r++) {
      final wy = gnd - bh + bh * 0.14 + r * (wh + gap);
      canvas.drawRect(Rect.fromLTWH(x + bw * 0.10, wy, ww, wh), p);
      canvas.drawRect(Rect.fromLTWH(x + bw * 0.58, wy, ww, wh), p);
    }
  }

  void _steppedGable(Canvas canvas, Paint p, double x, double top, double bw) {
    final sw = bw * 0.16;
    final sh = bw * 0.13;
    canvas.drawRect(Rect.fromLTWH(x, top - sh, bw, sh), p);
    canvas.drawRect(Rect.fromLTWH(x + sw, top - sh * 2, bw - sw * 2, sh), p);
    canvas.drawRect(Rect.fromLTWH(x + sw * 2, top - sh * 3, bw - sw * 4, sh), p);
    _tri(canvas, p, x + sw * 2, top - sh * 3, x + bw / 2, top - sh * 4, x + bw - sw * 2, top - sh * 3);
  }

  @override
  bool shouldRepaint(_SkyPainter old) => old.cfg.city != cfg.city;
}
