import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcastapp/const.dart';

final playing = StateProvider<bool>((ref) => false);

class EpisodePage extends ConsumerWidget {
  const EpisodePage({Key? key, required  this.index, required this.episode, required this.duration}) : super(key: key);

  final int index;
  final int episode;
  final int duration;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int progressIndicator = 70;

    return Scaffold(
      backgroundColor: appColors().foregroundColor,
      appBar: AppBar(title: const Text(
        'podworld',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width-80,
                    height: MediaQuery.of(context).size.width-80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage(podcasts.values.elementAt(index)),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(width:350,child: Text(podcasts.keys.elementAt(index), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24),)),
                  const SizedBox(height: 20,),
                  Text('Episode ${episode.toString()}', style: const TextStyle(color: Colors.white60, fontSize: 16),),
                  const SizedBox(height: 30,),
                  ProgressIndicatorWidget(progressIndicator: progressIndicator),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text('2 mins', style: TextStyle(color: Colors.white60, fontSize: 14),),
                      Text('${duration.toString()} mins', style: const TextStyle(color: Colors.white60, fontSize: 14),),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.nightlight_outlined),iconSize: 30,),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous_outlined),iconSize: 30,),
                      IconButton(onPressed: () => ref.watch(playing.notifier).update((state) => !state), icon: Icon((ref.watch(playing)) ? Icons.play_arrow : Icons.pause),iconSize: 60,),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next_outlined),iconSize: 30,),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.repeat),iconSize: 30,),
                    ],
                  )


                ],
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade600,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: const Center(child: Icon(Icons.navigate_before, size: 50,),),
                ),
                Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade600,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  ),
                  child: const Center(child: Icon(Icons.navigate_next, size: 50,),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
    required this.progressIndicator,
  });

  final int progressIndicator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(50),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Expanded(flex: progressIndicator,child: Container(decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400,Colors.orange.shade900],
            )
          ),),),
          Expanded(flex: (100-progressIndicator),child: Container(),),
        ],
      ),
    );
  }
}
