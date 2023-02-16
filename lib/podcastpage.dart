import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcastapp/const.dart';
import 'package:podcastapp/episodepage.dart';

final indexStateProvider = StateProvider<int>((ref) => 0);
var initComplated = false;

class PodcastPage extends ConsumerWidget {
  const PodcastPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double areaWidth = MediaQuery.of(context).size.width;
    double areaHeight = 200.0;
    double sideHeight = 130;

    int currentIndex = ref.read(indexStateProvider);

    ref.listen<int>(indexStateProvider, (previous, current) {
      print('New state is $previous -> $current');
      print('Current: ' + currentIndex.toString());
    });

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(podcasts.keys.elementAt(currentIndex)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          PodcastsWidget(
              areaHeight: areaHeight,
              currentIndex: ref.read(indexStateProvider),
              sideHeight: sideHeight,
              areaWidth: areaWidth),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 9,
              child: ListView.builder(
                itemCount: (ref.watch(indexStateProvider)*7%5)+2,
                itemBuilder: (context, index) {
                  return EpisodeTileWidget(episodeIndex: index+1,duration: ((index+1)*7%9)*3+11,);
                },
              )),
        ],
      ),
    );
  }
}

class PodcastsWidget extends ConsumerWidget {
  const PodcastsWidget({
    super.key,
    required this.areaHeight,
    required this.currentIndex,
    required this.sideHeight,
    required this.areaWidth,
  });

  final double areaHeight;
  final int currentIndex;
  final double sideHeight;
  final double areaWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.read(indexStateProvider);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: areaHeight,
          //color: Colors.red,
          child: Stack(
            children: [
              (currentIndex == 0)
                  ? const SizedBox()
                  : Positioned(
                      top: (areaHeight - (sideHeight)) / 2,
                      left: -areaHeight / 4,
                      child: InkWell(
                        onTap: () =>
                            ref.read(indexStateProvider.notifier).state--,
                        child: Container(
                          height: sideHeight,
                          width: sideHeight,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage(podcasts.values
                                      .elementAt(currentIndex - 1)))),
                          child: Expanded(
                            child: Container(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
              Positioned(
                left: (areaWidth - areaHeight) / 2,
                child: Container(
                  height: areaHeight,
                  width: areaHeight,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage(
                              podcasts.values.elementAt(currentIndex)))),
                ),
              ),
              (currentIndex > podcasts.length - 2)
                  ? const SizedBox()
                  : Positioned(
                      top: (areaHeight - (sideHeight)) / 2,
                      right: -areaHeight / 4,
                      child: InkWell(
                        onTap: () =>
                            ref.read(indexStateProvider.notifier).state++,
                        child: Container(
                          height: sideHeight,
                          width: sideHeight,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage(podcasts.values
                                      .elementAt(currentIndex + 1)))),
                          child: Expanded(
                            child: Container(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          podcasts.keys.elementAt(ref.watch(indexStateProvider)),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          ref.watch(indexStateProvider).toString(),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        makeStars(ref.watch(indexStateProvider)),
      ],
    );
  }
}

class EpisodeTileWidget extends ConsumerWidget {
  const EpisodeTileWidget(
      {super.key, required this.episodeIndex, required this.duration});

  final int episodeIndex;
  final int duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0) +
          const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: appColors().foregroundColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: AssetImage(
                              podcasts.values.elementAt(ref.watch(indexStateProvider))))),
                  child: Center(
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: appColors().foregroundColor),
                      child: Center(
                        child: Text(
                          episodeIndex.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Episode ${episodeIndex.toString()}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: Colors.grey.withAlpha(100),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${duration.toString()} mins',
                              style:
                                  TextStyle(color: Colors.grey.withAlpha(200)),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodePage(index: ref.watch(indexStateProvider), episode: episodeIndex, duration: duration))),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: appColors().backgroundColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Center(
                    child: Icon(Icons.play_arrow),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget makeStars(int stars) {
  stars = stars*17%5+1;

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (int i = 0; i < stars; i++)
        Icon(
          Icons.star,
          color: Colors.yellow.withAlpha(255),
        ),
      for (int i = 0; i < 5 - stars; i++)
        Icon(
          Icons.star,
          color: Colors.yellow.withAlpha(80),
        ),
    ],
  );
}
