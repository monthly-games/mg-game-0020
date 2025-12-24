import 'package:get_it/get_it.dart';
import 'package:mg_common_game/core/audio/audio_manager.dart';
import '../../core/game_state.dart';
import 'enemy_data.dart';

class BattleManager {
  final GameState gameState;
  late EnemyData enemy;
  int currentEnemyHp = 0;

  BattleManager(this.gameState) {
    enemy = EnemyFactory.generateEnemy(gameState.floor);
    currentEnemyHp = enemy.hp;
  }

  String playerAttack() {
    int dmg = gameState.playerDamage;
    currentEnemyHp -= dmg;
    if (currentEnemyHp < 0) currentEnemyHp = 0;

    _playSfx('sfx_attack_player');

    return 'You hit ${enemy.name} for $dmg damage!';
  }

  String enemyTurn() {
    if (currentEnemyHp <= 0) return '';

    int dmg = enemy.damage;
    gameState.takeDamage(dmg);

    _playSfx('sfx_hit_player');

    return '${enemy.name} dealt $dmg damage!';
  }

  void _playSfx(String name) {
    try {
      GetIt.I<AudioManager>().playSfx(name);
    } catch (e) {
      // Ignore audio errors during testing/if missing
    }
  }

  bool get isVictory => currentEnemyHp <= 0;
  bool get isDefeat => gameState.currentHp <= 0;
}
