class Place {
  
  final String ciudad;
  final String ubicacion;

  Place({
    required this.ciudad,
    required this.ubicacion,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      ciudad: json['ciudad'],
      ubicacion: json['ubicacion'],
    );
  }

  bool get imageUrl => true;
  
}
