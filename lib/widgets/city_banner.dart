import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ─── Public entry point ───────────────────────────────────────────────────────

class CityBanner extends StatelessWidget {
  final String langCode;
  final double height;

  const CityBanner({super.key, required this.langCode, this.height = 210});

  @override
  Widget build(BuildContext context) {
    final cfg = _config(langCode);
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _SkyPainter(cfg: cfg),
            ),
          ),
          // City label — top-right
          Positioned(
            top: 14,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _label(langCode),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          // Koala on the first wave crest (x≈8%, bottom≈40% of height)
          Positioned(
            bottom: height * 0.40,
            left: w * 0.08,
            child: _KoalaSurfer(waveColor: cfg.waveColor),
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
        skyTop: Color(0xFFD4683A),
        skyBottom: Color(0xFFF7C580),
        waveColor: Color(0xFF3D8FA8),
        waveColor2: Color(0xFF5AB0CC),
        cityColor: Color(0xFF1A1A2E),
        city: _CityStyle.amsterdam,
      );
    }
    if (lang == 'da') {
      return const _BannerConfig(
        skyTop: Color(0xFF2B5FA8),
        skyBottom: Color(0xFFF0C060),
        waveColor: Color(0xFF3A8FA0),
        waveColor2: Color(0xFF5AB8C8),
        cityColor: Color(0xFF1A2A3A),
        city: _CityStyle.copenhagen,
      );
    }
    return const _BannerConfig(
      skyTop: Color(0xFF1A3050),
      skyBottom: Color(0xFFC4714A),
      waveColor: Color(0xFF2B7A8A),
      waveColor2: Color(0xFF4A9DB5),
      cityColor: Color(0xFF0D1B2A),
      city: _CityStyle.berlin,
    );
  }
}

// ─── Config ───────────────────────────────────────────────────────────────────

enum _CityStyle { berlin, amsterdam, copenhagen }

class _BannerConfig {
  final Color skyTop, skyBottom, waveColor, waveColor2, cityColor;
  final _CityStyle city;

  const _BannerConfig({
    required this.skyTop,
    required this.skyBottom,
    required this.waveColor,
    required this.waveColor2,
    required this.cityColor,
    required this.city,
  });
}

// ─── Sky + City + Wave painter ────────────────────────────────────────────────

class _SkyPainter extends CustomPainter {
  final _BannerConfig cfg;
  const _SkyPainter({required this.cfg});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

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

    // City silhouette — ground at 70% from top
    canvas.drawPath(
      _buildCityPath(cfg.city, w, h),
      Paint()..color = cfg.cityColor..style = PaintingStyle.fill,
    );

    // Back wave (lighter, higher — baseH 0.47 means baseline at 53% from top)
    _drawWave(canvas, size, color: cfg.waveColor2, baseH: 0.47, amp: 0.07, segments: 3);

