import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/home/models/item.dart';

class DetailScreen extends StatelessWidget {
  // Ahora recibe un objeto Item en lugar de Activity
  final Item item;

  const DetailScreen({super.key, required this.item});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.titulo),
        backgroundColor: const Color.fromARGB(255, 233, 113, 237),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Categoría: ${item.categoria}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 16),
            Text(
              'Estado: ${item.completado ? "Completado" : "Pendiente"}',
              style: TextStyle(
                fontSize: 18,
                color: item.completado ? Colors.green : const Color.fromARGB(255, 153, 2, 98),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Volver")
            ),
          ],
        ),
      )
    );
  }
}