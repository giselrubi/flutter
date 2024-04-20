import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Clientes',
      theme: ThemeData(
        primaryColor: Colors.pink[200], // Cambiar el color principal a rosa pastel
        hintColor: const Color.fromARGB(255, 195, 176, 182), // Cambiar el color de acento a una tonalidad más oscura de rosa pastel
        textTheme: TextTheme( // Personalizar el tema de texto
          headline6: TextStyle(color: Color.fromARGB(255, 6, 4, 23), fontWeight: FontWeight.bold), // Estilo para el texto del título
          bodyText2: TextStyle(color: Color.fromARGB(255, 159, 179, 183)), // Estilo para el texto del cuerpo
        ),
      ),
      home: CustomersScreen(),
    );
  }
}

class CustomersScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchCustomers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/customers'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los datos de la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar datos'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> customers = snapshot.data!;

            return ListView.separated(
              itemCount: customers.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                Map<String, dynamic> customer = customers[index];
                return ListTile(
                  tileColor: Colors.pink[50], // Cambiar el color del fondo del ListTile a rosa pastel más claro
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    '${customer['nombre']} ${customer['apellido']}',
                    style: Theme.of(context).textTheme.headline6, // Aplicar el estilo de texto del título definido en el tema
                  ),
                  subtitle: Text(
                    customer['correo'],
                    style: Theme.of(context).textTheme.bodyText2, // Aplicar el estilo de texto del cuerpo definido en el tema
                  ),
                  trailing: Text(
                    customer['telefono'].toString(),
                    style: Theme.of(context).textTheme.bodyText2, // Aplicar el estilo de texto del cuerpo definido en el tema
                  ),
                  onTap: () {
                    _showCustomerDialog(context, customer);
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No hay datos para mostrar'));
          }
        },
      ),
    );
  }

  void _showCustomerDialog(BuildContext context, Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${customer['nombre']} ${customer['apellido']}',
            style: Theme.of(context).textTheme.headline6, // Aplicar el estilo de texto del título definido en el tema
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Correo: ${customer['correo']}',
                  style: Theme.of(context).textTheme.bodyText2, // Aplicar el estilo de texto del cuerpo definido en el tema
                ),
                Text(
                  'Teléfono: ${customer['telefono']}',
                  style: Theme.of(context).textTheme.bodyText2, // Aplicar el estilo de texto del cuerpo definido en el tema
                ),
                // Agregar más detalles si es necesario
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

