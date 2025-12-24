import 'package:flutter/foundation.dart';
import '../features/items/item_manager.dart';
import '../features/save/save_manager.dart';

class GameState extends ChangeNotifier {
  // Run Stats
  int currentHp = 100;
  int maxHp = 100;
  int floor = 1;
  int gold = 0; // Run currency

  // Inventory
  final List<Item> inventory = [];

  // Meta Stats
  int timeCrystals = 0; // Permanent currency

  // Upgrades
  int upgradeHpLevel = 0;
  int upgradeGoldLevel = 0;
  int upgradeDamageLevel = 0;

  // Derived Stats
  int get playerMaxHp => 100 + (upgradeHpLevel * 10);
  int get playerStartGold => upgradeGoldLevel * 50;
  int get playerDamage => 10 + (upgradeDamageLevel * 2);

  // State
  bool isRunActive = false;

  final SaveManager _saveManager = SaveManager();

  Future<void> loadMetaProgress() async {
    final data = await _saveManager.loadState();
    timeCrystals = data['timeCrystals'] ?? 0;
    upgradeHpLevel = data['upgradeHpLevel'] ?? 0;
    upgradeGoldLevel = data['upgradeGoldLevel'] ?? 0;
    upgradeDamageLevel = data['upgradeDamageLevel'] ?? 0;
    notifyListeners();
  }

  Future<void> saveMetaProgress() async {
    await _saveManager.saveState(
      timeCrystals: timeCrystals,
      upgradeHpLevel: upgradeHpLevel,
      upgradeGoldLevel: upgradeGoldLevel,
      upgradeDamageLevel: upgradeDamageLevel,
    );
  }

  void startNewRun() {
    maxHp = playerMaxHp;
    currentHp = maxHp;
    floor = 1;
    gold = playerStartGold;
    inventory.clear();
    // Start with a potion for testing
    final starterPotion = ItemManager.getItem('potion_small');
    if (starterPotion != null) inventory.add(starterPotion);

    isRunActive = true;
    notifyListeners();
  }

  void endRun({bool cleared = false}) {
    isRunActive = false;
    // Calculate meta rewards
    // 10% of gold becomes crystals
    final crystalsEarned = (gold * 0.1).floor();
    if (crystalsEarned > 0) {
      addCrystals(crystalsEarned);
    }
    // Auto-save on run end
    saveMetaProgress();

    notifyListeners();
  }

  void takeDamage(int amount) {
    currentHp -= amount;
    if (currentHp <= 0) {
      currentHp = 0;
      endRun();
    }
    notifyListeners();
  }

  void heal(int amount) {
    currentHp = (currentHp + amount).clamp(0, maxHp);
    notifyListeners();
  }

  void nextFloor() {
    floor++;
    notifyListeners();
  }

  void addGold(int amount) {
    gold += amount;
    notifyListeners();
  }

  void addCrystals(int amount) {
    timeCrystals += amount;
    notifyListeners();
  }

  void addItem(Item item) {
    inventory.add(item);
    notifyListeners();
  }

  bool useItem(Item item) {
    if (!inventory.contains(item)) return false;

    bool consumed = false;
    switch (item.effect) {
      case ItemEffect.heal:
        if (currentHp < maxHp) {
          heal(item.value);
          consumed = true;
        }
        break;
      case ItemEffect.buffStrength:
        // TODO: Implement buff logic
        consumed = true;
        break;
      case ItemEffect.none:
        break;
    }

    if (consumed && item.type == ItemType.consumable) {
      inventory.remove(item);
      notifyListeners();
    }

    return consumed;
  }
}
