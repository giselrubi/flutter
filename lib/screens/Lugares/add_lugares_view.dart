import 'package:flutter/material.dart';
import 'package:pruebasipaso/screens/Lugares/place_controller.dart';
import 'package:pruebasipaso/screens/Lugares/place.dart';


class AddPlacePage extends StatefulWidget {
  @override
  _AddPlacePageState createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final PlaceService _placeService = PlaceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _ciudadController,
              decoration: InputDecoration(
                labelText: 'Ciudad',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ubicacionController,
              decoration: InputDecoration(
                labelText: 'Ubicación',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addPlace();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _addPlace() async {
    final String ciudad = _ciudadController.text.trim();
    final String ubicacion = _ubicacionController.text.trim();

    if (ciudad.isNotEmpty && ubicacion.isNotEmpty) {
      final Place newPlace = Place(ciudad: ciudad, ubicacion: ubicacion);
      await _placeService.addPlace(newPlace);
      Navigator.pop(context, true); // Regresa a la pantalla anterior
    } else {
      // Muestra un mensaje de error si los campos están vacíos
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, completa todos los campos.'),
        backgroundColor: Color.fromARGB(255, 20, 227, 162),
      ));
    }
  }
}
