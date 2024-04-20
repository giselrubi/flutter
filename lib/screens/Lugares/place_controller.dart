import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pruebasipaso/screens/Lugares/place.dart';

class PlaceService {
  final String apiUrl = 'http://127.0.0.1:8000/api/pleaces';

  Future<List<Place>> getPlaces() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((placeJson) => Place.fromJson(placeJson)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<void> addPlace(Place newPlace) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'ciudad': newPlace.ciudad,
        'ubicacion': newPlace.ubicacion,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add place');
    }
  }
}


