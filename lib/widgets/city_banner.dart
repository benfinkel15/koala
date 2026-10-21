import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ─── Public entry point ───────────────────────────────────────────────────

class CityBanner extends StatelessWidget {
  final String langCode;
  final double height;

  const CityBanner({super.key, required this.langCode, this.height = 180});

  @override
  Widget build(BuildContext context) {
    final cfg = _config(langCode);
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Sky + city + wave painted background
          Positioned.fill(
            child: CustomPaint(painter: _SkyPainter(cfg: cfg)),
          ),
          // Surfing koala positioned on the wave
          Positioned(
            bottom: height * 0.10,
            left: MediaQuery.of(context).size.width * 0.55,
            child: _KoalaSurfer(waveColor: cfg.waveColor),
          ),
        ],
      ),
    );
  }

  static _BannerConfig _config(String lang) {
    switch (lang) {
      case 'nl':
        return const _BannerConfig(
          skyTop: Color(0xFFD4683A),
          skyBottom: Color(0xFFF7C580),
          waveColor: Color(0xFF3D8FA8),
          waveColor2: Color(0xFF5AB0CC),
          cityColor: Color(0xFF1A1A2E),
          city: _CityStyle.amsterdam,
        );
      case 'da':
        return const _BannerConfig(
          skyTop: Color(0xFF2B5FA8),
          skyBottom: Color(0xFFF0C060),
          waveColor: Color(0xFF3A8FA0),
          waveColor2: Color(0xFF5AB8C8),
          cityColor: Color(0xFF1A2A3A),
          city: _CityStyle.copenhagen,
        );
      default: // de
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
}

// ─── Config ───────────────────────────────────────────────────────────────

enum _CityStyle { berlin, amsterdam, copenhagen }

class _BannerConfig {
  final Color skyTop;
  final Color skyBottom;
  final Color waveColor;
  final Color waveColor2;
  final Color cityColor;
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

// ─── Sky + City + Wave painter ────────────────────────────────────────────

class _SkyPainter extends CustomPainter {
  final _BannerConfig cfg;
  const _SkyPainter({required this.cfg});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sky gradient
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [cfg.skyTop, cfg.skyBottom],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // City silhouette
    final cityPaint = Paint()
      ..color = cfg.cityColor
      ..style = PaintingStyle.fill;
    final cityPath = _buildCityPath(cfg.city, w, h);
    canvas.drawPath(cityPath, cityPaint);

    // Back wave (lighter)
    _drawWave(
      canvas,
      size,
      color: cfg.waveColor2,
      heightFraction: 0.35,
      phaseShift: 0.3,
      amplitude: 0.05,
    );

    // Front wave
    _drawWave(
      canvas,
      size,
      color: cfg.waveColor,
      heightFraction: 0.28,
      phaseShift: 0.0,
      amplitude: 0.04,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size, {
    required Color color,
    required double heightFraction,
    required double phaseShift,
    required double amplitude,
  }) {
    final w = size.width;
    final h = size.height;
    final baseY = h * (1 - heightFraction);
    final amp = h * amplitude;

    final path = Path()..moveTo(0, h);
    path.lineTo(0, baseY + amp * math.sin(phaseShift * math.pi * 2));

    final steps = 40;
    for (var i = 0; i <= steps; i++) {
      final x = w * i / steps;
      final y = baseY + amp * math.sin((i / steps + phaseShift) * math.pi * 2);
      path.lineTo(x, y);
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

  // Berlin: Fernsehturm + generic skyline
  Path _berlinPath(double w, double h) {
    final p = Path();
    final ground = h * 0.72;

    // Left buildings
    _addBuilding(p, w * 0.0, ground, w * 0.10, h * 0.20);
    _addBuilding(p, w * 0.09, ground, w * 0.07, h * 0.14);
    _addBuilding(p, w * 0.15, ground, w * 0.08, h * 0.24);
    _addBuilding(p, w * 0.22, ground, w * 0.06, h * 0.17);

    // Brandenburg Gate (simplified) — two pillars + pediment
    final gx = w * 0.30;
    _addBuilding(p, gx, ground, w * 0.025, h * 0.22);           // left pillar
    _addBuilding(p, gx + w * 0.065, ground, w * 0.025, h * 0.22); // right pillar
    // lintel
    p.addRect(Rect.fromLTWH(gx, ground - h * 0.22, w * 0.115, h * 0.03));
    // pediment (triangle)
    final peak = Path();
    peak.moveTo(gx, ground - h * 0.22);
    peak.lineTo(gx + w * 0.057, ground - h * 0.27);
    peak.lineTo(gx + w * 0.115, ground - h * 0.22);
    peak.close();
    p.addPath(peak, Offset.zero);

    // More buildings
    _addBuilding(p, w * 0.45, ground, w * 0.06, h * 0.19);
    _addBuilding(p, w * 0.50, ground, w * 0.05, h * 0.13);

    // TV Tower (Fernsehturm) — thin column + sphere + spire
    final tx = w * 0.60;
    p.addRect(Rect.fromLTWH(tx - w * 0.008, ground, w * 0.016, -h * 0.55)); // column
    p.addOval(Rect.fromCenter(                                                 // sphere
      center: Offset(tx, ground - h * 0.44),
      width: w * 0.055,
      height: w * 0.05,
    ));
    p.addRect(Rect.fromLTWH(tx - w * 0.003, ground - h * 0.60, w * 0.006, h * 0.14)); // spire

    // Right buildings
    _addBuilding(p, w * 0.66, ground, w * 0.08, h * 0.20);
    _addBuilding(p, w * 0.73, ground, w * 0.09, h * 0.15);
    _addBuilding(p, w * 0.81, ground, w * 0.07, h * 0.22);
    _addBuilding(p, w * 0.87, ground, w * 0.06, h * 0.17);
    _addBuilding(p, w * 0.92, ground, w * 0.08, h * 0.12);

    // Ground fill
    p.addRect(Rect.fromLTWH(0, ground, w, h - ground));

    return p;
  }

  // Amsterdam: stepped-gable canal houses + windmill
  Path _amsterdamPath(double w, double h) {
    final p = Path();
    final ground = h * 0.72;

    // Stepped gable houses (left to right)
    final houses = [
      (0.00, 0.10, 0.24, true),   // (x, width, height as fraction, has_gable)
      (0.09, 0.09, 0.20, true),
      (0.17, 0.10, 0.17, true),
      (0.26, 0.08, 0.22, true),
      (0.33, 0.09, 0.19, true),
      (0.41, 0.10, 0.23, true),
      (0.50, 0.08, 0.16, false),
    ];

    for (final house in houses) {
      final hx = w * house.$1;
      final hw = w * house.$2;
      final hh = h * house.$3;
      final hasGable = house.$4;

      p.addRect(Rect.fromLTWH(hx, ground - hh, hw, hh));
      if (hasGable) {
        _addSteppedGable(p, hx, ground - hh, hw);
      } else {
        // triangular roof
        final roof = Path();
        roof.moveTo(hx, ground - hh);
        roof.lineTo(hx + hw / 2, ground - hh - h * 0.07);
        roof.lineTo(hx + hw, ground - hh);
        roof.close();
        p.addPath(roof, Offset.zero);
      }
    }

    // Windmill (right side)
    final mx = w * 0.72;
    final mh = h * 0.30;
    // mill body (trapezoid)
    final mill = Path();
    mill.moveTo(mx - w * 0.03, ground);
    mill.lineTo(mx + w * 0.03, ground);
    mill.lineTo(mx + w * 0.02, ground - mh);
    mill.lineTo(mx - w * 0.02, ground - mh);
    mill.close();
    p.addPath(mill, Offset.zero);
    // sails (4 lines from center)
    final cx = mx;
    final cy = ground - mh * 0.75;
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 + math.pi / 6;
      final sailLen = w * 0.055;
      final blade = Path();
      blade.moveTo(cx, cy);
      blade.lineTo(cx + sailLen * math.cos(angle), cy + sailLen * math.sin(angle));
      // thicken the blade
      final perp = angle + math.pi / 2;
      blade.lineTo(
          cx + sailLen * math.cos(angle) + w * 0.005 * math.cos(perp),
          cy + sailLen * math.sin(angle) + w * 0.005 * math.sin(perp));
      blade.lineTo(cx + w * 0.005 * math.cos(perp), cy + w * 0.005 * math.sin(perp));
      blade.close();
      p.addPath(blade, Offset.zero);
    }

    // More buildings to the right
    _addBuilding(p, w * 0.80, ground, w * 0.08, h * 0.18);
    _addBuilding(p, w * 0.87, ground, w * 0.07, h * 0.14);
    _addBuilding(p, w * 0.93, ground, w * 0.07, h * 0.20);

    p.addRect(Rect.fromLTWH(0, ground, w, h - ground));
    return p;
  }

  // Copenhagen: Nyhavn-style row + church spire
  Path _copenhagenPath(double w, double h) {
    final p = Path();
    final ground = h * 0.72;

    // Row of varied-height buildings (Nyhavn feel)
    final widths = [0.09, 0.08, 0.07, 0.09, 0.08, 0.07, 0.09, 0.08, 0.07];
    final heights = [0.22, 0.18, 0.26, 0.20, 0.24, 0.17, 0.22, 0.19, 0.21];
    var x = 0.0;
    for (var i = 0; i < widths.length; i++) {
      final bw = w * widths[i];
      final bh = h * heights[i];
      p.addRect(Rect.fromLTWH(x, ground - bh, bw, bh));
      // simple triangular roof
      final roof = Path();
      roof.moveTo(x, ground - bh);
      roof.lineTo(x + bw / 2, ground - bh - h * 0.06);
      roof.lineTo(x + bw, ground - bh);
      roof.close();
      p.addPath(roof, Offset.zero);
      x += bw + 1;
    }

    // Vor Frelsers Kirke spiral spire (right area)
    final sx = w * 0.74;
    // church body
    p.addRect(Rect.fromLTWH(sx - w * 0.04, ground, w * 0.08, -h * 0.22));
    // spire (very tall thin triangle with spiral implied by slight taper)
    final spire = Path();
    spire.moveTo(sx - w * 0.015, ground - h * 0.22);
    spire.lineTo(sx, ground - h * 0.58);
    spire.lineTo(sx + w * 0.015, ground - h * 0.22);
    spire.close();
    p.addPath(spire, Offset.zero);

    // More buildings right
    _addBuilding(p, w * 0.80, ground, w * 0.08, h * 0.19);
    _addBuilding(p, w * 0.87, ground, w * 0.07, h * 0.15);
    _addBuilding(p, w * 0.93, ground, w * 0.07, h * 0.21);

    p.addRect(Rect.fromLTWH(0, ground, w, h - ground));
    return p;
  }

  void _addBuilding(Path p, double x, double ground, double w, double h) {
    p.addRect(Rect.fromLTWH(x, ground - h, w, h));
  }

  void _addSteppedGable(Path p, double x, double top, double w) {
    // Classic Dutch stepped gable: 3 steps
    final stepW = w * 0.15;
    final stepH = w * 0.12;
    final steps = [
      Rect.fromLTWH(x, top - stepH, w, stepH),
      Rect.fromLTWH(x + stepW, top - stepH * 2, w - stepW * 2, stepH),
      Rect.fromLTWH(x + stepW * 2, top - stepH * 3, w - stepW * 4, stepH),
    ];
    for (final s in steps) {
      p.addRect(s);
    }
    // peak triangle
    final peak = Path();
    peak.moveTo(x + stepW * 2, top - stepH * 3);
    peak.lineTo(x + w / 2, top - stepH * 4);
    peak.lineTo(x + w - stepW * 2, top - stepH * 3);
    peak.close();
    p.addPath(peak, Offset.zero);
  }

  @override
  bool shouldRepaint(_SkyPainter old) => old.cfg.city != cfg.city;
}

// ─── Koala surfer widget ──────────────────────────────────────────────────

class _KoalaSurfer extends StatelessWidget {
  final Color waveColor;
  const _KoalaSurfer({required this.waveColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Koala emoji
        const Text('🐨', style: TextStyle(fontSize: 36))
            .animate(onPlay: (c) => c.repeat())
            .moveY(
              begin: 0,
              end: -6,
              duration: 1200.ms,
              curve: Curves.easeInOut,
            )
            .then()
            .moveY(
              begin: -6,
              end: 0,
              duration: 1200.ms,
              curve: Curves.easeInOut,
            ),
        // Surfboard
        Transform.rotate(
          angle: -0.12,
          child: Container(
            width: 68,
            height: 11,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: waveColor.withValues(alpha: 0.4), width: 1),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 3)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
