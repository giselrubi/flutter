import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Reservation {
  final int id;
  final int typesId;
  final int placesId;
  final int customersId;
  final String fechaInicio;
  final String fechaFin;

  Reservation({
    required this.id,
    required this.typesId,
    required this.placesId,
    required this.customersId,
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      typesId: json['types_id'] is int ? json['types_id'] : int.tryParse(json['types_id'].toString()) ?? 0,
      placesId: json['places_id'] is int ? json['places_id'] : int.tryParse(json['places_id'].toString()) ?? 0,
      customersId: json['customers_id'] is int ? json['customers_id'] : int.tryParse(json['customers_id'].toString()) ?? 0,
      fechaInicio: json['fecha_inicio'].toString(),
      fechaFin: json['fecha_fin'].toString(),
    );
  }
}

Future<List<Reservation>> fetchReservations() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/reservations'));

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    return data.map((json) => Reservation.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load reservations');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservations App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.blueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reservations'),
        ),
        body: ReservationList(),
      ),
    );
  }
}

class ReservationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
      future: fetchReservations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Reservation> reservations = snapshot.data!;
          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              Reservation reservation = reservations[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reserva ID: ${reservation.id}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text('Tipo de Reserva: ${reservation.typesId}'),
                      Text('Lugar: ${reservation.placesId}'),
                      Text('Cliente: ${reservation.customersId}'),
                      Text('Fecha Inicio: ${reservation.fechaInicio}'),
                      Text('Fecha Fin: ${reservation.fechaFin}'),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

