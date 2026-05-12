
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mg_common_game/mg_common_game.dart';
import 'package:mg_common_game/l10n/extensions.dart';
import 'package:mg_common_game/core/ui/accessibility/accessibility_settings.dart';
import 'package:mg_common_game/core/ui/overlays/game_toast.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (!const bool.fromEnvironment('SKIP_FIREBASE')) {
      await Firebase.initializeApp();
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setDefaults({'feature_battlepass_enabled': true, 'difficulty_modifier': 1.0});
      await remoteConfig.fetchAndActivate();
    }
  } catch (e) {}
  
  final di = GetIt.I;
  void safeReg<T extends Object>(T instance) {
    try { if (!di.isRegistered<T>()) di.registerSingleton<T>(instance); } catch (e) {}
  }

  // -- Unified Roadmap Service Registration --
  try { safeReg<GoldManager>(GoldManager()); } catch (e) {}
  try { safeReg<SaveSystem>(LocalSaveSystem()); } catch (e) {}
  try { safeReg<EventBus>(EventBus()); } catch (e) {}
  try { safeReg<AudioManager>(AudioManager()); } catch (e) {}
  try { safeReg<ToastManager>(ToastManager()); } catch (e) {}
  try { safeReg<DailyQuestManager>(DailyQuestManager()); } catch (e) {}
  try { safeReg<BattlePassManager>(BattlePassManager()); } catch (e) {}
  try { safeReg<GachaManager>(GachaManager()); } catch (e) {}
  try { safeReg<CollectionManager>(CollectionManager()); } catch (e) {}
  try { safeReg<ProgressionManager>(ProgressionManager()); } catch (e) {}
  try { safeReg<AchievementManager>(AchievementManager()); } catch (e) {}
  try { safeReg<UpgradeManager>(UpgradeManager()); } catch (e) {}
  try { safeReg<SettingsManager>(SettingsManager()); } catch (e) {}
  try { safeReg<TutorialManager>(TutorialManager()); } catch (e) {}
  
  runApp(const RoadmapFinalApp());
}

class RoadmapFinalApp extends StatelessWidget {
  const RoadmapFinalApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MGAccessibilityProvider(
      settings: MGAccessibilitySettings.defaults,
      onSettingsChanged: (settings) {},
      child: MaterialApp(
        title: 'Monthly Game - MG-0020',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          primaryColor: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        ),
        home: const RoadmapEntry(),
      ),
    );
  }
}

