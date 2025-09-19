import 'package:flutter/material.dart';
import 'package:t01_quran_app/core/api.dart';
import 'package:t01_quran_app/screens/view_surah.dart';
import 'package:t01_quran_app/widgets/surah_tile.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Surah>> surahListFuture;
  bool firstLoad = true; // NOTE: thought refreshindicator changed the layout when reloading so i tought i needed this but NOPE, oh well to lazy to get rid of it
  bool reversed = false;

  @override
  void initState() {
    super.initState();
    surahListFuture = ApiService.fetchSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Halo Quran, :3"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        reversed = !reversed;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sort),
                        Icon(reversed ? Icons.arrow_upward : Icons.arrow_downward),
                      ],
                    ) // Text(reversed ? "Normal Order" : "Reverse Order"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                setState(() {
                  firstLoad = false;
                  surahListFuture = ApiService.fetchSurahs();
                });
                return surahListFuture;
              },
                child: FutureBuilder<List<Surah>>(
                  future: surahListFuture,
                  builder: (context, snapshot) {
                    if ((snapshot.connectionState == ConnectionState.waiting)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 500),
                        child: SizedBox(height: 100, width: 100, child: const CircularProgressIndicator()),
                      ); // HACK: Coolio effect but uhh very goofy layout
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final surahList = (reversed ? snapshot.data!.reversed : snapshot.data!).toList();
                      return ListView.builder(
                        itemCount: surahList.length,
                        itemBuilder: (context, index) {
                          index = (reversed ? (surahList.length - index - 1) : index);
                          return SurahTile(surah: surahList[index], index: index + 1, onTap: () {
                            // Handle tile tap
                            print("Tapped on Surah: ${surahList[index].surahName}");
                            Navigator.pushNamed(context, ViewSurah.routeName, arguments: {
                              'surah': surahList[index],
                              'index': index + 1,
                            });
                          });
                        },
                      );
                    } else {
                      return const Text("No data available");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
