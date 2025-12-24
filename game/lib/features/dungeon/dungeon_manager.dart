import 'dart:math';
import 'room.dart';

class DungeonManager {
  final Random _rng = Random();

  /// Generate possible next rooms based on current floor
  List<Room> generateNextRooms(int floor) {
    // Logic:
    // Floor 1-9: Random 2-3 choices (Battle, Event, Shop)
    // Floor 10: Boss

    if (floor % 10 == 0) {
      return [
        Room(
          id: 'boss_$floor',
          type: RoomType.boss,
          name: 'Boss Chamber',
          description: 'A menacing presence awaits.',
        ),
      ];
    }

    final count = 2 + _rng.nextInt(2); // 2 or 3 rooms
    final List<Room> rooms = [];

    for (int i = 0; i < count; i++) {
      rooms.add(_generateRandomRoom(floor));
    }

    return rooms;
  }

  Room _generateRandomRoom(int floor) {
    final roll = _rng.nextDouble();
    if (roll < 0.6) {
      return Room(
        id: 'battle_${floor}_${_rng.nextInt(1000)}',
        type: RoomType.battle,
        name: 'Monster Nest',
        description: 'You hear growling sounds.',
      );
    } else if (roll < 0.8) {
      return Room(
        id: 'event_${floor}_${_rng.nextInt(1000)}',
        type: RoomType.event,
        name: 'Mysterious Altar',
        description: 'An ancient structure stands here.',
      );
    } else {
      return Room(
        id: 'shop_${floor}_${_rng.nextInt(1000)}',
        type: RoomType.shop,
        name: 'Merchant',
        description: 'Someone wants to trade.',
      );
    }
  }
}
