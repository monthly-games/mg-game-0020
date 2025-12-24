import 'package:flutter/material.dart';
import '../../core/game_state.dart';
import '../features/dungeon/dungeon_manager.dart';
import '../features/dungeon/room.dart';

class DungeonScreen extends StatefulWidget {
  final GameState gameState;
  final Function(Room) onRoomSelected;

  const DungeonScreen({
    super.key,
    required this.gameState,
    required this.onRoomSelected,
  });

  @override
  State<DungeonScreen> createState() => _DungeonScreenState();
}

class _DungeonScreenState extends State<DungeonScreen> {
  late DungeonManager _dungeonManager;
  List<Room> _nextRooms = [];

  @override
  void initState() {
    super.initState();
    _dungeonManager = DungeonManager();
    _generateOptions();
  }

  // Refresh options when returning to this screen (or initial load)
  // In a real flow, this state might be held in a Manager, but for prototype,
  // we generate new rooms if we are "between" rooms.
  void _generateOptions() {
    _nextRooms = _dungeonManager.generateNextRooms(widget.gameState.floor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Floor ${widget.gameState.floor}'),
        backgroundColor: Colors.black,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'HP: ${widget.gameState.currentHp}/${widget.gameState.maxHp}',
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose your path...',
              style: TextStyle(color: Colors.white70, fontSize: 24),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: _nextRooms.map((room) => _buildRoomCard(room)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(Room room) {
    IconData icon;
    Color color;

    switch (room.type) {
      case RoomType.battle:
        icon = Icons.android; // Monster placeholder
        color = Colors.redAccent;
        break;
      case RoomType.event:
        icon = Icons.help_outline;
        color = Colors.blueAccent;
        break;
      case RoomType.shop:
        icon = Icons.shopping_bag;
        color = Colors.amber;
        break;
      case RoomType.boss:
        icon = Icons.warning;
        color = Colors.deepPurple;
        break;
    }

    return GestureDetector(
      onTap: () => widget.onRoomSelected(room),
      child: Container(
        width: 150,
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              room.name,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              room.description,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
