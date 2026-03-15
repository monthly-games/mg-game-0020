import 'package:mg_common_game/systems/balancing/balancing.dart';

/// Default balancing configuration for MG-0020: Time Slip Expedition.
///
/// Placeholder values for v1.2.0 pilot integration.
/// In production, override via RemoteConfig using
/// [BalancingManager.loadFromRemote].
const kDefaultBalancingConfig = BalancingConfig(
  gameId: 'mg-0020',
  version: 1,
  currencies: [
    CurrencyConfig(
      id: 'gold',
      baseEarnRate: 12.0,
      earnGrowthFactor: 1.15,
      spendGrowthFactor: 1.2,
    ),
  ],
  xpCurve: XpCurveConfig(baseXp: 100, maxLevel: 100),
  difficultyScaling: DifficultyScalingConfig(
    curveType: CurveType.exponential,
    scalingFactor: 0.12,
    maxDifficulty: 15.0,
  ),
  customParams: {
    'reward_multiplier': 1.0,
    'floor_scaling': 1.0,
    'loot_bonus_base': 1.0,
  },
);
