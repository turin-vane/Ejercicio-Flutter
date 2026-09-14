import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/home/models/activity.dart';
import 'package:mi_primer_app/features/home/widgets/interactive_activity_card.dart';
import 'package:mi_primer_app/features/profile/screens/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { 
  List<Activity> activityList = [
    Activity(
      title: "Pasos Diarios",
      subtitle: "", 
      trailingText: "", 
      icon: Icons.directions_walk, 
      iconColor: Colors.black),
    Activity(
      title: "Natación",
      subtitle: "", 
      trailingText: "", 
      icon: Icons.pool,
      iconColor: Colors.black),
    Activity(
      title: "Rutina de Fuerza",
      subtitle: "", 
      trailingText: "", 
      icon: Icons.fitness_center,
      iconColor: Colors.black),
    Activity(
      title: "Sesión de Box",
      subtitle: "", 
      trailingText: "", 
      icon: Icons.sports_mma,
      iconColor: Colors.black),
    Activity(
      title: "Desayuno",
      subtitle: "", 
      trailingText: "", 
      icon: Icons.free_breakfast,
      iconColor: Colors.black),
    Activity(
      title: "Comida",
      subtitle: "", 
      trailingText: "", 
      icon: Icons.restaurant,
      iconColor: Colors.black),
  ];

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text("Panel de Actividad Física"),
        actions: [
          // 1. botn en la barra superior
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Perfil de Usuario',
            onPressed: () {
              // 2. nav hacia la pantalla de perfil
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: activityList.length,
          itemBuilder: (context, index){
            final currentActivity = activityList[index];            
            return InteractiveActivityCard(activity: currentActivity);
          },
        )
      )
    );
  }
}