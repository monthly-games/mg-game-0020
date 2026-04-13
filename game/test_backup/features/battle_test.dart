import 'package:flutter_test/flutter_test.dart';
import 'package:game/core/game_state.dart';
import 'package:game/features/battle/battle_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Battle Logic Tests', () {
    late GameState gameState;
    late BattleManager battleManager;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      gameState = GameState();
      gameState.startNewRun();
      battleManager = BattleManager(gameState);
    });

    test('Player attack reduces enemy HP', () {
      final initialHp = battleManager.currentEnemyHp;
      battleManager.playerAttack();
      expect(battleManager.currentEnemyHp, lessThan(initialHp));
    });

    test('Enemy turn reduces Player HP', () {
      final initialHp = gameState.currentHp;
      battleManager.enemyTurn();
      expect(gameState.currentHp, lessThan(initialHp));
    });

    test('Victory condition', () {
      // Set to 1 HP for easy kill
      battleManager.currentEnemyHp = 1;
      battleManager.playerAttack();
      expect(battleManager.isVictory, true);
      expect(battleManager.currentEnemyHp, 0);
    });

    test('Defeat condition', () {
      // Player dies
      gameState.currentHp = 1;
      // Enemy attack damage
      battleManager.enemyTurn();
      expect(battleManager.isDefeat, true);
    });
  });
}
