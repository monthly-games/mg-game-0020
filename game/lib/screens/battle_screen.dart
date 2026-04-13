import 'package:mg_common_game/core/ui/layout/mg_spacing.dart';
import 'package:mg_common_game/core/localization/localization.dart';
import 'package:flutter/material.dart';
import '../../core/game_state.dart';
import '../features/dungeon/room.dart';
import '../../core/ui/floating_text.dart';
import '../features/battle/battle_manager.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';


class BattleScreen extends StatefulWidget {
  final GameState gameState;
  final Room room;
  final VoidCallback onVictory;
  final VoidCallback onDefeat;

  const BattleScreen({
    super.key,
    required this.gameState,
    required this.room,
    required this.onVictory,
    required this.onDefeat,
  });

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> with TickerProviderStateMixin {
  late BattleManager _battleManager;
  String log = 'Encounter started!';
  
  // FX
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  final List<Widget> _floatingEffects = [];

  @override
  void initState() {
    super.initState();
    _battleManager = BattleManager(widget.gameState);
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
        
    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeController.reset();
      }
    });
  }
  
  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _addFloatingText(String text, Color color, bool isEnemy) {
    // Randomize position slightly
    final double randomX = (isEnemy ? 0 : 0) + (DateTime.now().millisecondsSinceEpoch % 20 - 10).toDouble();
    
    // In a real app we'd get GlobalKey coords, but here we approximate
    // Enemy is top center, Player is bottom center
    final top = isEnemy ? 200.0 : 500.0;
    final left = MediaQuery.of(context).size.width / 2 - 20 + randomX;

    final key = UniqueKey();
    setState(() {
      _floatingEffects.add(
        Positioned(
          key: key,
          top: top,
          left: left,
          child: FloatingText(
            text: text,
            color: color,
            onComplete: () {
               setState(() {
                 _floatingEffects.removeWhere((element) => element.key == key);
               });
            },
          ),
        )
      );
    });
  }

  void _playerAttack() {
    setState(() {
      final prevEnemyHp = _battleManager.currentEnemyHp;
      
      log = _battleManager.playerAttack();
      
      final damageDealt = prevEnemyHp - _battleManager.currentEnemyHp;
      if (damageDealt > 0) {
        _addFloatingText(damageDealt.toString(), MGColors.textHighEmphasis, true);
        _shakeController.forward();
      }

      if (_battleManager.isVictory) {
        Future.delayed(const Duration(seconds: 1), widget.onVictory);
      } else {
        // Enemy Turn
        final prevPlayerHp = widget.gameState.currentHp;
        
        final enemyLog = _battleManager.enemyTurn();
        if (enemyLog.isNotEmpty) {
           log += '\n$enemyLog';
           final damageTaken = prevPlayerHp - widget.gameState.currentHp;
           if (damageTaken > 0) {
             _addFloatingText(damageTaken.toString(), MGColors.error, false);
             _shakeController.forward();
           }
        }
      }
      
      if (_battleManager.isDefeat) {
         Future.delayed(const Duration(seconds: 1), widget.onDefeat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final dx = _shakeAnimation.value * (DateTime.now().millisecond % 2 == 0 ? 1 : -1);
        return Transform.translate(
          offset: Offset(dx, 0),
          child: child,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(MGSpacing.md),
                child: Column(
                  children: [
                    // Enemy Area
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                             Text(
                              'Enemy: ${_battleManager.enemy.name}', 
                              style: const TextStyle(color: MGColors.error, fontSize: 20),
                            ),
                            const SizedBox(height: MGSpacing.sm),
                            Container(
                              width: 100, 
                              height: 100, 
                              color: Colors.redAccent,
                              child: const Icon(Icons.android, size: 50, color: MGColors.textHighEmphasis),
                            ),
                            const SizedBox(height: MGSpacing.sm),
                            LinearProgressIndicator(
                              value: _battleManager.enemy.maxHp > 0 ? _battleManager.currentEnemyHp / _battleManager.enemy.maxHp : 0,
                              valueColor: const AlwaysStoppedAnimation(MGColors.error),
                              backgroundColor: Colors.red[900],
                            ),
                            Text('${_battleManager.currentEnemyHp} / ${_battleManager.enemy.maxHp}', style: const TextStyle(color: MGColors.textHighEmphasis)),
                          ],
                        ),
                      ),
                    ),
                    
                    const Divider(color: MGColors.common),
  
                    // Log
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(MGSpacing.xs),
                       decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(log, style: const TextStyle(color: MGColors.textHighEmphasis), textAlign: TextAlign.center),
                    ),
                    
                    const SizedBox(height: MGSpacing.lg),
  
                    // Player Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text('YOU', style: TextStyle(color: MGColors.success)),
                            Text('${widget.gameState.currentHp} / ${widget.gameState.maxHp} HP', style: const TextStyle(color: MGColors.textHighEmphasis)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: !_battleManager.isVictory && !_battleManager.isDefeat ? _playerAttack : null,
                          style: ElevatedButton.styleFrom(backgroundColor: MGColors.error),
                          child: Text('ui_general_time_attack_max_distance_in'.tr),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Floating FX Layer
              ..._floatingEffects,
            ],
          ),
        ),
      ),
    );
  }
}
