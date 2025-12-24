import 'package:flutter_test/flutter_test.dart';
import 'package:game/core/game_state.dart';

void main() {
  group('Core Loop Tests', () {
    late GameState gameState;

    setUp(() {
      gameState = GameState();
    });

    test('Start Run initializes stats', () {
      gameState.startNewRun();
      expect(gameState.currentHp, 100);
      expect(gameState.floor, 1);
      expect(gameState.isRunActive, true);
    });

    test('Damage reduces HP', () {
      gameState.startNewRun();
      gameState.takeDamage(10);
      expect(gameState.currentHp, 90);
    });

    test('Death ends run', () {
      gameState.startNewRun();
      gameState.takeDamage(100);
      expect(gameState.currentHp, 0);
      expect(gameState.isRunActive, false);
    });

    test('Next Floor increments floor', () {
      gameState.startNewRun();
      gameState.nextFloor();
      expect(gameState.floor, 2);
    });

    test('Heal logic clamps at MaxHP', () {
      gameState.startNewRun();
      gameState.takeDamage(10);
      gameState.heal(50);
      expect(gameState.currentHp, 100);
    });
  });
}
