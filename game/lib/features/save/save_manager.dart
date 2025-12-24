import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  static const String _keyTimeCrystals = 'time_crystals';
  static const String _keyUpgradeHp = 'upgrade_hp';
  static const String _keyUpgradeGold = 'upgrade_gold';
  static const String _keyUpgradeDamage = 'upgrade_damage';

  Future<void> saveState({
    required int timeCrystals,
    required int upgradeHpLevel,
    required int upgradeGoldLevel,
    required int upgradeDamageLevel,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTimeCrystals, timeCrystals);
    await prefs.setInt(_keyUpgradeHp, upgradeHpLevel);
    await prefs.setInt(_keyUpgradeGold, upgradeGoldLevel);
    await prefs.setInt(_keyUpgradeDamage, upgradeDamageLevel);
  }

  Future<Map<String, int>> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'timeCrystals': prefs.getInt(_keyTimeCrystals) ?? 0,
      'upgradeHpLevel': prefs.getInt(_keyUpgradeHp) ?? 0,
      'upgradeGoldLevel': prefs.getInt(_keyUpgradeGold) ?? 0,
      'upgradeDamageLevel': prefs.getInt(_keyUpgradeDamage) ?? 0,
    };
  }

  Future<void> clearSave() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
