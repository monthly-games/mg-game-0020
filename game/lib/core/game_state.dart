import 'package:flutter/foundation.dart';
import '../features/items/item_manager.dart';
import '../features/save/save_manager.dart';

class GameState extends ChangeNotifier {
  // Run Stats
  int currentHp = 100;
  int maxHp = 100;
  int floor = 1;
  int gold = 0; // Run currency
  int xp = 0; // Experience points earned in current run
  int level = 1; // Player level within current run

  // Inventory
  final List<Item> inventory = [];

  // Meta Stats
  int timeCrystals = 0; // Permanent currency

  // Upgrades (meta progression)
  int upgradeHpLevel = 0;
  int upgradeGoldLevel = 0;
  int upgradeDamageLevel = 0;

  // BALANCE FIX: Added player level scaling to match enemy scaling
  // Enemies scale 15% per floor (3.85x by floor 20), now players scale 10% per level
  // Level-up XP requirement: 50 * level (capped to prevent infinite scaling)
  int get xpToNextLevel => 50 * level;
  int get maxLevel => 20; // Cap to prevent power spiral

  // Derived Stats - now include both meta upgrades AND run-level scaling
  // Meta upgrades provide baseline, level-ups provide in-run scaling
  // BALANCE FIX: Added +10 HP and +2 ATK per level (10% scaling from base)
  int get playerMaxHp => (100 + (upgradeHpLevel * 10)) + ((level - 1) * 10);
  int get playerStartGold => upgradeGoldLevel * 50;
  int get playerDamage => (10 + (upgradeDamageLevel * 2)) + ((level - 1) * 2);

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
    xp = 0;
    level = 1;
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

  // BALANCE FIX: Added XP gain and level-up system
  // Players gain XP from defeating enemies, allowing them to scale during runs
  // This addresses the issue where enemies scale 3.85x by floor 20 but players didn't scale
  void addXp(int amount) {
    if (!isRunActive || level >= maxLevel) return;

    xp += amount;
    while (xp >= xpToNextLevel && level < maxLevel) {
      xp -= xpToNextLevel;
      _levelUp();
    }
    notifyListeners();
  }

  void _levelUp() {
    if (level >= maxLevel) return;

    level++;
    final oldMaxHp = maxHp;

    // Recalculate max HP with new level
    final newMaxHp = (100 + (upgradeHpLevel * 10)) + ((level - 1) * 10);
    final hpGain = newMaxHp - oldMaxHp;

    maxHp = newMaxHp;
    currentHp += hpGain; // Also heal by the amount gained

    notifyListeners();
  }
}
