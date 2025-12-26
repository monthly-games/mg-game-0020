import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

/// VFX Manager for Time Slip Explorers (MG-0020)
/// Time Loop + Roguelite + Exploration 게임 전용 이펙트 관리자
class VfxManager extends Component with HasGameRef {
  VfxManager();
  final Random _random = Random();

  // Time Loop Effects
  void showLoopReset(Vector2 centerPosition) {
    // 화면 전체 플래시 효과
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (!isMounted) return;
        gameRef.add(_createExplosionEffect(position: centerPosition, color: i == 0 ? Colors.white : Colors.cyan.withOpacity(0.7), count: 40 - i * 10, radius: 120 - i * 20.0));
      });
    }
    _triggerScreenShake(intensity: 8, duration: 0.5);
    gameRef.add(_LoopResetText(position: centerPosition));
  }

  void showTimeWarp(Vector2 position) {
    gameRef.add(_createSpiralEffect(position: position, color: Colors.cyan));
    gameRef.add(_createSparkleEffect(position: position, color: Colors.white, count: 15));
  }

  void showTimelineBranch(Vector2 position, bool isGoodPath) {
    final color = isGoodPath ? Colors.green : Colors.purple;
    gameRef.add(_createExplosionEffect(position: position, color: color, count: 25, radius: 55));
    gameRef.add(_createSparkleEffect(position: position, color: Colors.white, count: 12));
  }

  // Exploration Effects
  void showStageEntrance(Vector2 position) {
    gameRef.add(_PortalEffect(position: position));
    gameRef.add(_createSparkleEffect(position: position, color: Colors.cyan, count: 18));
  }

  void showDiscovery(Vector2 position) {
    gameRef.add(_createExplosionEffect(position: position, color: Colors.amber, count: 20, radius: 50));
    gameRef.add(_createSparkleEffect(position: position, color: Colors.yellow, count: 12));
    showNumberPopup(position, 'DISCOVERED!', color: Colors.amber);
  }

  void showSecretFound(Vector2 position) {
    gameRef.add(_createExplosionEffect(position: position, color: Colors.purple, count: 30, radius: 60));
    gameRef.add(_createSparkleEffect(position: position, color: Colors.white, count: 18));
    gameRef.add(_SecretText(position: position));
  }

  // Meta Progression Effects
  void showMetaTierUp(Vector2 position) {
    gameRef.add(_createExplosionEffect(position: position, color: Colors.amber, count: 45, radius: 80));
    for (int i = 0; i < 5; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (!isMounted) return;
        gameRef.add(_createSparkleEffect(position: position + Vector2((_random.nextDouble() - 0.5) * 80, (_random.nextDouble() - 0.5) * 60), color: Colors.yellow, count: 8));
      });
    }
    gameRef.add(_TierUpText(position: position));
    _triggerScreenShake(intensity: 4, duration: 0.3);
  }

  void showKnowledgeUnlock(Vector2 position) {
    gameRef.add(_createRisingEffect(position: position, color: Colors.lightBlue, count: 15, speed: 70));
    gameRef.add(_createSparkleEffect(position: position, color: Colors.cyan, count: 12));
    gameRef.add(_KnowledgeText(position: position));
  }

  // Combat Effects
  void showDamageNumber(Vector2 position, int damage, {bool isCritical = false}) {
    gameRef.add(_DamageNumber(position: position, damage: damage, isCritical: isCritical));
  }

  void showSkillActivation(Vector2 position, Color skillColor) {
    gameRef.add(_createConvergeEffect(position: position, color: skillColor));
    gameRef.add(_createGroundCircle(position: position, color: skillColor));
  }

  void showEnemyDeath(Vector2 position) {
    gameRef.add(_createExplosionEffect(position: position, color: Colors.red, count: 18, radius: 45));
    gameRef.add(_createSmokeEffect(position: position, count: 6));
  }

  void showNumberPopup(Vector2 position, String text, {Color color = Colors.white}) {
    gameRef.add(_NumberPopup(position: position, text: text, color: color));
  }

  void _triggerScreenShake({double intensity = 5, double duration = 0.3}) {
    if (gameRef.camera.viewfinder.children.isNotEmpty) {
      gameRef.camera.viewfinder.add(MoveByEffect(Vector2(intensity, 0), EffectController(duration: duration / 10, repeatCount: (duration * 10).toInt(), alternate: true)));
    }
  }

  // Private generators
  ParticleSystemComponent _createExplosionEffect({required Vector2 position, required Color color, required int count, required double radius}) {
    return ParticleSystemComponent(particle: Particle.generate(count: count, lifespan: 0.7, generator: (i) {
      final angle = _random.nextDouble() * 2 * pi; final speed = radius * (0.4 + _random.nextDouble() * 0.6);
      return AcceleratedParticle(position: position.clone(), speed: Vector2(cos(angle), sin(angle)) * speed, acceleration: Vector2(0, 90), child: ComputedParticle(renderer: (canvas, particle) {
        final opacity = (1.0 - particle.progress).clamp(0.0, 1.0);
        canvas.drawCircle(Offset.zero, 5 * (1.0 - particle.progress * 0.3), Paint()..color = color.withOpacity(opacity));
      }));
    }));
  }

  ParticleSystemComponent _createSpiralEffect({required Vector2 position, required Color color}) {
    return ParticleSystemComponent(particle: Particle.generate(count: 20, lifespan: 1.0, generator: (i) {
      final startAngle = (i / 20) * 4 * pi;
      return ComputedParticle(renderer: (canvas, particle) {
        final progress = particle.progress;
        final angle = startAngle + progress * 2 * pi;
        final radius = 50 * (1.0 - progress);
        final x = cos(angle) * radius;
        final y = sin(angle) * radius;
        final opacity = (1.0 - progress).clamp(0.0, 1.0);
        canvas.drawCircle(Offset(position.x + x, position.y + y), 3, Paint()..color = color.withOpacity(opacity));
      });
    }));
  }

  ParticleSystemComponent _createConvergeEffect({required Vector2 position, required Color color}) {
    return ParticleSystemComponent(particle: Particle.generate(count: 12, lifespan: 0.5, generator: (i) {
      final startAngle = (i / 12) * 2 * pi; final startPos = Vector2(cos(startAngle), sin(startAngle)) * 50;
      return MovingParticle(from: position + startPos, to: position.clone(), child: ComputedParticle(renderer: (canvas, particle) {
        canvas.drawCircle(Offset.zero, 4, Paint()..color = color.withOpacity((1.0 - particle.progress * 0.5).clamp(0.0, 1.0)));
      }));
    }));
  }

  ParticleSystemComponent _createSparkleEffect({required Vector2 position, required Color color, required int count}) {
    return ParticleSystemComponent(particle: Particle.generate(count: count, lifespan: 0.55, generator: (i) {
      final angle = _random.nextDouble() * 2 * pi; final speed = 50 + _random.nextDouble() * 40;
      return AcceleratedParticle(position: position.clone(), speed: Vector2(cos(angle), sin(angle)) * speed, acceleration: Vector2(0, 40), child: ComputedParticle(renderer: (canvas, particle) {
        final opacity = (1.0 - particle.progress).clamp(0.0, 1.0); final size = 3 * (1.0 - particle.progress * 0.5);
        final path = Path(); for (int j = 0; j < 4; j++) { final a = (j * pi / 2); if (j == 0) path.moveTo(cos(a) * size, sin(a) * size); else path.lineTo(cos(a) * size, sin(a) * size); } path.close();
        canvas.drawPath(path, Paint()..color = color.withOpacity(opacity));
      }));
    }));
  }

  ParticleSystemComponent _createRisingEffect({required Vector2 position, required Color color, required int count, required double speed}) {
    return ParticleSystemComponent(particle: Particle.generate(count: count, lifespan: 0.9, generator: (i) {
      final spreadX = (_random.nextDouble() - 0.5) * 35;
      return AcceleratedParticle(position: position.clone() + Vector2(spreadX, 0), speed: Vector2(0, -speed), acceleration: Vector2(0, -20), child: ComputedParticle(renderer: (canvas, particle) {
        final opacity = (1.0 - particle.progress).clamp(0.0, 1.0);
        canvas.drawCircle(Offset.zero, 3, Paint()..color = color.withOpacity(opacity));
      }));
    }));
  }

  ParticleSystemComponent _createSmokeEffect({required Vector2 position, required int count}) {
    return ParticleSystemComponent(particle: Particle.generate(count: count, lifespan: 0.7, generator: (i) {
      return AcceleratedParticle(position: position.clone() + Vector2((_random.nextDouble() - 0.5) * 20, 0), speed: Vector2((_random.nextDouble() - 0.5) * 15, -25 - _random.nextDouble() * 15), acceleration: Vector2(0, -8), child: ComputedParticle(renderer: (canvas, particle) {
        final progress = particle.progress; final opacity = (0.4 - progress * 0.4).clamp(0.0, 1.0);
        canvas.drawCircle(Offset.zero, 5 + progress * 8, Paint()..color = Colors.grey.withOpacity(opacity));
      }));
    }));
  }

  ParticleSystemComponent _createGroundCircle({required Vector2 position, required Color color}) {
    return ParticleSystemComponent(particle: Particle.generate(count: 1, lifespan: 0.6, generator: (i) {
      return ComputedParticle(renderer: (canvas, particle) {
        final progress = particle.progress; final opacity = (1.0 - progress).clamp(0.0, 1.0);
        canvas.drawCircle(Offset(position.x, position.y), 15 + progress * 35, Paint()..color = color.withOpacity(opacity * 0.4)..style = PaintingStyle.stroke..strokeWidth = 2);
      });
    }));
  }
}

