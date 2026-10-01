import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/home/models/item.dart';
import 'package:mi_primer_app/features/profile/screens/profile_screen.dart';
import 'package:mi_primer_app/features/details/screens/detail_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { 
  List<Item> listaBacklog = [
    Item(titulo: "The Witcher", categoria: "Serie", completado: false),
    Item(titulo: "1984", categoria: "Libro físico", completado: true),
  ];

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 113, 237),
        foregroundColor: Colors.white,
        title: const Text("Mis pendientes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Perfil de Usuario',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(), //pendiente: cambiar (oantalla perfil) a la tematica de los libros, series, etc
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Expanded(
              child: ListView.builder(
                itemCount: listaBacklog.length,
                itemBuilder: (context, index) {
                  final item = listaBacklog[index];

                  return Dismissible(
                    key: Key(item.titulo + index.toString()), 
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      setState(() {
                        listaBacklog.removeAt(index);
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.titulo} eliminado correctamente')),
                      );
                    },
                    child: Card(
                      child: ListTile(
                       title: Text(item.titulo),
                       subtitle: Text(item.categoria),
                       // trailing: Icon(item.completado ? Icons.check_box : Icons.check_box_outline_blank),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(item: item), 
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // FloatingActionButton
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          String categoriaSeleccionada = 'Videojuego'; 
          TextEditingController tituloController = TextEditingController();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder( 
                builder: (context, setStateDialog) {
                  return AlertDialog(
                    title: const Text('Agregar nuevo elemento'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: tituloController,
                          decoration: const InputDecoration(labelText: 'Título'),
                        ),
                        const SizedBox(height: 16),
                        DropdownButton<String>(
                          value: categoriaSeleccionada,
                          isExpanded: true,
                          items: ['Videojuego', 'Libro digital', 'Libro físico', 'Serie', 'Película'].map((String valor) {
                            return DropdownMenuItem<String>(
                              value: valor,
                              child: Text(valor),
                            );
                          }).toList(),
                          onChanged: (String? nuevoValor) {
                            setStateDialog(() { 
                              categoriaSeleccionada = nuevoValor!;
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (tituloController.text.isNotEmpty) {
                            setState(() { 
                              listaBacklog.add(Item(
                                titulo: tituloController.text,
                                categoria: categoriaSeleccionada,
                              ));
                            });
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Elemento agregado correctamente')),
                            );
                            
                            Navigator.pop(context); 
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  );
                }
              );
            },
          );
        },
      ),
    );
  }
}