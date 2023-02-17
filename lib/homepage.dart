import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcastapp/allpodcasts.dart';
import 'package:podcastapp/assets/allrecentlyplayed.dart';
import 'package:podcastapp/const.dart';
import 'package:podcastapp/episodepage.dart';
import 'package:podcastapp/podcastpage.dart';
import 'package:podcastapp/settings.dart';

 
 final _searchBar = StateProvider<double>((ref) => 0);
 TextEditingController _searchBarText= TextEditingController();

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
          padding: const EdgeInsets.all(20.0) + const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarRow(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  const [
                  SizedBox(
                    height: 20,
                  ),
                  SearchBarWidget(),
                  SizedBox(height: 20,),
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
                  HeaderRow(title: "Trending podcasts" ,seeAll: 0),
                  SizedBox(
                    height: 10,
                  ),
                  TrendingPodcastsWidget(),
                  SizedBox(height: 30,),
                  HeaderRow(title: "Recently played", seeAll: 1,),
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

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      width: double.infinity,
      height: ref.watch(_searchBar),
      color: appColors().foregroundColor,
      clipBehavior: Clip.hardEdge,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
        child: TextField(
          autofocus: true,
          controller: _searchBarText,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Search the Podcast',
            prefixIcon: const Icon(Icons.search),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: appColors().orangeColor),
            ),
            suffixIcon: IconButton(onPressed: (){
              ref.read(_searchBar.notifier).update((state) => 0);
              _searchBarSubmit(context, ref);
            }, icon: const Icon(Icons.send)),
            isCollapsed: false,
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
          onSubmitted: (String text){
            ref.read(_searchBar.notifier).update((state) => 0);
            _searchBarSubmit(context, ref);
          },
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
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodePage(index: index, episode: episode, duration: minsLeft))),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: appColors().foregroundColor
          ),
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
                            Text("${minsLeft.toString()} mins left", style: const TextStyle(color: Colors.grey),),
                            const SizedBox(width: 10,),
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
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: ListView.builder(
        itemCount: (podcasts.length>5) ? 5 : podcasts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: (index!=podcasts.length-1) ? const EdgeInsets.only(right: 25.0) : EdgeInsets.zero,
            child: PodcastWithTextWidget(index: index, edgeSize: 130,),
          );
        },
      ),
    );
  }
}

class PodcastWithTextWidget extends ConsumerWidget {
  const PodcastWithTextWidget({
    super.key,
    required this.index,
    required this.edgeSize
  });

  final int index;
  final double edgeSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PodcastPage(index: index,)));
            ref.watch(indexStateProvider.notifier).update((state) => index);
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: edgeSize,
            width: edgeSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appColors().foregroundColor,
                image: DecorationImage(
                    image: AssetImage(podcasts.values.elementAt(index)))),
          ),
        ),
        const SizedBox(height: 10,),
        SizedBox(
            width: edgeSize-20,
            height: 50,
            child: Text(
              podcasts.keys.elementAt(index),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15),
            ))
      ],
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
  const HeaderRow({super.key, required this.title, required this.seeAll});

  final String title;
  final int seeAll;

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
        GestureDetector(
          onTap: () {
            if(seeAll==0){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPodcasts()));
            }
            else if(seeAll==1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllRecentlyPlayed()));
            }
          },
          child: const Text(
            'See All',
            style: TextStyle(color: Colors.white70),
          ),
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
    return SizedBox(
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
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class AppbarButton extends ConsumerWidget {
  const AppbarButton({super.key, required this.icon, required this.page});

  final IconData icon;
  final int page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: (){
        if(page==0){
          if(ref.read(_searchBar)==0) {
            ref.read(_searchBar.notifier).update((state) => 60);
          } else {
            ref.read(_searchBar.notifier).update((state) => 0);
          }
        }
        else if(page==1){
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

void _searchBarSubmit(BuildContext context, WidgetRef ref){
  for(int i=0; i<podcasts.length;i++){
      String podcastName = podcasts.keys.elementAt(i);


      if(i==podcasts.length-1 || _searchBarText.text==""){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PodcastPage(index: podcasts.length-1,)));
        ref.watch(indexStateProvider.notifier).update((state) => podcasts.length-1);
        break;
      }
      if(podcastName.toLowerCase().replaceAll(" ", "") == _searchBarText.text.toLowerCase().replaceAll(" ", "")){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PodcastPage(index: i,)));
        ref.watch(indexStateProvider.notifier).update((state) => i);
        break;
      }
      else if(podcastName.toLowerCase().contains(_searchBarText.text.toLowerCase())){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PodcastPage(index: i,)));
        ref.watch(indexStateProvider.notifier).update((state) => i);
        break;
      }

    }
  _searchBarText.text="";
}


