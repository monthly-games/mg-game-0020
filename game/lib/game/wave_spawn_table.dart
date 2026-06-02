class WaveSpawnEntry {
  const WaveSpawnEntry({
    required this.stage,
    required this.wave,
    required this.enemyCount,
    required this.spawnCadenceSeconds,
    required this.pressureBudget,
    required this.winCondition,
  });

  final String stage;
  final int wave;
  final int enemyCount;
  final double spawnCadenceSeconds;
  final int pressureBudget;
  final String winCondition;
}

const kWaveSpawnTable = <WaveSpawnEntry>[
  WaveSpawnEntry(
    stage: 'Time Slip: Prehistoric Camp',
    wave: 1,
    enemyCount: 5,
    spawnCadenceSeconds: 2.82,
    pressureBudget: 17,
    winCondition: 'Stabilize the timeline: Learn the first era action',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Ancient Archive',
    wave: 2,
    enemyCount: 7,
    spawnCadenceSeconds: 2.74,
    pressureBudget: 22,
    winCondition: 'Stabilize the timeline: Recover the first chronicle shard',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Medieval Gate',
    wave: 3,
    enemyCount: 9,
    spawnCadenceSeconds: 2.66,
    pressureBudget: 28,
    winCondition: 'Stabilize the timeline: Chain relic scans across two eras',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Renaissance Workshop',
    wave: 4,
    enemyCount: 11,
    spawnCadenceSeconds: 2.58,
    pressureBudget: 35,
    winCondition:
        'Stabilize the timeline: Repair the workshop before the rift spikes',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Industrial Signal',
    wave: 5,
    enemyCount: 13,
    spawnCadenceSeconds: 2.50,
    pressureBudget: 43,
    winCondition:
        'Stabilize the timeline: Tune the signal while anomalies stack',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Modern Metro',
    wave: 6,
    enemyCount: 15,
    spawnCadenceSeconds: 2.42,
    pressureBudget: 52,
    winCondition:
        'Stabilize the timeline: Route commuters around a paradox surge',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Future Dock',
    wave: 7,
    enemyCount: 17,
    spawnCadenceSeconds: 2.34,
    pressureBudget: 62,
    winCondition:
        'Stabilize the timeline: Dock the explorer ship under higher pressure',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Sci-fi Nexus',
    wave: 8,
    enemyCount: 19,
    spawnCadenceSeconds: 2.26,
    pressureBudget: 73,
    winCondition: 'Stabilize the timeline: Loop back for a harder era route',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Past Echo',
    wave: 9,
    enemyCount: 21,
    spawnCadenceSeconds: 2.18,
    pressureBudget: 85,
    winCondition:
        'Stabilize the timeline: Match echoes before they overwrite the map',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Era Crossroads',
    wave: 10,
    enemyCount: 23,
    spawnCadenceSeconds: 2.10,
    pressureBudget: 98,
    winCondition:
        'Stabilize the timeline: Choose a safe branch through split eras',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Prehistoric Storm',
    wave: 11,
    enemyCount: 25,
    spawnCadenceSeconds: 2.02,
    pressureBudget: 112,
    winCondition:
        'Stabilize the timeline: Shield the camp from temporal lightning',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Ancient Observatory',
    wave: 12,
    enemyCount: 27,
    spawnCadenceSeconds: 1.94,
    pressureBudget: 127,
    winCondition:
        'Stabilize the timeline: Align the observatory to locate a fracture',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Medieval Siege',
    wave: 13,
    enemyCount: 29,
    spawnCadenceSeconds: 1.86,
    pressureBudget: 143,
    winCondition:
        'Stabilize the timeline: Hold the gate while the era recalibrates',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Renaissance Lab',
    wave: 14,
    enemyCount: 31,
    spawnCadenceSeconds: 1.78,
    pressureBudget: 160,
    winCondition:
        'Stabilize the timeline: Combine inventions into a repair catalyst',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Industrial Reactor',
    wave: 15,
    enemyCount: 33,
    spawnCadenceSeconds: 1.70,
    pressureBudget: 178,
    winCondition:
        'Stabilize the timeline: Vent the reactor before pressure peaks',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Modern Paradox',
    wave: 16,
    enemyCount: 35,
    spawnCadenceSeconds: 1.62,
    pressureBudget: 197,
    winCondition:
        'Stabilize the timeline: Resolve duplicate routes across the city grid',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Future Citadel',
    wave: 17,
    enemyCount: 37,
    spawnCadenceSeconds: 1.54,
    pressureBudget: 217,
    winCondition:
        'Stabilize the timeline: Secure the citadel core from time raiders',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Sci-fi Rift',
    wave: 18,
    enemyCount: 39,
    spawnCadenceSeconds: 1.46,
    pressureBudget: 238,
    winCondition:
        'Stabilize the timeline: Seal a rift with synchronized crew actions',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Past Rescue',
    wave: 19,
    enemyCount: 41,
    spawnCadenceSeconds: 1.38,
    pressureBudget: 260,
    winCondition:
        'Stabilize the timeline: Rescue stranded explorers without changing history',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Era Anchor',
    wave: 20,
    enemyCount: 43,
    spawnCadenceSeconds: 1.30,
    pressureBudget: 283,
    winCondition: 'Stabilize the timeline: Anchor every active era to the hub',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Prehistoric Apex',
    wave: 21,
    enemyCount: 45,
    spawnCadenceSeconds: 1.22,
    pressureBudget: 307,
    winCondition:
        'Stabilize the timeline: Survive the apex anomaly and bank rare fossils',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Ancient Crown',
    wave: 22,
    enemyCount: 47,
    spawnCadenceSeconds: 1.14,
    pressureBudget: 332,
    winCondition:
        'Stabilize the timeline: Return the crown to its correct ruler',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Medieval Eclipse',
    wave: 23,
    enemyCount: 49,
    spawnCadenceSeconds: 1.06,
    pressureBudget: 358,
    winCondition:
        'Stabilize the timeline: Navigate the eclipse while enemies surge',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Renaissance Spiral',
    wave: 24,
    enemyCount: 51,
    spawnCadenceSeconds: 0.98,
    pressureBudget: 385,
    winCondition: 'Stabilize the timeline: Decode a spiral of invention loops',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Industrial Singularity',
    wave: 25,
    enemyCount: 53,
    spawnCadenceSeconds: 0.90,
    pressureBudget: 413,
    winCondition:
        'Stabilize the timeline: Decouple machines from a singularity pulse',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Modern Collapse',
    wave: 26,
    enemyCount: 55,
    spawnCadenceSeconds: 0.82,
    pressureBudget: 442,
    winCondition:
        'Stabilize the timeline: Evacuate collapsing branches into one route',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Future Origin',
    wave: 27,
    enemyCount: 57,
    spawnCadenceSeconds: 0.74,
    pressureBudget: 472,
    winCondition:
        'Stabilize the timeline: Discover the origin point of the anomaly',
  ),
  WaveSpawnEntry(
    stage: 'Time Slip: Chrono Finale',
    wave: 28,
    enemyCount: 59,
    spawnCadenceSeconds: 0.66,
    pressureBudget: 503,
    winCondition:
        'Stabilize the timeline: Close the loop and restore every era',
  ),
];
