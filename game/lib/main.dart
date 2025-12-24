import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mg_common_game/core/audio/audio_manager.dart';
import 'package:mg_common_game/core/ui/theme/app_colors.dart';
import 'core/game_state.dart';
import 'features/dungeon/room.dart';
import 'screens/dungeon_screen.dart';
import 'screens/battle_screen.dart';
import 'screens/shop_screen.dart';
import 'features/events/event_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupDI();
  await GetIt.I<AudioManager>().initialize();
  runApp(const TimeSlipApp());
}

void _setupDI() {
  if (!GetIt.I.isRegistered<AudioManager>()) {
    GetIt.I.registerSingleton<AudioManager>(AudioManager());
  }
}

class TimeSlipApp extends StatelessWidget {
  const TimeSlipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Slip Expedition',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainGameScreen(),
    );
  }
}

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  final GameState _gameState = GameState();
  Room? _currentRoom;
  bool _showShop = false;

  @override
  void initState() {
    super.initState();
    GetIt.I<AudioManager>().playBgm('bgm_dungeon');
    _gameState.startNewRun();
  }

  void _onRoomSelected(Room room) {
    if (room.type == RoomType.battle || room.type == RoomType.boss) {
      setState(() {
        _currentRoom = room;
      });
    } else if (room.type == RoomType.event) {
      _handleEvent(room);
    } else if (room.type == RoomType.shop) {
      setState(() {
        _showShop = true;
      });
    }
  }

  void _handleEvent(Room room) {
    final event = EventManager.generateEvent(_gameState.floor);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(event.title),
        content: Text(event.description),
        actions: [
          TextButton(
            onPressed: () {
              final result = EventManager.resolveEvent(event, _gameState);
              Navigator.pop(ctx);
              _showEventResult(result);
            },
            child: const Text('Interact'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEventResult('You ignored the ${event.title}.');
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  void _showEventResult(String result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _gameState.nextFloor();
              setState(() {});
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _onBattleVictory() {
    setState(() {
      _currentRoom = null;
      _gameState.nextFloor();
    });
  }

  void _onBattleDefeat() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('YOU DIED'),
        content: Text('Floor reached: ${_gameState.floor}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _currentRoom = null;
                _showShop = false;
                _gameState.startNewRun();
              });
            },
            child: const Text('Time Loop Reset'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showShop) {
      return ShopScreen(
        gameState: _gameState,
        onLeave: () {
          setState(() {
            _showShop = false;
            _gameState.nextFloor();
          });
        },
      );
    }

    if (_currentRoom != null) {
      return BattleScreen(
        gameState: _gameState,
        room: _currentRoom!,
        onVictory: _onBattleVictory,
        onDefeat: _onBattleDefeat,
      );
    }

    return DungeonScreen(
      key: ValueKey(_gameState.floor),
      gameState: _gameState,
      onRoomSelected: _onRoomSelected,
    );
  }
}
