import 'package:flutter/material.dart';
import 'package:podcastapp/const.dart';
import 'package:podcastapp/homepage.dart';

class AllPodcasts extends StatelessWidget {
  const AllPodcasts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors().backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Trending Podcasts",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double .infinity,
        color: appColors().foregroundColor2,
        child: GridView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: [
            for(int i=0;i<podcasts.length;i++) PodcastWithTextWidget(index: i, edgeSize: 140,)

          ],
        ),
      ),
    );
  }
}
