class GameLevelDesign {
  const GameLevelDesign({
    required this.levelIndex,
    required this.stage,
    required this.wave,
    required this.difficulty,
    required this.objective,
    required this.goldReward,
    required this.xpReward,
    required this.progressionUnlock,
  });

  final int levelIndex;
  final String stage;
  final int wave;
  final double difficulty;
  final String objective;
  final int goldReward;
  final int xpReward;
  final String progressionUnlock;
}

const kGameTitle = 'Time Slip Explorers';
const kCoreFunLoop = 'Explore Time and Restore Eras';

const kCoreLoopPillars = <String>[
  'Start',
  'Act',
  'React',
  'Reward',
  'Upgrade',
  'Return',
];

const kLevelTensionBeats = <String>[
  'time_onboarding',
  'ancient_choice',
  'medieval_combo',
  'renaissance_pressure',
  'industrial_twist',
  'modern_gate',
  'future_remix',
  'sci_fi_loop',
  'past_echo',
  'era_crossroads',
  'prehistoric_storm',
  'ancient_observatory',
  'medieval_siege',
  'renaissance_lab',
  'industrial_reactor',
  'modern_paradox',
  'future_citadel',
  'sci_fi_rift',
  'past_rescue',
  'era_anchor',
  'prehistoric_apex',
  'ancient_crown',
  'medieval_eclipse',
  'renaissance_spiral',
  'industrial_singularity',
  'modern_collapse',
  'future_origin',
  'chrono_finale',
];

const kDefaultBalancingConfig = <String, Object>{
  'difficultyCurve': 'twenty_eight_era_arc',
  'targetSessionSeconds': 180,
  'rewardCadence': 'every_level_with_boss_bonus',
  'progressionReset': 'repeatable_loop',
  'failureRecovery': 'keep_progress_retry_level',
};

const kMetaProgressionSystems = <String>[
  'DailyQuest',
  'Achievement',
  'BattlePass',
  'Gacha',
  'Collection',
  'Progression',
];

