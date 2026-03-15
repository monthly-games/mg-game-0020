import 'package:mg_common_game/systems/tutorial/tutorial.dart';

/// Tutorial configuration for MG-0020: Time Slip Expedition (Adventure).
///
/// Placeholder tutorial steps for v1.2.0 pilot integration.
/// In production, replace descriptions with localized strings
/// and add targetSelector for highlight positioning.
const kOnboardingTutorial = TutorialConfig(
  id: 'onboarding',
  name: 'Time Slip Tutorial',
  steps: [
    TutorialStep(
      id: 'welcome',
      title: 'Welcome, Time Traveler!',
      description: 'Navigate through dungeon floors across different eras.',
      actionHint: 'Tap to continue',
    ),
    TutorialStep(
      id: 'explore_dungeon',
      title: 'Explore the Dungeon',
      description:
          'Choose a room to enter. Each room has different encounters.',
      actionHint: 'Tap a room',
      targetSelector: 'dungeon_map',
    ),
    TutorialStep(
      id: 'first_battle',
      title: 'Battle Enemies',
      description:
          'Defeat enemies to earn loot and advance deeper '
          'into the dungeon.',
      actionHint: 'Tap attack',
      targetSelector: 'battle_area',
    ),
    TutorialStep(
      id: 'visit_shop',
      title: 'Visit the Shop',
      description: 'Spend gold at the shop to buy powerful items.',
      actionHint: 'Tap to continue',
    ),
  ],
  skippable: true,
  showOnFirstLaunch: true,
  trigger: TutorialTrigger.firstLaunch,
);
