import 'package:flutter/material.dart';
import 'package:mg_common_game/core/localization/localization.dart';
import '../../core/game_state.dart';
import '../features/items/item_manager.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';


class ShopScreen extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onLeave;

  const ShopScreen({super.key, required this.gameState, required this.onLeave});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Merchant'),
        backgroundColor: Colors.brown[900],
        leading: IconButton(
          onPressed: onLeave,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('progress_gold_gamestategold'.tr),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ItemManager.allItems.length,
        itemBuilder: (ctx, index) {
          final item = ItemManager.allItems[index];
          return ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.amber),
            title: Text(item.name, style: const TextStyle(color: MGColors.textHighEmphasis)),
            subtitle: Text(
              item.description,
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: ElevatedButton(
              onPressed: gameState.gold >= item.price
                  ? () {
                      gameState.addGold(-item.price);
                      gameState.addItem(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ui_general_bought_itemname'.tr)),
                      );
                    }
                  : null,
              child: Text('shop_itemprice_g'.tr),
            ),
          );
        },
      ),
    );
  }
}