const kLevelDesign = <GameLevelDesign>[
  GameLevelDesign(
    levelIndex: 1,
    stage: 'Time Slip: Prehistoric Camp',
    wave: 1,
    difficulty: 1.00,
    objective: 'Stabilize the timeline: Learn the first era action',
    goldReward: 50,
    xpReward: 20,
    progressionUnlock: 'tutorial complete',
  ),
  GameLevelDesign(
    levelIndex: 2,
    stage: 'Time Slip: Ancient Archive',
    wave: 2,
    difficulty: 1.15,
    objective: 'Stabilize the timeline: Recover the first chronicle shard',
    goldReward: 80,
    xpReward: 35,
    progressionUnlock: 'daily quest',
  ),
  GameLevelDesign(
    levelIndex: 3,
    stage: 'Time Slip: Medieval Gate',
    wave: 3,
    difficulty: 1.35,
    objective: 'Stabilize the timeline: Chain relic scans across two eras',
    goldReward: 120,
    xpReward: 54,
    progressionUnlock: 'upgrade option',
  ),
  GameLevelDesign(
    levelIndex: 4,
    stage: 'Time Slip: Renaissance Workshop',
    wave: 4,
    difficulty: 1.65,
    objective:
        'Stabilize the timeline: Repair the workshop before the rift spikes',
    goldReward: 170,
    xpReward: 78,
    progressionUnlock: 'booster',
  ),
  GameLevelDesign(
    levelIndex: 5,
    stage: 'Time Slip: Industrial Signal',
    wave: 5,
    difficulty: 1.95,
    objective: 'Stabilize the timeline: Tune the signal while anomalies stack',
    goldReward: 235,
    xpReward: 108,
    progressionUnlock: 'collection slot',
  ),
  GameLevelDesign(
    levelIndex: 6,
    stage: 'Time Slip: Modern Metro',
    wave: 6,
    difficulty: 2.30,
    objective: 'Stabilize the timeline: Route commuters around a paradox surge',
    goldReward: 315,
    xpReward: 144,
    progressionUnlock: 'rank promotion',
  ),
  GameLevelDesign(
    levelIndex: 7,
    stage: 'Time Slip: Future Dock',
    wave: 7,
    difficulty: 2.70,
    objective:
        'Stabilize the timeline: Dock the explorer ship under higher pressure',
    goldReward: 410,
    xpReward: 188,
    progressionUnlock: 'tournament ticket',
  ),
  GameLevelDesign(
    levelIndex: 8,
    stage: 'Time Slip: Sci-fi Nexus',
    wave: 8,
    difficulty: 3.15,
    objective: 'Stabilize the timeline: Loop back for a harder era route',
    goldReward: 525,
    xpReward: 240,
    progressionUnlock: 'season score',
  ),
  GameLevelDesign(
    levelIndex: 9,
    stage: 'Time Slip: Past Echo',
    wave: 9,
    difficulty: 3.55,
    objective:
        'Stabilize the timeline: Match echoes before they overwrite the map',
    goldReward: 650,
    xpReward: 300,
    progressionUnlock: 'echo scanner',
  ),
  GameLevelDesign(
    levelIndex: 10,
    stage: 'Time Slip: Era Crossroads',
    wave: 10,
    difficulty: 4.00,
    objective:
        'Stabilize the timeline: Choose a safe branch through split eras',
    goldReward: 790,
    xpReward: 368,
    progressionUnlock: 'branch compass',
  ),
  GameLevelDesign(
    levelIndex: 11,
    stage: 'Time Slip: Prehistoric Storm',
    wave: 11,
    difficulty: 4.50,
    objective:
        'Stabilize the timeline: Shield the camp from temporal lightning',
    goldReward: 950,
    xpReward: 444,
    progressionUnlock: 'storm anchor',
  ),
  GameLevelDesign(
    levelIndex: 12,
    stage: 'Time Slip: Ancient Observatory',
    wave: 12,
    difficulty: 5.05,
    objective:
        'Stabilize the timeline: Align the observatory to locate a fracture',
    goldReward: 1130,
    xpReward: 528,
    progressionUnlock: 'star dial',
  ),
  GameLevelDesign(
    levelIndex: 13,
    stage: 'Time Slip: Medieval Siege',
    wave: 13,
    difficulty: 5.65,
    objective:
        'Stabilize the timeline: Hold the gate while the era recalibrates',
    goldReward: 1330,
    xpReward: 620,
    progressionUnlock: 'siege ward',
  ),
  GameLevelDesign(
    levelIndex: 14,
    stage: 'Time Slip: Renaissance Lab',
    wave: 14,
    difficulty: 6.30,
    objective:
        'Stabilize the timeline: Combine inventions into a repair catalyst',
    goldReward: 1550,
    xpReward: 720,
    progressionUnlock: 'lab catalyst',
  ),
  GameLevelDesign(
    levelIndex: 15,
    stage: 'Time Slip: Industrial Reactor',
    wave: 15,
    difficulty: 7.00,
    objective: 'Stabilize the timeline: Vent the reactor before pressure peaks',
    goldReward: 1795,
    xpReward: 828,
    progressionUnlock: 'reactor vent',
  ),
  GameLevelDesign(
    levelIndex: 16,
    stage: 'Time Slip: Modern Paradox',
    wave: 16,
    difficulty: 7.75,
    objective:
        'Stabilize the timeline: Resolve duplicate routes across the city grid',
    goldReward: 2065,
    xpReward: 944,
    progressionUnlock: 'paradox resolver',
  ),
  GameLevelDesign(
    levelIndex: 17,
    stage: 'Time Slip: Future Citadel',
    wave: 17,
    difficulty: 8.55,
    objective:
        'Stabilize the timeline: Secure the citadel core from time raiders',
    goldReward: 2360,
    xpReward: 1068,
    progressionUnlock: 'citadel core',
  ),
  GameLevelDesign(
    levelIndex: 18,
    stage: 'Time Slip: Sci-fi Rift',
    wave: 18,
    difficulty: 9.40,
    objective:
        'Stabilize the timeline: Seal a rift with synchronized crew actions',
    goldReward: 2680,
    xpReward: 1200,
    progressionUnlock: 'rift seal',
  ),
  GameLevelDesign(
    levelIndex: 19,
    stage: 'Time Slip: Past Rescue',
    wave: 19,
    difficulty: 10.30,
    objective:
        'Stabilize the timeline: Rescue stranded explorers without changing history',
    goldReward: 3025,
    xpReward: 1340,
    progressionUnlock: 'rescue beacon',
  ),
  GameLevelDesign(
    levelIndex: 20,
    stage: 'Time Slip: Era Anchor',
    wave: 20,
    difficulty: 11.25,
    objective: 'Stabilize the timeline: Anchor every active era to the hub',
    goldReward: 3395,
    xpReward: 1488,
    progressionUnlock: 'era anchor',
  ),
  GameLevelDesign(
    levelIndex: 21,
    stage: 'Time Slip: Prehistoric Apex',
    wave: 21,
    difficulty: 12.25,
    objective:
        'Stabilize the timeline: Survive the apex anomaly and bank rare fossils',
    goldReward: 3790,
    xpReward: 1644,
    progressionUnlock: 'apex fossil',
  ),
  GameLevelDesign(
    levelIndex: 22,
    stage: 'Time Slip: Ancient Crown',
    wave: 22,
    difficulty: 13.30,
    objective: 'Stabilize the timeline: Return the crown to its correct ruler',
    goldReward: 4210,
    xpReward: 1808,
    progressionUnlock: 'crown record',
  ),
  GameLevelDesign(
    levelIndex: 23,
    stage: 'Time Slip: Medieval Eclipse',
    wave: 23,
    difficulty: 14.40,
    objective:
        'Stabilize the timeline: Navigate the eclipse while enemies surge',
    goldReward: 4655,
    xpReward: 1980,
    progressionUnlock: 'eclipse chart',
  ),
  GameLevelDesign(
    levelIndex: 24,
    stage: 'Time Slip: Renaissance Spiral',
    wave: 24,
    difficulty: 15.55,
    objective: 'Stabilize the timeline: Decode a spiral of invention loops',
    goldReward: 5125,
    xpReward: 2160,
    progressionUnlock: 'spiral theorem',
  ),
  GameLevelDesign(
    levelIndex: 25,
    stage: 'Time Slip: Industrial Singularity',
    wave: 25,
    difficulty: 16.75,
    objective:
        'Stabilize the timeline: Decouple machines from a singularity pulse',
    goldReward: 5620,
    xpReward: 2348,
    progressionUnlock: 'singularity clamp',
  ),
  GameLevelDesign(
    levelIndex: 26,
    stage: 'Time Slip: Modern Collapse',
    wave: 26,
    difficulty: 18.00,
    objective:
        'Stabilize the timeline: Evacuate collapsing branches into one route',
    goldReward: 6140,
    xpReward: 2544,
    progressionUnlock: 'collapse map',
  ),
  GameLevelDesign(
    levelIndex: 27,
    stage: 'Time Slip: Future Origin',
    wave: 27,
    difficulty: 19.30,
    objective:
        'Stabilize the timeline: Discover the origin point of the anomaly',
    goldReward: 6685,
    xpReward: 2748,
    progressionUnlock: 'origin key',
  ),
  GameLevelDesign(
    levelIndex: 28,
    stage: 'Time Slip: Chrono Finale',
    wave: 28,
    difficulty: 20.65,
    objective: 'Stabilize the timeline: Close the loop and restore every era',
    goldReward: 7255,
    xpReward: 2960,
    progressionUnlock: 'chrono finale',
  ),
];
