import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcastapp/const.dart';
import 'package:podcastapp/podcastpage.dart';
import 'package:podcastapp/settings.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: appColors().backgroundColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: appColors().backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0) + const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarRow(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  const [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CategoriesListView(),
                  SizedBox(
                    height: 20,
                  ),
                  Banner(),
                  SizedBox(
                    height: 30,
                  ),
                  HeaderRow(title: "Trending podcasts"),
                  SizedBox(
                    height: 10,
                  ),
                  TrendingPodcastsWidget(),
                  SizedBox(height: 30,),
                  HeaderRow(title: "Recently played"),
                  SizedBox(height: 10,),
                  RecentlyPodcastTile(index: 6, episode: 2, minsLeft: 35),
                  RecentlyPodcastTile(index: 3, episode: 4, minsLeft: 18),
                  RecentlyPodcastTile(index: 8, episode: 7, minsLeft: 22)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecentlyPodcastTile extends StatelessWidget {
  const RecentlyPodcastTile({
    super.key, required this.index, required this.episode, required this.minsLeft
  });

  final int index;
  final int episode;
  final int minsLeft;


  @override
  Widget build(BuildContext context) {
    String title = podcasts.keys.elementAt(index);
    String imagePath = podcasts[title]!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage(imagePath)
                )
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white),),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Episode ${episode.toString()}', style: const TextStyle(color: Colors.white70),),
                      Row(
                        children:  [
                          const Icon(Icons.access_time_outlined, color: Colors.grey,),
                          const SizedBox(width: 5,),
                          Text("${minsLeft.toString()} mins left", style: const TextStyle(color: Colors.grey),)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TrendingPodcastsWidget extends ConsumerWidget {
  const TrendingPodcastsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 190,
      child: ListView.builder(
        itemCount: podcasts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String key = podcasts.keys.elementAt(index);
          return Padding(
            padding: (index!=podcasts.length-1) ? const EdgeInsets.only(right: 25.0) : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PodcastPage(index: index,)));
                    ref.watch(indexStateProvider.notifier).update((state) => index);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: appColors().foregroundColor,
                        image: DecorationImage(
                            image: AssetImage(podcasts[key]!))),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                    width: 110,
                    height: 50,
                    child: Text(
                      key,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppBarRow extends StatelessWidget {
  const AppBarRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        AppbarButton(
          icon: Icons.search,
          page: 0,
        ),
        Text(
          'podworld',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        AppbarButton(
          icon: Icons.menu,
          page: 1
        ),
      ],
    );
  }
}
class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'See All',
          style: TextStyle(color: Colors.white70),
        )
      ],
    );
  }
}

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        child: ListView.builder(
          itemCount: appCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String key = appCategories.keys.elementAt(index);
            return SingleCategory(title: key, icon: appCategories[key]!);
          },
        ));
  }
}

class Banner extends StatelessWidget {
  const Banner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColors().foregroundColor,
          image: const DecorationImage(
              image: AssetImage("lib/assets/banner.png"), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class SingleCategory extends StatelessWidget {
  const SingleCategory({super.key, required this.title, required this.icon});

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: appColors().foregroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
        ],
      ),
    );
  }
}

class AppbarButton extends StatelessWidget {
  const AppbarButton({super.key, required this.icon, required this.page});

  final IconData icon;
  final int page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(page==1){
             Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
        }
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: appColors().foregroundColor,
            width: 2.5,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
