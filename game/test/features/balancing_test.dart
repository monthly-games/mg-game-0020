import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/battle/enemy_data.dart';
import 'package:game/features/items/item_manager.dart';

void main() {
  group('Balancing Tests', () {
    test('Enemy Scaling - Floor 1 (Base Stats)', () {
      final enemy = EnemyFactory.generateEnemy(1);
      // At floor 1, scale is 1.0
      // We can't predict exactly which enemy, but we can check if stats are reasonable
      expect(enemy.hp, greaterThanOrEqualTo(20));
    });

    test('Enemy Scaling - Floor 11 (Scaled Stats)', () {
      // Force a higher floor
      // Scale = 1.0 + ((11-1) * 0.15) = 1.0 + 1.5 = 2.5x multiplier
      final enemy = EnemyFactory.generateEnemy(11);

      // If we got a Rat (Base 20 HP), it should be 50 HP.
      // If we got a Wraith (Base 80 HP), it should be 200 HP.
      expect(enemy.hp, greaterThanOrEqualTo(50));
      expect(enemy.damage, greaterThanOrEqualTo(8)); // Base 3 * 2.5 = 7.5 -> 8
    });

    test('Item Prices are balanced', () {
      final potionSmall = ItemManager.getItem('potion_small');
      final potionLarge = ItemManager.getItem('potion_large');
      final elixir = ItemManager.getItem('elixir_strength');

      expect(potionSmall!.price, 15);
      expect(potionLarge!.price, 35);
      expect(elixir!.price, 80);
    });
  });
}
