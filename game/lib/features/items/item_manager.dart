enum ItemType { consumable, passive }

enum ItemEffect { heal, buffStrength, none }

class Item {
  final String id;
  final String name;
  final String description;
  final ItemType type;
  final ItemEffect effect;
  final int value; // Effect magnitude (e.g. heal amount)
  final int price;

  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.effect,
    required this.value,
    this.price = 10,
  });
}

class ItemManager {
  static const List<Item> allItems = [
    Item(
      id: 'potion_small',
      name: 'Small Potion',
      description: 'Restores 20 HP.',
      type: ItemType.consumable,
      effect: ItemEffect.heal,
      value: 20,
      price: 15,
    ),
    Item(
      id: 'potion_large',
      name: 'Large Potion',
      description: 'Restores 50 HP.',
      type: ItemType.consumable,
      effect: ItemEffect.heal,
      value: 50,
      price: 35, // Reduced from 40
    ),
    Item(
      id: 'elixir_strength',
      name: 'Strength Elixir',
      description: 'Increases attack temporarily (Not Implemented).',
      type: ItemType.consumable,
      effect: ItemEffect.buffStrength,
      value: 5,
      price: 80, // Reduced from 100
    ),
  ];

  static Item? getItem(String id) {
    try {
      return allItems.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }
}
