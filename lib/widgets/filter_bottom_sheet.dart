import 'package:flutter/material.dart';

const eventCategories = ['Semua', 'AI', 'Mobile', 'IoT', 'Cybersecurity'];

Future<String?> showCategoryFilter(BuildContext context, String selected) =>
    showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Filter kategori', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                const SizedBox(height: 14),
                ...eventCategories.map((category) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(category),
                      trailing: selected == category ? const Icon(Icons.check_circle, color: Color(0xFF64812D)) : const Icon(Icons.circle_outlined, color: Color(0xFF9AA49E)),
                      onTap: () => Navigator.pop(context, category),
                    )),
              ],
            ),
          ),
        ),
      ),
    );