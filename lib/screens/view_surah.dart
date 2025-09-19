import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:t01_quran_app/core/api.dart';
import 'package:t01_quran_app/widgets/ayah_tile.dart';

class ViewSurah extends StatefulWidget {
  
  static String routeName = "/view-surah";

  const ViewSurah({
    super.key,
  });

  @override
  State<ViewSurah> createState() => _ViewSurahState();
}

// TODO: dis be a big fat todo bruv; 
class _ViewSurahState extends State<ViewSurah> {
  late Future<SurahDetail> _surahDetailFuture;
  int playedAyahIndex = 0;
  double progress = 0.0;
  late Surah surah;
  late int index;

  final _player = AudioPlayer();

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _format(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        surah = args['surah'];
        index = args['index'];
        _surahDetailFuture = ApiService.fetchSurahDetail(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (!ModalRoute.of(context)!.settings.arguments.containsKey('surah') ||
    //     !ModalRoute.of(context)!.settings.arguments.containsKey('index')) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Error"),
    //     ),
    //     body: const Center(
    //       child: Text("Invalid arguments passed."),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("${surah.surahName} - ${surah.surahNameArabic}"),
      ),
      floatingActionButton: Card(
        elevation: 4,
        child: Container(
          width: 400,
          padding: EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Reciter"),// + (!(playedAyahIndex==0) ? " - Playing Ayah ${playedAyahIndex}" : "")),

                  StreamBuilder<PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final playing = snapshot.data?.playing ?? false;
                      return FilledButton(
                    style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                        onPressed: () {
                          playing ? _player.pause() : _player.play();
                        }, 
                    child: Row(
                    children: [
                      Text(playing ? "Pause" : "Play"),
                      Icon(playing ? Icons.pause : Icons.play_arrow),
                    ],
                    ),
                  );
                      // return IconButton(
                      //   iconSize: 64,
                      //   icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                      //   onPressed: () {
                      //     playing ? _player.pause() : _player.play();
                      //   },
                      // );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              StreamBuilder<Duration?>(
                stream: _player.durationStream,
                builder: (context, durationSnap) {
                final total = durationSnap.data ?? Duration.zero;

                return StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, positionSnap) {
                  final position = positionSnap.data ?? Duration.zero;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_format(position)), // current time
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Theme.of(context).colorScheme.primary,
                              inactiveTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                              thumbColor: Theme.of(context).colorScheme.primary,
                              overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            ),
                            child: Slider(
                              min: 0,
                              max: total.inMilliseconds.toDouble(),
                              value: position.inMilliseconds
                                  .clamp(0, total.inMilliseconds)
                                  .toDouble(),
                              onChanged: (value) {
                                _player.seek(
                                  Duration(milliseconds: value.toInt()),
                                );
                              },
                            ),
                          ),
                        ), // Slider
                        Text(_format(total)),    // total duration
                      ],
                    ); // Column
                  },
                ); // StreamBuilder<Duration>
              },
            ), // St
                // Row(
                // children: [
                //   Text("00:00.00"),
                //   Expanded(
                //   child: SliderTheme(
                //     data: SliderTheme.of(context).copyWith(
                //     activeTrackColor: Theme.of(context).colorScheme.primary,
                //     inactiveTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                //     thumbColor: Theme.of(context).colorScheme.primary,
                //     overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                //     ),
                //     child: Slider(
                //     value: progress,
                //     onChanged: (value) {
                //       // setState(() {
                //       //   progress = value;
                //       // });
                //     },
                //     min: 0,
                //     max: 100,
                //     divisions: 100,
                //     ),
                //   ),
                //   ),
                //   Text("00:00.00")
                // ],
                // )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.brown.withAlpha(150),
                width: double.infinity,
                height: 240,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      surah.surahName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "${surah.surahNameTranslation} - ${surah.totalAyah} Ayahs",
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    Text(
                      surah.revelationPlace,
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // NOTE: UUUUUUUUUUUUUUUUUUUUGGGGGGGGGGGGGGGHHHHHHHHH edge cases
            ((index == 1) || (index == 9)) ? const SizedBox.shrink() : Column(
              children: [
                Text("بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 28,
                ),),
                Text("In the name of God, the Most Gracious, the Most Merciful.", textAlign: TextAlign.center),
                SizedBox(height: 5),
              ],
            ),
            SizedBox(height: 5),
            FutureBuilder<SurahDetail>(
              future: _surahDetailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 100),
                    child: SizedBox(height: 1, width: 50, child: const CircularProgressIndicator()),
                  );// HACK: Coolio effect but uhh very goofy layout, also proof that A HUMAN MADE AND WROTE THIS WHOLEHEARTEDLY
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final surahDetail = snapshot.data!;
                  _player.setUrl(
                    surahDetail.reciters[0].originalUrl,
                  );
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: surahDetail.ayahs.length,
                    itemBuilder: (context, index) {
                      return AyahTile(ayah: surahDetail.ayahs[index], index: index + 1, playing: (index + 1) == playedAyahIndex, onTap: () {
                        setState(() {
                          playedAyahIndex = index + 1;
                        });
                      },);
                    },
                  );
                } else {
                  return const Text("No data available");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}