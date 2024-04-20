import 'package:flutter/material.dart';
import 'package:pruebasipaso/screens/Lugares/place_controller.dart';
import 'package:pruebasipaso/screens/Lugares/place.dart';

class PlacesPage extends StatefulWidget {
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  final PlaceService _placeService = PlaceService();
  List<Place> _places = [];
  List<Place> _filteredPlaces = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPlaces();
    _searchController.addListener(_filterPlaces);
  }

  void _loadPlaces() async {
    List<Place> places = await _placeService.getPlaces();
    setState(() {
      _places = places;
      _filteredPlaces = places;
    });
  }

  void _filterPlaces() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      _filteredPlaces = _places.where((place) {
        return place.ciudad.toLowerCase().contains(query) ||
               place.ubicacion.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar lugares...',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _placeService.getPlaces(),
        builder: (context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: _filteredPlaces.length,
              itemBuilder: (context, index) {
                final place = _filteredPlaces[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'asset/wowow.jpg', // Reemplaza esta URL con la URL de tu imagen
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      ),
                    ),
                    title: Text(
                      place.ciudad,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      place.ubicacion,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
