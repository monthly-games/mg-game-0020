import 'dart:math';

enum EnemyType { rat, goblin, skeleton, golem, timeWraith, bossGuardian }

class EnemyData {
  final String id;
  final String name;
  final EnemyType type;
  final int hp;
  final int maxHp;
  final int damage;
  final int expReward;
  final int minFloor;

  const EnemyData({
    required this.id,
    required this.name,
    required this.type,
    required this.hp,
    required this.maxHp,
    required this.damage,
    required this.expReward,
    required this.minFloor,
  });
}

class EnemyFactory {
  static final Random _rng = Random();

  static const List<EnemyData> _blueprints = [
    EnemyData(
      id: 'rat',
      name: 'Sewer Rat',
      type: EnemyType.rat,
      hp: 20,
      maxHp: 20,
      damage: 3,
      expReward: 5,
      minFloor: 1,
    ),
    EnemyData(
      id: 'goblin',
      name: 'Goblin Scavenger',
      type: EnemyType.goblin,
      hp: 35,
      maxHp: 35,
      damage: 6,
      expReward: 10,
      minFloor: 2,
    ),
    EnemyData(
      id: 'skeleton',
      name: 'Rusted Skeleton',
      type: EnemyType.skeleton,
      hp: 50,
      maxHp: 50,
      damage: 9,
      expReward: 15,
      minFloor: 4,
    ),
    EnemyData(
      id: 'golem',
      name: 'Stone Golem',
      type: EnemyType.golem,
      hp: 120,
      maxHp: 120,
      damage: 15,
      expReward: 30,
      minFloor: 7,
    ),
    EnemyData(
      id: 'wraith',
      name: 'Time Wraith',
      type: EnemyType.timeWraith,
      hp: 80,
      maxHp: 80,
      damage: 20,
      expReward: 50,
      minFloor: 11,
    ),
  ];

  static const EnemyData _bossBlueprint = EnemyData(
    id: 'boss_guardian',
    name: 'Chronos Guardian',
    type: EnemyType.bossGuardian,
    hp: 500,
    maxHp: 500,
    damage: 25,
    expReward: 500,
    minFloor: 10,
  );

  static EnemyData generateEnemy(int floor) {
    if (floor % 10 == 0) return _bossBlueprint;

    // Filter by floor
    final pool = _blueprints.where((e) => e.minFloor <= floor).toList();
    if (pool.isEmpty) return _blueprints.first;

    // Pick tailored to floor (simple weight: allow anything unlocked)
    final blueprint = pool[_rng.nextInt(pool.length)];

    // Scale stats slightly by floor
    // Base 1.0, +15% per floor after the first
    final scale = 1.0 + ((floor - 1) * 0.15);

    return EnemyData(
      id: blueprint.id,
      name: blueprint.name,
      type: blueprint.type,
      hp: (blueprint.hp * scale).round(),
      maxHp: (blueprint.maxHp * scale).round(),
      damage: (blueprint.damage * scale).round(),
      expReward: (blueprint.expReward * scale).round(), // Scale EXP too
      minFloor: blueprint.minFloor,
    );
  }
}
