import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TypesPage extends StatefulWidget {
  @override
  _TypesPageState createState() => _TypesPageState();
}

class _TypesPageState extends State<TypesPage> {
  List<dynamic> types = [];
  TextEditingController _typeNameController = TextEditingController();

  @override
  void dispose() {
    _typeNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchTypes();
  }

  Future<void> fetchTypes() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/types'),
    );
    if (response.statusCode == 200) {
      setState(() {
        types = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load types');
    }
  }

  Future<void> _addType() async {
    String? typeName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Tipo'),
          content: TextField(
            controller: _typeNameController,
            decoration: InputDecoration(labelText: 'Nombre'),
            onChanged: (value) {},
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                fetchTypes();
                Navigator.of(context).pop(_typeNameController.text);
                fetchTypes();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );

    if (typeName != null && typeName.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/types/create'),
        body: json.encode({'name': typeName}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        fetchTypes();
      } else {
        throw Exception('Failed to add type');
      }
    }
  }

  Future<void> _deleteType(int typeId) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/types/delete/$typeId'),
    );
    if (response.statusCode == 200) {
      fetchTypes();
    } else {
      throw Exception('Failed to delete type');
    }
  }

  Future<void> _editType(int typeId, String typeName) async {
  String? editedTypeName = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      TextEditingController _editTypeNameController =
          TextEditingController(text: typeName);
      return AlertDialog(
        title: Text('Editar Tipo'),
        content: TextField(
          controller: _editTypeNameController,
          decoration: InputDecoration(labelText: 'Nombre'),
          onChanged: (value) {},
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final response = await http.post(
                Uri.parse('http://127.0.0.1:8000/api/types/update'),
                body: json.encode({'id': typeId, 'name': _editTypeNameController.text}),
                headers: {'Content-Type': 'application/json'},
              );
              if (response.statusCode == 200) {
                fetchTypes();
                Navigator.of(context).pop(_editTypeNameController.text);
                fetchTypes();
              } else {
                throw Exception('Failed to edit type');
              }
            },
            child: Text('Editar'),
          ),
        ],
      );
    },
  );

  if (editedTypeName != null && editedTypeName.isNotEmpty) {
    // Aquí puedes manejar cualquier otra acción necesaria después de editar el tipo
  }
}


  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Types'),
      ),
      body: types.isEmpty
          ? Center(
              child: Text('No hay tipos disponibles'),
            )
          : ListView.builder(
              itemCount: types.length,
              itemBuilder: (context, index) {
                final type = types[index];
                return ListTile(
                  title: Text('ID: ${type['id']}'),
                  subtitle: Text('Nombre: ${type['name']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editType(type['id'], type['name']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteType(type['id']);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addType,
        child: Icon(Icons.add),
      ),
    );
  }
}
