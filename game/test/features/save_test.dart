import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/save/save_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SaveManager Tests', () {
    late SaveManager saveManager;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      saveManager = SaveManager();
    });

    test('Save and Load State', () async {
      await saveManager.saveState(
        timeCrystals: 100,
        upgradeHpLevel: 2,
        upgradeGoldLevel: 1,
        upgradeDamageLevel: 5,
      );

      final data = await saveManager.loadState();

      expect(data['timeCrystals'], 100);
      expect(data['upgradeHpLevel'], 2);
      expect(data['upgradeGoldLevel'], 1);
      expect(data['upgradeDamageLevel'], 5);
    });

    test('Load State with no data returns defaults', () async {
      final data = await saveManager.loadState();

      expect(data['timeCrystals'], 0);
      expect(data['upgradeHpLevel'], 0);
      expect(data['upgradeGoldLevel'], 0);
      expect(data['upgradeDamageLevel'], 0);
    });
  });
}
