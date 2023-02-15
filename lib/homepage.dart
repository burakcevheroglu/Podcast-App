import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:podcastapp/const.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: appColors().backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  appbarButton(icon: Icons.search,),
                  Text('podworld',style: TextStyle(fontSize: 24, color: Colors.white),),
                  appbarButton(icon: Icons.menu,),
                ],
              ),
              const SizedBox(height: 40,),
              const Text('Categories',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 100,
                child: ListView.builder(
                  itemCount: appCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    String key = appCategories.keys.elementAt(index);
                    return SingleCategory(title: key, icon: appCategories[key]!);
                  },
                )
              ),
              const SizedBox(height: 20,),
              AspectRatio(
                aspectRatio: 5/3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appColors().foregroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),


                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleCategory extends StatelessWidget {
  SingleCategory({
    super.key, required this.title, required this.icon
  });

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: appColors().foregroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 30),),),
            ),
          ),
          const SizedBox(height: 5,),
           Expanded(child:  Text(title , style: const TextStyle(color: Colors.white, fontSize: 16),)),
        ],
      ),
    );
  }
}

class appbarButton extends StatelessWidget {
  const appbarButton({
    super.key, required this.icon
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
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
        child: Center(child: Icon(icon, color: Colors.white70,),),
      ),
    );
  }
}
