import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/details/screens/detail_screen.dart';
import 'package:mi_primer_app/features/home/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InteractiveActivityCard extends StatefulWidget{
  final Item item;


  const InteractiveActivityCard({super.key, required this.item});

  @override
  State<InteractiveActivityCard> createState()=> _InteractiveActivityCardState();
}

class _InteractiveActivityCardState extends State<InteractiveActivityCard>{
  bool isCompleted = false;

  @override
  void initState(){
    super.initState();
    _cargarEstado();
  }

  Future<void> _cargarEstado() async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isCompleted = prefs.getBool(widget.item.titulo) ?? false;
    });
  }
  Future<void> _guardaEstado(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.item.titulo, value);
  }

  @override
  Widget build(BuildContext context){
    return Card(
      color: isCompleted ? Colors.green.shade100 : Colors.white,
      elevation: 4,
      child:ListTile(
        title: Text(widget.item.titulo),
        subtitle: Text(isCompleted ? '¡Completado!' : 'Pendiente de completar'),
        onTap: (){
          Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => DetailScreen(item: widget.item),
            ));
        },
        trailing: IconButton(
          onPressed: (){
            setState(() {
               isCompleted = !isCompleted;
            });
            _guardaEstado(isCompleted);
            },
          icon: Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey,
            ),
        ),
      )

    );
  }
}