import 'package:flutter/material.dart';

class HobbyItem extends StatelessWidget {
  final String hobby;
  final int index;

  const HobbyItem({super.key, required this.hobby, required this.index});

  IconData _getHobbyIcon(String hobby) {
    final lowerHobby = hobby.toLowerCase();

    if (lowerHobby.contains('baca') || lowerHobby.contains('book')) {
      return Icons.menu_book;
    } else if (lowerHobby.contains('musik') || lowerHobby.contains('music')) {
      return Icons.music_note;
    } else if (lowerHobby.contains('game') || lowerHobby.contains('gaming')) {
      return Icons.videogame_asset;
    } else if (lowerHobby.contains('olahraga') ||
        lowerHobby.contains('sport')) {
      return Icons.sports_soccer;
    } else if (lowerHobby.contains('coding') ||
        lowerHobby.contains('program')) {
      return Icons.code;
    } else if (lowerHobby.contains('travel') || lowerHobby.contains('jalan')) {
      return Icons.flight_takeoff;
    } else if (lowerHobby.contains('foto') || lowerHobby.contains('photo')) {
      return Icons.camera_alt;
    }

    return Icons.favorite;
  }

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    final color = colors[index % colors.length];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 26), // 10% opacity
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 77), // 30% opacity
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getHobbyIcon(hobby), color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            hobby,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
