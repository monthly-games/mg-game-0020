import 'package:flutter_test/flutter_test.dart';
import 'package:game/core/game_state.dart';
import 'package:game/features/items/item_manager.dart';

void main() {
  group('Item & Inventory Tests', () {
    late GameState gameState;

    setUp(() {
      gameState = GameState();
      gameState.startNewRun();
    });

    test('AddItem adds to inventory', () {
      final item = ItemManager.allItems.first;
      gameState.addItem(item);
      expect(gameState.inventory.contains(item), true);
    });

    test('Use Potion heals HP', () {
      gameState.takeDamage(50);
      expect(gameState.currentHp, 50);

      // Clear inventory to avoid starter item interference
      gameState.inventory.clear();

      final potion = ItemManager.getItem('potion_small'); // Heals 20
      gameState.addItem(potion!);

      gameState.useItem(potion);
      expect(gameState.currentHp, 70);
      expect(gameState.inventory.contains(potion), false);
    });

    test('Cannot use potion at max HP', () {
      final potion = ItemManager.getItem('potion_small');
      gameState.addItem(potion!);

      final consumed = gameState.useItem(potion);
      expect(consumed, false);
      expect(gameState.inventory.contains(potion), true);
    });
  });
}
