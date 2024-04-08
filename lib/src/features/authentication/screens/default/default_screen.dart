import 'package:flutter/material.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("ManTrack"),
        backgroundColor: Theme.of(context).primaryColor,
       
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          
          children: [
            Text("heading", style: Theme.of(context).textTheme.headlineLarge,),
            Text("sub-heading", style: Theme.of(context).textTheme.titleMedium),
            Text("body", style: Theme.of(context).textTheme.bodyMedium),
            ElevatedButton(onPressed: (){}, child: const Text("Elevado"),),
            OutlinedButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Outline"))
            
          ],
        ),),
    );
  }
}