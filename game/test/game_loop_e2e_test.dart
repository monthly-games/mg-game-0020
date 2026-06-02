import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:game/game/level_design_config.dart';
import 'package:game/game/wave_spawn_table.dart';
import 'package:game/game/tutorial_config.dart';

/// E2E Test for MG-0020: Time Slip Explorers (JRPG Series #5)
///
/// Tests the game loop with focus on:
/// - Time travel mechanics
/// - Era exploration
/// - Historical progression
/// - Time manipulation elements
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('MG-0020 Time Slip Explorers - Game Loop E2E', () {
    Future<void> tapCompleteAction(WidgetTester tester) async {
      final action = find.byKey(const ValueKey('complete-action'));
      await tester.ensureVisible(action);
      await tester.pumpAndSettle();
      await tester.tap(action);
      await tester.pumpAndSettle();
    }

    testWidgets('Complete time slip progression', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify main menu elements
      expect(find.text('MG-0020'), findsOneWidget);
      expect(find.text('Time Slip Explorers'), findsOneWidget);
      expect(find.text('Core Fun: $kCoreFunLoop'), findsOneWidget);

      // Navigate to tutorial
      await tester.tap(find.text('Tutorial'));
      await tester.pumpAndSettle();

      // Complete tutorial steps
      final tutorialSteps = kOnboardingTutorial.steps;
      for (int i = 0; i < tutorialSteps.length; i++) {
        await tester.pumpAndSettle();
        expect(find.text('${i + 1}/${tutorialSteps.length}'), findsOneWidget);

        await tester.tap(
          find.text(i == tutorialSteps.length - 1 ? 'Done' : 'Next'),
        );
        await tester.pumpAndSettle();
      }

      // Navigate to game screen
      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();

      // Test time slip progression
      int erasExplored = 0;
      int totalGold = 0;
      int totalXP = 0;

      for (int i = 0; i < 8 && i < kLevelDesign.length; i++) {
        await tester.pumpAndSettle();

        final levelDesign = kLevelDesign[i];
        final spawn = kWaveSpawnTable[i];

        expect(
          find.text('Level ${levelDesign.levelIndex} - ${levelDesign.stage}'),
          findsOneWidget,
        );

        // Complete time slip exploration
        await tapCompleteAction(tester);

        // Time progression
        erasExplored++;
        totalGold += levelDesign.goldReward;
        totalXP += levelDesign.xpReward;

        expect(find.text('$totalGold gold / $totalXP xp'), findsOneWidget);
      }

      // Verify time slip progression
      expect(erasExplored, greaterThan(0), reason: 'Should explore eras');
      expect(
        totalGold,
        greaterThan(0),
        reason: 'Time slip should provide rewards',
      );
      expect(totalXP, greaterThan(0), reason: 'Should gain XP');
    });

    testWidgets('Test time travel variety and eras', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();

      // Time slip should have different eras
      for (int i = 0; i < 10 && i < kLevelDesign.length; i++) {
        final level = kLevelDesign[i];

        // Time travel themes
        expect(
          level.stage.toLowerCase(),
          anyOf([
            contains('time'),
            contains('era'),
            contains('past'),
            contains('future'),
            contains('ancient'),
            contains('medieval'),
            contains('modern'),
            contains('prehistoric'),
            contains('sci-fi'),
          ]),
          reason: 'Levels should have time travel themes',
        );

        await tapCompleteAction(tester);
      }
    });

    testWidgets('Verify time slip theme and visual elements', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();

      // Verify time travel visual elements
      expect(find.byIcon(Icons.videogame_asset_rounded), findsWidgets);
      expect(find.byIcon(Icons.access_time_rounded), findsWidgets);
    });

    testWidgets('Complete full time slip adventure session', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();

      int erasCompleted = 0;
      int maxEras = 28;

      for (int i = 0; i < maxEras && i < kLevelDesign.length; i++) {
        await tapCompleteAction(tester);
        erasCompleted++;
      }

      expect(
        erasCompleted,
        equals(maxEras),
        reason: 'Should complete 28 time eras',
      );

      // Verify time slip rewards
      final finalGold = kLevelDesign
          .take(maxEras)
          .map((l) => l.goldReward)
          .fold(0, (a, b) => a + b);
      final finalXP = kLevelDesign
          .take(maxEras)
          .map((l) => l.xpReward)
          .fold(0, (a, b) => a + b);

      expect(
        find.text('Reward bank: $finalGold gold / $finalXP xp'),
        findsOneWidget,
      );
    });

    testWidgets('Test time slip special features', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test daily time challenges
      await tester.tap(find.text('Daily'));
      await tester.pumpAndSettle();
      expect(find.text('Daily Quests'), findsWidgets);

      await tester.pageBack();
      await tester.pumpAndSettle();

      // Test tournament (time trials)
      await tester.tap(find.text('Tournament'));
      await tester.pumpAndSettle();
      expect(find.text('Tournament'), findsWidgets);

      await tester.pageBack();
      await tester.pumpAndSettle();

      // Test seasonal events (time anomalies)
      await tester.tap(find.text('Event'));
      await tester.pumpAndSettle();
      expect(find.text('Seasonal Event'), findsWidgets);
    });

    testWidgets('Verify time travel progression through eras', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Level Roadmap'));
      await tester.pumpAndSettle();

      // Time slip should have era progression
      for (int i = 0; i < kLevelDesign.length && i < 15; i++) {
        final level = kLevelDesign[i];
        final levelTitle = find.text(
          'Level ${level.levelIndex} - ${level.stage}',
        );
        await tester.scrollUntilVisible(
          levelTitle,
          120,
          scrollable: find.byType(Scrollable),
        );
        expect(levelTitle, findsOneWidget);

        // Time progression themes
        expect(
          level.stage.toLowerCase(),
          anyOf([
            contains('prehistoric'),
            contains('ancient'),
            contains('medieval'),
            contains('renaissance'),
            contains('industrial'),
            contains('modern'),
            contains('future'),
            contains('time slip'),
          ]),
        );
      }
    });

    testWidgets('Test time manipulation mechanics', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();

      // Test that time slip has time-based mechanics
      List<double> spawnCadences = [];

      for (int i = 0; i < 10 && i < kLevelDesign.length; i++) {
        final spawn = kWaveSpawnTable[i];
        spawnCadences.add(spawn.spawnCadenceSeconds);

        await tapCompleteAction(tester);
      }

      // Time slip should have varied timing
      final uniqueCadences = spawnCadences.toSet();
      expect(
        uniqueCadences.length,
        greaterThan(1),
        reason: 'Time slip should have varied timing',
      );
    });
  });
}
