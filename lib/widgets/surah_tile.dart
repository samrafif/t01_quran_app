import 'package:flutter/material.dart';
import 'package:t01_quran_app/core/api.dart';

class SurahTile extends StatelessWidget {
  final Surah surah;
  final int index;
  final Function()? onTap;

  const SurahTile({
    super.key, 
    required this.surah,
    required this.index,
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
        leading: CircleAvatar(
          child: Text(index.toString()),
        ),
        title: Text(surah.surahName),
        subtitle: Text("${surah.surahNameTranslation} - ${surah.totalAyah} Ayahs"),
        trailing: Text(surah.surahNameArabic,
            style: Theme.of(context).textTheme.titleSmall
          )),
      );
  }
}