import 'package:flutter/material.dart';

class Reserva {
  int id;
  int typesId;
  int placesId;
  int customersId;
  DateTime fechaInicio;
  DateTime fechaFin;

  Reserva({
    required this.id,
    required this.typesId,
    required this.placesId,
    required this.customersId,
    required this.fechaInicio,
    required this.fechaFin,
  });
}

class ReservaScreen extends StatefulWidget {
  @override
  _ReservaScreenState createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos del formulario
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _typesIdController = TextEditingController();
  final TextEditingController _placesIdController = TextEditingController();
  final TextEditingController _customersIdController = TextEditingController();
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinController = TextEditingController();

  // Función para guardar la reservación
  void _guardarReservacion() {
    if (_formKey.currentState!.validate()) {
      // Procesar la reservación
      // ignore: unused_local_variable
      final reserva = Reserva(
        id: int.parse(_idController.text),
        typesId: int.parse(_typesIdController.text),
        placesId: int.parse(_placesIdController.text),
        customersId: int.parse(_customersIdController.text),
        fechaInicio: DateTime.parse(_fechaInicioController.text),
        fechaFin: DateTime.parse(_fechaFinController.text),
      );

      // Aquí puedes agregar código para guardar la reservación en una base de datos o realizar alguna acción adicional.

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reservación guardada con éxito.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Reservaciones'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de ID
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un ID.';
                  }
                  return null;
                },
              ),
              // Campo de types_id
              TextFormField(
                controller: _typesIdController,
                decoration: InputDecoration(labelText: 'ID de Tipo de Reservación'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un ID de tipo de reservación.';
                  }
                  return null;
                },
              ),
              // Campo de places_id
              TextFormField(
                controller: _placesIdController,
                decoration: InputDecoration(labelText: 'ID del Lugar'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un ID del lugar.';
                  }
                  return null;
                },
              ),
              // Campo de customers_id
              TextFormField(
                controller: _customersIdController,
                decoration: InputDecoration(labelText: 'ID del Cliente'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un ID del cliente.';
                  }
                  return null;
                },
              ),
              // Campo de fecha_inicio
              TextFormField(
                controller: _fechaInicioController,
                decoration: InputDecoration(labelText: 'Fecha de Inicio'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una fecha de inicio.';
                  }
                  return null;
                },
              ),
              // Campo de fecha_fin
              TextFormField(
                controller: _fechaFinController,
                decoration: InputDecoration(labelText: 'Fecha de Fin'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una fecha de fin.';
                  }
                  return null;
                },
              ),
              // Botón para guardar la reservación
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarReservacion,
                child: Text('Guardar Reservación'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