class _PortalEffect extends PositionComponent {
  _PortalEffect({required Vector2 position}) : super(position: position, anchor: Anchor.center);
  double _time = 0;
  @override void update(double dt) { super.update(dt); _time += dt; if (_time > 2.0) removeFromParent(); }
  @override void render(Canvas canvas) {
    final progress = (_time / 2.0).clamp(0.0, 1.0);
    final opacity = progress < 0.5 ? progress * 2 : (1.0 - progress) * 2;
    for (int i = 0; i < 3; i++) {
      final radius = 25 + i * 15 + sin(_time * 4 + i) * 5;
      canvas.drawCircle(Offset.zero, radius, Paint()..color = Colors.cyan.withOpacity(opacity * (0.5 - i * 0.12))..style = PaintingStyle.stroke..strokeWidth = 3);
    }
  }
}

class _DamageNumber extends TextComponent {
  _DamageNumber({required Vector2 position, required int damage, required bool isCritical}) : super(text: '$damage', position: position, anchor: Anchor.center, textRenderer: TextPaint(style: TextStyle(fontSize: isCritical ? 24 : 16, fontWeight: FontWeight.bold, color: isCritical ? Colors.yellow : Colors.white, shadows: const [Shadow(color: Colors.black, blurRadius: 4, offset: Offset(1, 1))])));
  @override Future<void> onLoad() async { await super.onLoad(); add(MoveByEffect(Vector2(0, -40), EffectController(duration: 0.7, curve: Curves.easeOut))); add(OpacityEffect.fadeOut(EffectController(duration: 0.7, startDelay: 0.2))); add(RemoveEffect(delay: 0.9)); }
}