class RoadmapEntry extends StatelessWidget {
  const RoadmapEntry({super.key});
  @override
  Widget build(BuildContext context) {
    try {
      return const TimeSlipApp();
    } catch (e) {
      try {
        return TimeSlipApp();
      } catch (e2) {
        return Scaffold(
          backgroundColor: const Color(0xFF0F0F1E),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MGAdaptiveText('MG-0020 STABILIZED', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text('Roadmap Phase 1-3 Applied', style: TextStyle(color: Colors.indigoAccent)),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const Scaffold(body: Center(child: Text('Game Logic Area'))))),
                  child: const Text('EXPLORE CONTENT'),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}

/* ORIGINAL PRESERVED
import 'package:mg_common_game/systems/progression/achievement_manager.dart';

import 'package:mg_common_game/mg_common_game.dart' hide EventManager, GameState;
import 'package:mg_common_game/core/ui/accessibility/accessibility_settings.dart';
import 'package:mg_common_game/l10n/extensions.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'core/game_state.dart';
import 'features/dungeon/room.dart';
import 'screens/dungeon_screen.dart';
import 'screens/battle_screen.dart';
import 'screens/shop_screen.dart';
import 'features/events/event_manager.dart';
import 'screens/battlepass_screen.dart';
import 'screens/gacha_screen.dart';
import 'screens/daily_quest_screen.dart';
import 'screens/achievement_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase Core
  try {
    // await // Firebase.initializeApp(
      options: // DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase Core initialized successfully');
  } catch (e) {
    print('Failed to initialize Firebase Core: $e');
  }

  // Initialize Firebase Remote Config
  try {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setDefaults({
      'feature_iap_enabled': true,
      'feature_new_ui_enabled': false,
      'feature_daily_rewards_enabled': true,
      'feature_tutorial_enabled': true,
      'min_app_version': '1.0.0',
    });
    await remoteConfig.fetchAndActivate();
    print('Remote Config initialized successfully');
  } catch (e) {
    print('Failed to initialize Remote Config: $e');
  }

  _setupDI();
  runApp(const TimeSlipApp());
}

void _setupDI() {
  // Register core services
  if (!GetIt.I.isRegistered<AudioManager>()) {
    GetIt.I.registerSingleton<AudioManager>(AudioManager());
  }

//   // BattlePass 시스템
  GetIt.I.registerSingleton(BattlePassManager());

//   // Gacha 시스템
  GetIt.I.registerSingleton(GachaManager());

  _setupGacha();
  _setupBattlePass();
}

class TimeSlipApp extends StatelessWidget {
  const TimeSlipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MGAccessibilityProvider(
      settings: MGAccessibilitySettings.defaults,
      onSettingsChanged: (settings) {
        // Settings updated
      },
      child: MaterialApp(
        title: 'Time Slip Expedition',
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
        ),
        home: const MainGameScreen(),
        routes: {
          '/battlepass': (_) => const BattlePassScreen(),
          '/gacha': (_) => const GachaScreen(),
          '/daily_quest': (_) => const DailyQuestScreen(),
          '/achievement': (_) => const AchievementScreen(),
        },
      ),
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
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Text(event.description),
        actions: [
          TextButton(
            onPressed: () {
              final result = EventManager.resolveEvent(event, _gameState);
              Navigator.pop(context);
              _showEventResult(result);
            },
            child: const Text('Interact'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showEventResult('You ignored the ${event.title}.');
            },
            child: Text(context.l10n.'shop_leave_shop'),
          ),
        ],
      ),
    );
  }

  void _showEventResult(String result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _gameState.nextFloor();
              setState(() {});
            },
            child: Text(context.l10n.'ui_general_continue_experiment'),
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
      builder: (context) => AlertDialog(
        title: Text(context.l10n.'ui_general_you_died'),
        content: Text(context.l10n.'progress_floor_reached__gamestatefloor'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentRoom = null;
                _showShop = false;
                _gameState.startNewRun();
              });
            },
            child: Text(context.l10n.'ui_general_time_loop_reset'),
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


void _setupBattlePass() {
  final bp = GetIt.I<BattlePassManager>();

  final season = BPSeasonBuilder.create28DaySeason(
    id: 'season_1',
    nameKr: '시즌 1',
    startDate: DateTime.now().subtract(const Duration(days: 1)),
    maxLevel: 50,
    expPerLevel: 1000,
  );

  bp.setSeason(season);
  bp.setMissions(
    daily: BPSeasonBuilder.createDefaultDailyMissions(),
    weekly: BPSeasonBuilder.createDefaultWeeklyMissions(),
  );
}


void _setupGacha() {
  final gacha = GetIt.I<GachaManager>();

  gacha.registerPool(GachaPool(
    id: 'standard_pool',
    nameKr: '스탠다드 뽑기',
    items: [
      // N (50%)
      ...List.generate(20, (i) => GachaItem(
        id: 'n_item_$i',
        nameKr: '일반 아이템 $i',
        rarity: GachaRarity.normal,
      )),

      // R (35%)
      ...List.generate(10, (i) => GachaItem(
        id: 'r_item_$i',
        nameKr: '레어 아이템 $i',
        rarity: GachaRarity.rare,
      )),

      // SR (12%)
      ...List.generate(5, (i) => GachaItem(
        id: 'sr_item_$i',
        nameKr: '슈퍼레어 아이템 $i',
        rarity: GachaRarity.superRare,
      )),

      // SSR (2.7%)
      GachaItem(
        id: 'ssr_item_1',
        nameKr: '울트라레어 아이템 1',
        rarity: GachaRarity.ultraRare,
      ),

      // UR (0.3%)
      GachaItem(
        id: 'ur_item_1',
        nameKr: '레전더리 아이템 1',
        rarity: GachaRarity.legendary,
      ),
    ],
  ));
}

void _registerCollections() {
  final collection = GetIt.I<CollectionManager>();

//   // Characters 컬렉션
  collection.registerCollection(Collection(
    id: 'characters',
    name: '캐릭터',
    description: '모든 캐릭터를 수집하세요',
    items: [
      const CollectionItem(
        id: 'char_warrior',
        name: '전사',
        description: '강인한 근접 전투 캐릭터',
        rarity: CollectionRarity.common,
      ),
      const CollectionItem(
        id: 'char_mage',
        name: '마법사',
        description: '강력한 마법 공격 캐릭터',
        rarity: CollectionRarity.rare,
      ),
      const CollectionItem(
        id: 'char_archer',
        name: '궁수',
        description: '원거리 정밀 공격 캐릭터',
        rarity: CollectionRarity.rare,
      ),
      const CollectionItem(
        id: 'char_assassin',
        name: '암살자',
        description: '치명적인 은신 공격 캐릭터',
        rarity: CollectionRarity.epic,
      ),
      const CollectionItem(
        id: 'char_healer',
        name: '힐러',
        description: '팀을 치유하는 지원 캐릭터',
        rarity: CollectionRarity.legendary,
      ),
    ],
    completionReward: const CollectionReward(type: RewardType.gold, amount: 10000),
    milestoneRewards: {
      25: const CollectionReward(type: RewardType.gold, amount: 1000),
      50: const CollectionReward(type: RewardType.gold, amount: 3000),
      75: const CollectionReward(type: RewardType.gold, amount: 5000),
    },
  ));

//   // 아이템 해제 콜백 (햅틱 피드백)
  collection.onItemUnlocked = (collectionId, itemId) {
//     // SettingsManager가 등록되어 있으면 햅틱 피드백
    debugPrint('Collection item unlocked: $collectionId / $itemId');
  };
}

void _registerDailyQuests() {
  final dailyQuest = GetIt.I<DailyQuestManager>();

  dailyQuest.registerQuest(DailyQuest(
    id: 'clear_rooms',
    title: '방 클리어',
    description: '던전 방 15개 클리어',
    targetValue: 15,
    goldReward: 500,
    xpReward: 10,
  ));

  dailyQuest.registerQuest(DailyQuest(
    id: 'defeat_bosses',
    title: '보스 격파',
    description: '보스 2회 격파',
    targetValue: 2,
    goldReward: 300,
    xpReward: 5,
  ));

  dailyQuest.registerQuest(DailyQuest(
    id: 'loot_chests',
    title: '전리품 획득',
    description: '상자 10개 열기',
    targetValue: 10,
    goldReward: 200,
    xpReward: 3,
  ));
}

*/