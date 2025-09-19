import 'package:flutter/material.dart';
import 'package:t01_quran_app/core/api.dart';

class AyahTile extends StatelessWidget {
  final Ayah ayah;
  final int index;
  final bool playing;
  final Function()? onTap;

  const AyahTile({
    super.key, 
    required this.ayah,
    required this.index,
    required this.playing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tile tap if needed
        if (onTap != null) {
          onTap!();
        }
      },
      child: ListTile(
        tileColor: playing ? Colors.brown[100] : null,
        leading: CircleAvatar(
          child: Text(index.toString()),
        ),
        title: Text(ayah.arabic1, style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 24,
        ),),
        subtitle: Text(ayah.english),
        // trailing: Text(ayah.surahNameArabic),
      ),
    );
  }
}