class _LoopResetText extends TextComponent {
  _LoopResetText({required Vector2 position}) : super(text: 'TIME LOOP RESET', position: position, anchor: Anchor.center, textRenderer: TextPaint(style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3, shadows: [Shadow(color: Colors.cyan, blurRadius: 15)])));
  @override Future<void> onLoad() async { await super.onLoad(); scale = Vector2.all(0.3); add(ScaleEffect.to(Vector2.all(1.1), EffectController(duration: 0.4, curve: Curves.elasticOut))); add(OpacityEffect.fadeOut(EffectController(duration: 2.0, startDelay: 1.0))); add(RemoveEffect(delay: 3.0)); }
}

class _SecretText extends TextComponent {
  _SecretText({required Vector2 position}) : super(text: 'SECRET FOUND!', position: position + Vector2(0, -40), anchor: Anchor.center, textRenderer: TextPaint(style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple, shadows: [Shadow(color: Colors.purple, blurRadius: 10)])));
  @override Future<void> onLoad() async { await super.onLoad(); scale = Vector2.all(0.5); add(ScaleEffect.to(Vector2.all(1.0), EffectController(duration: 0.3, curve: Curves.elasticOut))); add(MoveByEffect(Vector2(0, -20), EffectController(duration: 1.0, curve: Curves.easeOut))); add(OpacityEffect.fadeOut(EffectController(duration: 1.0, startDelay: 0.5))); add(RemoveEffect(delay: 1.5)); }
}

class _TierUpText extends TextComponent {
  _TierUpText({required Vector2 position}) : super(text: 'TIER UP!', position: position, anchor: Anchor.center, textRenderer: TextPaint(style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber, letterSpacing: 2, shadows: [Shadow(color: Colors.orange, blurRadius: 12)])));
  @override Future<void> onLoad() async { await super.onLoad(); scale = Vector2.all(0.3); add(ScaleEffect.to(Vector2.all(1.0), EffectController(duration: 0.4, curve: Curves.elasticOut))); add(RemoveEffect(delay: 2.5)); }
}

class _KnowledgeText extends TextComponent {
  _KnowledgeText({required Vector2 position}) : super(text: 'KNOWLEDGE+', position: position + Vector2(0, -35), anchor: Anchor.center, textRenderer: TextPaint(style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan, shadows: [Shadow(color: Colors.blue, blurRadius: 8)])));
  @override Future<void> onLoad() async { await super.onLoad(); scale = Vector2.all(0.5); add(ScaleEffect.to(Vector2.all(1.0), EffectController(duration: 0.3, curve: Curves.elasticOut))); add(MoveByEffect(Vector2(0, -15), EffectController(duration: 1.0, curve: Curves.easeOut))); add(OpacityEffect.fadeOut(EffectController(duration: 1.0, startDelay: 0.4))); add(RemoveEffect(delay: 1.4)); }
}

class _NumberPopup extends TextComponent {
  _NumberPopup({required Vector2 position, required String text, required Color color}) : super(text: text, position: position, anchor: Anchor.center, textRenderer: TextPaint(style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color, shadows: const [Shadow(color: Colors.black, blurRadius: 4, offset: Offset(1, 1))])));
  @override Future<void> onLoad() async { await super.onLoad(); add(MoveByEffect(Vector2(0, -25), EffectController(duration: 0.6, curve: Curves.easeOut))); add(OpacityEffect.fadeOut(EffectController(duration: 0.6, startDelay: 0.2))); add(RemoveEffect(delay: 0.8)); }
}
