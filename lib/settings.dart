import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Settings'),

      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 500,
            child: ListView.builder(
              itemCount: SettingButtons.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  onTap: (){},
                  leading: SettingIcons[index],
                  title: Text(SettingButtons[index],style: const TextStyle(color: Colors.white),),
                );
              },
            ),
          ),
          const Expanded(flex:2,child: SizedBox()),
          Expanded(flex:3,child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text('Made by @burakcevheroglu',style: TextStyle(color: Colors.white,fontSize: 20)),
              const SizedBox(height: 10,),
              Image.asset('lib/assets/github.png',color: Colors.white,width: 50,),
              const SizedBox(height: 50,)
            ],
          ))
        ],
      ),
    );
  }
}

List<String> SettingButtons = [
  "Account Details",
  "Notifications",
  "Privacy",
  "Security",
  "Help",
  "About",
  "Theme"
];

List<Icon> SettingIcons = const [
  Icon(Icons.account_circle),
  Icon(Icons.notifications),
  Icon(Icons.privacy_tip_sharp),
  Icon(Icons.security_sharp),
  Icon(Icons.help),
  Icon(Icons.info),
  Icon(Icons.palette)
];