    // Front wave (baseH 0.35 → baseline at 65% from top; crest at 60%)
    _drawWave(canvas, size, color: cfg.waveColor, baseH: 0.35, amp: 0.05, segments: 4);
  }

  // Smooth cubic-bezier wave: alternating crests and troughs.
  // baseH = fraction of height from bottom that is the wave's calm line.
  // amp   = fraction of height for crest/trough offset.
  // The first segment (i=0) is always a crest (goes up).
  void _drawWave(
    Canvas canvas,
    Size size, {
    required Color color,
    required double baseH,
    required double amp,
    required int segments,
  }) {
    final w = size.width;
    final h = size.height;
    final baseY = h * (1.0 - baseH);
    final a = h * amp;
    final segW = w / segments;

    final path = Path()
      ..moveTo(0, h)
      ..lineTo(0, baseY);

    for (int i = 0; i < segments; i++) {
      final x0 = i * segW;
      final x1 = (i + 1) * segW;
      final sign = (i % 2 == 0) ? -1.0 : 1.0; // -1 = crest (up), +1 = trough (down)
      path.cubicTo(
        x0 + segW * 0.3, baseY + sign * a,
        x0 + segW * 0.7, baseY + sign * a,
        x1, baseY,
      );
    }

    path.lineTo(w, h);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  Path _buildCityPath(_CityStyle style, double w, double h) {
    switch (style) {
      case _CityStyle.berlin:
        return _berlinPath(w, h);
      case _CityStyle.amsterdam:
        return _amsterdamPath(w, h);
      case _CityStyle.copenhagen:
        return _copenhagenPath(w, h);
    }
  }

  // ─── Berlin ────────────────────────────────────────────────────────────────
  // Landmarks: Brandenburg Gate (left-centre) + Fernsehturm (dominant, right-centre)
  Path _berlinPath(double w, double h) {
    final p = Path();
    final gnd = h * 0.70; // ground from top

    // Left cluster
    _building(p, w * 0.00, gnd, w * 0.07, h * 0.16);
    _building(p, w * 0.06, gnd, w * 0.06, h * 0.10);
    _building(p, w * 0.11, gnd, w * 0.07, h * 0.20);
    _building(p, w * 0.17, gnd, w * 0.05, h * 0.14);

    // Brandenburg Gate (~28% in)
    final gx = w * 0.26;
    final gw = w * 0.13;
    final gh = h * 0.24;
    _building(p, gx, gnd, w * 0.022, gh);                         // left pillar
    _building(p, gx + w * 0.040, gnd, w * 0.020, gh * 0.88);     // centre pillar
    _building(p, gx + gw - w * 0.022, gnd, w * 0.022, gh);       // right pillar
    p.addRect(Rect.fromLTWH(gx, gnd - gh, gw, h * 0.022));        // lintel
    _tri(p, gx, gnd - gh, gx + gw / 2, gnd - gh - h * 0.046, gx + gw, gnd - gh); // pediment

    // Mid buildings
    _building(p, w * 0.41, gnd, w * 0.05, h * 0.16);
    _building(p, w * 0.45, gnd, w * 0.05, h * 0.11);

    // Fernsehturm (~57%) — tall column, sphere, antenna
    final tx = w * 0.57;
    p.addRect(Rect.fromLTWH(tx - w * 0.009, gnd - h * 0.54, w * 0.018, h * 0.54)); // column
    p.addOval(Rect.fromCenter(                                                         // sphere
      center: Offset(tx, gnd - h * 0.42),
      width: w * 0.068,
      height: w * 0.062,
    ));
    p.addRect(Rect.fromLTWH(tx - w * 0.003, gnd - h * 0.60, w * 0.006, h * 0.12)); // antenna

    // Right cluster
    _building(p, w * 0.65, gnd, w * 0.07, h * 0.18);
    _building(p, w * 0.71, gnd, w * 0.07, h * 0.13);
    _building(p, w * 0.77, gnd, w * 0.06, h * 0.21);
    _building(p, w * 0.82, gnd, w * 0.07, h * 0.15);
    _building(p, w * 0.88, gnd, w * 0.06, h * 0.10);
    _building(p, w * 0.93, gnd, w * 0.07, h * 0.18);

    p.addRect(Rect.fromLTWH(0, gnd, w, h - gnd)); // ground fill
    return p;
  }

  // ─── Amsterdam ─────────────────────────────────────────────────────────────
  // Landmarks: stepped-gable canal houses (left) + large windmill (right-centre)
  Path _amsterdamPath(double w, double h) {
    final p = Path();
    final gnd = h * 0.70;

    // Stepped-gable canal houses
    final houses = [
      (0.00, 0.085, 0.22),
      (0.08, 0.080, 0.17),
      (0.15, 0.090, 0.25),
      (0.23, 0.075, 0.19),
      (0.30, 0.085, 0.22),
      (0.38, 0.080, 0.16),
      (0.45, 0.085, 0.20),
    ];
    for (final house in houses) {
      final hx = w * house.$1;
      final hw = w * house.$2;
      final hh = h * house.$3;
      p.addRect(Rect.fromLTWH(hx, gnd - hh, hw, hh));
      _steppedGable(p, hx, gnd - hh, hw, h);
    }

    // Large windmill (~60%)
    final mx = w * 0.60;
    final mh = h * 0.44;
    // body (trapezoid wider at base)
    final body = Path();
    body.moveTo(mx - w * 0.048, gnd);
    body.lineTo(mx + w * 0.048, gnd);
    body.lineTo(mx + w * 0.030, gnd - mh);
    body.lineTo(mx - w * 0.030, gnd - mh);
    body.close();
    p.addPath(body, Offset.zero);
    // cap roof
    _tri(p, mx - w * 0.030, gnd - mh, mx, gnd - mh - h * 0.065, mx + w * 0.030, gnd - mh);
    // sails — 4 arms
    final hub = Offset(mx, gnd - mh * 0.90);
    final sailLen = w * 0.115;
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 + math.pi / 8;
      final perp = angle + math.pi / 2;
      final tip = Offset(hub.dx + sailLen * math.cos(angle), hub.dy + sailLen * math.sin(angle));
      const t = 0.008;
      final blade = Path();
      blade.moveTo(hub.dx, hub.dy);
      blade.lineTo(tip.dx, tip.dy);
      blade.lineTo(tip.dx + w * t * math.cos(perp), tip.dy + w * t * math.sin(perp));
      blade.lineTo(hub.dx + w * t * math.cos(perp), hub.dy + w * t * math.sin(perp));
      blade.close();
      p.addPath(blade, Offset.zero);
    }

    // Right buildings
    _building(p, w * 0.76, gnd, w * 0.07, h * 0.16);
    _building(p, w * 0.82, gnd, w * 0.07, h * 0.12);
    _building(p, w * 0.88, gnd, w * 0.06, h * 0.19);
    _building(p, w * 0.93, gnd, w * 0.07, h * 0.14);

    p.addRect(Rect.fromLTWH(0, gnd, w, h - gnd));
    return p;
  }

  // ─── Copenhagen ────────────────────────────────────────────────────────────
  // Landmarks: Nyhavn-style coloured row (left) + Vor Frelsers Kirke spire (right-centre)
  Path _copenhagenPath(double w, double h) {
    final p = Path();
    final gnd = h * 0.70;

    // Nyhavn row — varied widths and heights
    final widths  = [0.08, 0.07, 0.09, 0.07, 0.08, 0.07, 0.06, 0.08];
    final heights = [0.24, 0.18, 0.28, 0.21, 0.26, 0.17, 0.22, 0.20];
    var x = 0.0;
    for (var i = 0; i < widths.length; i++) {
      final bw = w * widths[i];
      final bh = h * heights[i];
      p.addRect(Rect.fromLTWH(x, gnd - bh, bw, bh));
      _tri(p, x, gnd - bh, x + bw / 2, gnd - bh - h * 0.055, x + bw, gnd - bh);
      x += bw + 2;
    }

    // Vor Frelsers Kirke (~70%)
    final sx = w * 0.71;
    _building(p, sx - w * 0.055, gnd, w * 0.11, h * 0.26); // church body
    _building(p, sx - w * 0.022, gnd - h * 0.26, w * 0.044, h * 0.08); // tower
    _building(p, sx - w * 0.014, gnd - h * 0.34, w * 0.028, h * 0.05); // spire base
    // Very tall tapering spire (characteristic silhouette)
    _tri(p, sx - w * 0.014, gnd - h * 0.34, sx, gnd - h * 0.65, sx + w * 0.014, gnd - h * 0.34);

    // Right buildings
    _building(p, w * 0.79, gnd, w * 0.07, h * 0.17);
    _building(p, w * 0.85, gnd, w * 0.07, h * 0.13);
    _building(p, w * 0.91, gnd, w * 0.09, h * 0.19);

    p.addRect(Rect.fromLTWH(0, gnd, w, h - gnd));
    return p;
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  void _building(Path p, double x, double gnd, double bw, double bh) {
    p.addRect(Rect.fromLTWH(x, gnd - bh, bw, bh));
  }

  void _tri(Path p, double x1, double y1, double x2, double y2, double x3, double y3) {
    p.addPath(
      Path()
        ..moveTo(x1, y1)
        ..lineTo(x2, y2)
        ..lineTo(x3, y3)
        ..close(),
      Offset.zero,
    );
  }

  void _steppedGable(Path p, double x, double top, double bw, double h) {
    final sw = bw * 0.16;
    final sh = bw * 0.13;
    p.addRect(Rect.fromLTWH(x, top - sh, bw, sh));
    p.addRect(Rect.fromLTWH(x + sw, top - sh * 2, bw - sw * 2, sh));
    p.addRect(Rect.fromLTWH(x + sw * 2, top - sh * 3, bw - sw * 4, sh));
    _tri(p, x + sw * 2, top - sh * 3, x + bw / 2, top - sh * 4, x + bw - sw * 2, top - sh * 3);
  }

  @override
  bool shouldRepaint(_SkyPainter old) => old.cfg.city != cfg.city;
}

// ─── Koala surfer ─────────────────────────────────────────────────────────────

class _KoalaSurfer extends StatelessWidget {
  final Color waveColor;
  const _KoalaSurfer({required this.waveColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🐨', style: TextStyle(fontSize: 38))
            .animate(onPlay: (c) => c.repeat())
            .moveY(begin: 0, end: -5, duration: 1400.ms, curve: Curves.easeInOut)
            .then()
            .moveY(begin: -5, end: 0, duration: 1400.ms, curve: Curves.easeInOut),
        // Surfboard — colourful so it stands out
        Transform.rotate(
          angle: -0.14,
          child: Container(
            width: 80,
            height: 16,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFDE68A), Color(0xFFF97316)],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
