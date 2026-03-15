import 'package:mg_common_game/core/assets/asset_types.dart';

/// Spine 통합 플래그. `--dart-define=SPINE_ENABLED=true`로 활성화.
const kSpineEnabled = bool.fromEnvironment(
  'SPINE_ENABLED',
  defaultValue: false,
);

// ── Explorer ─────────────────────────────────────────────────

const kExplorerMeta = SpineAssetMeta(
  key: 'explorer',
  path: 'spine/characters/explorer',
  atlasPath: 'assets/spine/characters/explorer/explorer.atlas',
  skeletonPath: 'assets/spine/characters/explorer/explorer.json',
  animations: ['idle', 'walk', 'attack', 'hit'],
  defaultAnimation: 'idle',
  defaultMix: 0.2,
);

// ── Time Guardian ────────────────────────────────────────────

const kTimeGuardianMeta = SpineAssetMeta(
  key: 'time_guardian',
  path: 'spine/characters/time_guardian',
  atlasPath:
      'assets/spine/characters/time_guardian/time_guardian.atlas',
  skeletonPath:
      'assets/spine/characters/time_guardian/time_guardian.json',
  animations: ['idle', 'walk', 'attack', 'hit'],
  defaultAnimation: 'idle',
  defaultMix: 0.2,
);

// ── Chrono Scout ─────────────────────────────────────────────

const kChronoScoutMeta = SpineAssetMeta(
  key: 'chrono_scout',
  path: 'spine/characters/chrono_scout',
  atlasPath:
      'assets/spine/characters/chrono_scout/chrono_scout.atlas',
  skeletonPath:
      'assets/spine/characters/chrono_scout/chrono_scout.json',
  animations: ['idle', 'walk', 'attack', 'hit'],
  defaultAnimation: 'idle',
  defaultMix: 0.2,
);
