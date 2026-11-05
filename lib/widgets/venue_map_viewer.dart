import 'package:flutter/material.dart';

class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({super.key});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: InteractiveViewer(
          minScale: 0.8,
          maxScale: 3.5,
          boundaryMargin: const EdgeInsets.all(70),
          child: Container(
            width: 650,
            height: 350,
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(color: Color(0xFFE9EEE4)),
            child: Stack(
              children: [
                Positioned(left: 30, top: 28, child: _room('Pintu Utama', const Color(0xFFCAEF63), Icons.door_front_door_outlined, 120, 54)),
                Positioned(left: 190, top: 28, child: _room('Auditorium Cendana', Colors.white, Icons.groups_2_outlined, 205, 116)),
                Positioned(left: 430, top: 28, child: _room('Studio Merapi', const Color(0xFFFFC45B), Icons.laptop_mac_outlined, 165, 116)),
                Positioned(left: 30, top: 110, child: _room('Registrasi', Colors.white, Icons.how_to_reg_outlined, 120, 70)),
                Positioned(left: 190, top: 170, child: _room('Lab Inovasi 2', const Color(0xFF8FD3C8), Icons.sensors_outlined, 205, 94)),
                Positioned(left: 430, top: 170, child: _room('Ruang Kolaborasi', Colors.white, Icons.forum_outlined, 165, 94)),
                const Positioned(left: 160, top: 143, child: Icon(Icons.arrow_forward_rounded, size: 25, color: Color(0xFF59645E))),
                const Positioned(left: 395, top: 143, child: Icon(Icons.arrow_forward_rounded, size: 25, color: Color(0xFF59645E))),
                Positioned(right: 6, bottom: 1, child: Text('DENAH • GEDUNG NUSA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1, color: Color(0xFF59645E)))),
              ],
            ),
          ),
        ),
      );

  Widget _room(String label, Color color, IconData icon, double width, double height) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.94), border: Border.all(color: const Color(0xFF7D8980), width: 1.3), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 19, color: const Color(0xFF26322E)),
            const SizedBox(width: 5),
            Flexible(child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11))),
          ],
        ),
      );
}