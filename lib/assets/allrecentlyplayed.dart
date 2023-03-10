import 'package:flutter/material.dart';
import 'package:podcastapp/const.dart';
import 'package:podcastapp/homepage.dart';

class AllRecentlyPlayed extends StatelessWidget {
  const AllRecentlyPlayed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors().backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Recently Played",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: appColors().backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: podcasts.length,
            itemBuilder: (context, index){
              return RecentlyPodcastTile(index: index, episode: index*17%5+1, minsLeft: index*19%9+10);
            },
          ),
        ),
      ),
    );
  }
}
