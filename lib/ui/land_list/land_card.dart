import 'package:flutter/material.dart';

import '../../domain/models/land_model.dart';
import '../core/ui_helpers.dart';

class LandCard extends StatelessWidget {
  const LandCard({required this.land, super.key});

  final LandModel land;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  land.nomorBidang,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF12304A),
                  ),
                ),
              ),
              StatusPill(land.statusDokumen),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            land.namaPemilik,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _LandDetail(icon: Icons.location_on_outlined, text: land.lokasi),
          const SizedBox(height: 5),
          _LandDetail(
            icon: Icons.square_foot_outlined,
            text:
                '${land.luasTanah.toStringAsFixed(0)} m²  ·  ${land.jenisSertifikat}',
          ),
          const SizedBox(height: 5),
          _LandDetail(
            icon: Icons.calendar_today_outlined,
            text: 'Terbit ${formatDate(land.tanggalPenerbitan)}',
          ),
        ],
      ),
    ),
  );
}

class _LandDetail extends StatelessWidget {
  const _LandDetail({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 16, color: const Color(0xFF738391)),
      const SizedBox(width: 7),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(color: Color(0xFF586875), fontSize: 13),
        ),
      ),
    ],
  );
}
