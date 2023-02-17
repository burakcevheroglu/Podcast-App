import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcastapp/const.dart';

final playing = AutoDisposeStateProvider<bool>((ref) => false);
final restart = StateProvider<bool>((ref) => false);
final progressIndicatorProvider = AutoDisposeStateProvider<int>((ref) => 10);

class EpisodePage extends ConsumerWidget {
  const EpisodePage({Key? key, required  this.index, required this.episode, required this.duration}) : super(key: key);

  final int index;
  final int episode;
  final int duration;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: appColors().foregroundColor2,
      appBar: AppBar(title: const Text(
        'podworld',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
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
                  const ProgressIndicatorWidget(),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text('${duration-(ref.watch(progressIndicatorProvider)/1000*duration).toInt()} mins left', style: const TextStyle(color: Colors.white60, fontSize: 14),),
                      Text('${duration.toString()} mins', style: const TextStyle(color: Colors.white60, fontSize: 14),),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.nightlight_outlined),iconSize: 30,),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous_outlined),iconSize: 30,),
                      IconButton(onPressed: () {
                        final periodicTimer = Timer.periodic(
                          const Duration(milliseconds: 5),
                              (timer) {
                                if(ref.read(progressIndicatorProvider)<1000 && ref.read(playing)){
                                  ref.read(progressIndicatorProvider.notifier).update((state) => state+1);
                                }
                                else if(ref.read(progressIndicatorProvider)<1000 && !ref.read(playing)){
                                  ref.read(playing.notifier).update((state) => false);
                                  timer.cancel();
                                }
                                else if(ref.read(progressIndicatorProvider)>=1000 && ref.read(playing)){
                                  if(ref.read(restart)){
                                    ref.read(progressIndicatorProvider.notifier).update((state) => 0);
                                    ref.read(playing.notifier).update((state) => true);
                                    ref.read(restart.notifier).update((state) => false);
                                  }
                                  else{
                                    ref.read(restart.notifier).update((state) => true);
                                    ref.read(playing.notifier).update((state) => false);
                                    timer.cancel();
                                  }
                                }
                          },
                        );
                        ref.read(playing.notifier).update((state) => !state);
                         periodicTimer;
                      }, icon: Icon(!(ref.watch(playing)) ? Icons.play_arrow : Icons.pause),iconSize: 60,color: appColors().orangeColor,),
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
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [appColors().orangeColor,appColors().purpleColor],
                      ),
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: const Center(child: Icon(Icons.navigate_before, size: 50,),),
                ),
                Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [appColors().orangeColor,appColors().purpleColor],
                      ),
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

class ProgressIndicatorWidget extends ConsumerWidget {
  const ProgressIndicatorWidget({
    super.key,
  });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Expanded(flex: ref.watch(progressIndicatorProvider),child: Container(decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [appColors().orangeColor,appColors().purpleColor],
            )
          ),),),
          Expanded(flex: (1000-ref.watch(progressIndicatorProvider)),child: Container(),),
        ],
      ),
    );
  }
}



