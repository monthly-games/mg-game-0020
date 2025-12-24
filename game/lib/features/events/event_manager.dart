import 'dart:math';
import '../../core/game_state.dart';
import '../items/item_manager.dart';

enum EventType { fountain, trap, treasure }

class GameEvent {
  final String title;
  final String description;
  final EventType type;

  GameEvent(this.title, this.description, this.type);
}

class EventManager {
  static final Random _rng = Random();

  static GameEvent generateEvent(int floor) {
    final roll = _rng.nextDouble();
    if (roll < 0.4) {
      return GameEvent(
        'Mysterious Fountain',
        'You find a glowing fountain. Drink?',
        EventType.fountain,
      );
    } else if (roll < 0.7) {
      return GameEvent(
        'Old Chest',
        'A dusty chest sits in the corner.',
        EventType.treasure,
      );
    } else {
      return GameEvent('Spike Trap', 'Watch your step!', EventType.trap);
    }
  }

  static String resolveEvent(GameEvent event, GameState gameState) {
    switch (event.type) {
      case EventType.fountain:
        gameState.heal(30);
        return 'You drank from the fountain and recovered 30 HP.';
      case EventType.trap:
        gameState.takeDamage(10);
        return 'The trap triggered! You took 10 damage.';
      case EventType.treasure:
        final gold = 20 + _rng.nextInt(30);
        gameState.addGold(gold);
        // Chance for item
        if (_rng.nextBool()) {
          final item = ItemManager.getItem('potion_small');
          if (item != null) {
            gameState.addItem(item);
            return 'You found $gold Gold and a ${item.name}!';
          }
        }
        return 'You found $gold Gold.';
    }
  }
}
