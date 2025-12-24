enum RoomType { battle, event, shop, boss }

class Room {
  final String id;
  final RoomType type;
  final String name;
  final String description;
  final List<Room>? nextRooms; // Branching paths

  Room({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    this.nextRooms,
  });
}
