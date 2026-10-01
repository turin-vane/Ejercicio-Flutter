import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
 
class StepCounterCard extends StatefulWidget {
  const StepCounterCard({super.key});
 
  @override
  State<StepCounterCard> createState() => _StepCounterCardState();
}
 
class _StepCounterCardState extends State<StepCounterCard> {
  late Stream<StepCount> _stepCountStream;
  bool _permisoConcedido= false;

  @override
  void initState() {
    super.initState();
    _solicitarPermisos();
  }

  Future<void> _solicitarPermisos() async{
    PermissionStatus status = await Permission.activityRecognition.request();
    if(status.isGranted){
      setState(() {
        _permisoConcedido = true;
      });

      _stepCountStream = Pedometer.stepCountStream;
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.blue.shade50,
      margin: EdgeInsets.only(bottom: 15.0),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_walk, size: 30, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Pasos de hoy',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 15,),

            if(_permisoConcedido)
             StreamBuilder<StepCount>(
              stream: _stepCountStream,
              builder: (context, snapshot){

                if(snapshot.hasError){
                  return Text('Error al leer el sensor');
                }
                else if(snapshot.hasData){
                  return Text(
                    snapshot.data!.steps.toString(),
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  );
                }
                return CircularProgressIndicator();
              },
              )
              else
              Text('Se requieren permisos de actividad física')
          ],
        ),
      ),
    );
  }
}