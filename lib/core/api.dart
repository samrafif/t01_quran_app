import 'package:t01_quran_app/core/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Surah {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;


  Surah({
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
  });


  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
    surahName: json['surahName'],
    surahNameArabic: json['surahNameArabic'],
    surahNameArabicLong: json['surahNameArabicLong'],
    surahNameTranslation: json['surahNameTranslation'],
    revelationPlace: json['revelationPlace'],
    totalAyah: json['totalAyah'],
    );
  }

  @override
  String toString() {
    return 'Surah{surahName: $surahName, surahNameArabic: $surahNameArabic, surahNameArabicLong: $surahNameArabicLong, surahNameTranslation: $surahNameTranslation, revelationPlace: $revelationPlace, totalAyah: $totalAyah}';
  }
}

class Ayah {
  final String arabic1;
  final String arabic2;
  final String english;
  final String bengali;
  final String urdu;
  final String uzbek;

  Ayah({
    required this.arabic1,
    required this.arabic2,
    required this.english,
    required this.bengali,
    required this.urdu,
    required this.uzbek,
  });

  factory Ayah.fromJson(
    Map<String, dynamic> json,
    int index,
  ) {
    return Ayah(
      arabic1: json['arabic1'][index],
      arabic2: json['arabic2'][index],
      english: json['english'][index],
      bengali: json['bengali'][index],
      urdu: json['urdu'][index],
      uzbek: json['uzbek'][index],
    );
  }
}

class SurahDetail {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final int surahNo;
  final List<Ayah> ayahs;
  List<ReciterAudio> reciters;

  SurahDetail({
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
    required this.surahNo,
    required this.ayahs,
    required this.reciters,
  });

  factory SurahDetail.fromJson(Map<String, dynamic> json) {
    final totalAyah = json['totalAyah'] as int;
    final ayahs = List.generate(
      totalAyah,
      (i) => Ayah.fromJson(json, i),
    );

    final reciters = recitersFromJson(json['audio']);

    return SurahDetail(
      surahName: json['surahName'],
      surahNameArabic: json['surahNameArabic'],
      surahNameArabicLong: json['surahNameArabicLong'],
      surahNameTranslation: json['surahNameTranslation'],
      revelationPlace: json['revelationPlace'],
      totalAyah: totalAyah,
      surahNo: json['surahNo'],
      ayahs: ayahs,
      reciters: reciters.values.toList(),
    );
  }
}

class ReciterAudio {
  final String reciter;
  final String url;
  final String originalUrl;

  ReciterAudio({
    required this.reciter,
    required this.url,
    required this.originalUrl,
  });

  factory ReciterAudio.fromJson(Map<String, dynamic> json) {
    return ReciterAudio(
      reciter: json['reciter'] as String,
      url: json['url'] as String,
      originalUrl: json['originalUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reciter': reciter,
      'url': url,
      'originalUrl': originalUrl,
    };
  }
}

/// Helper to parse the full JSON object into a Map<int, ReciterAudio>
Map<int, ReciterAudio> recitersFromJson(Map<String, dynamic> json) {
  return json.map(
    (key, value) => MapEntry(
      int.parse(key),
      ReciterAudio.fromJson(value as Map<String, dynamic>),
    ),
  );
}



class Endpoints {
  static const baseUrl = Config.baseAPIUrl;

  static const String surahs = "$baseUrl/surah.json";   
  static String getSurahDetail(int surahNo) => "$baseUrl/$surahNo.json";   
}

class ApiService {
  static Future<List<Surah>> fetchSurahs() async {
    final response = await http.get(Uri.parse(Endpoints.surahs));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Surah.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load surahs');
    }
  }

  static Future<SurahDetail> fetchSurahDetail(int surahNo) async {
    final response = await http.get(Uri.parse(Endpoints.getSurahDetail(surahNo)));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return SurahDetail.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load surah detail');
    }
  }
}