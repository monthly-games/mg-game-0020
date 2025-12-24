import 'package:flutter/material.dart';
import '../core/game_state.dart';

class MetaShopScreen extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onBack;

  const MetaShopScreen({
    super.key,
    required this.gameState,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Crystal Exchange'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Crystals: ${gameState.timeCrystals}',
                style: const TextStyle(
                  color: Colors.purpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildUpgradeCard(
            context,
            'Vitality',
            'Max HP +10',
            gameState.upgradeHpLevel,
            50,
            () {
              if (gameState.timeCrystals >= 50) {
                gameState.addCrystals(-50);
                gameState.upgradeHpLevel++;
                gameState.saveMetaProgress();
              }
            },
          ),
          _buildUpgradeCard(
            context,
            'Wealth',
            'Start Gold +50',
            gameState.upgradeGoldLevel,
            100,
            () {
              if (gameState.timeCrystals >= 100) {
                gameState.addCrystals(-100);
                gameState.upgradeGoldLevel++;
                gameState.saveMetaProgress();
              }
            },
          ),
          _buildUpgradeCard(
            context,
            'Strength',
            'Damage +2',
            gameState.upgradeDamageLevel,
            200,
            () {
              if (gameState.timeCrystals >= 200) {
                gameState.addCrystals(-200);
                gameState.upgradeDamageLevel++;
                gameState.saveMetaProgress();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeCard(
    BuildContext context,
    String title,
    String description,
    int level,
    int cost,
    VoidCallback onBuy,
  ) {
    final canBuy = gameState.timeCrystals >= cost;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text('$title (Lvl $level)'),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: canBuy ? onBuy : null,
          child: Text('$cost 💎'),
        ),
      ),
    );
  }
}
