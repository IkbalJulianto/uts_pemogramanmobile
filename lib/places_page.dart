import 'package:flutter/material.dart';

class PlacesPage extends StatefulWidget {
  final String cityName;

  const PlacesPage({super.key, required this.cityName});

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _places = [
    {'name': 'Taman Hutan Raya', 'city': 'Bandung'},
    {'name': 'Trans Studio Mall', 'city': 'Bandung'},
    {'name': 'Monas', 'city': 'Jakarta'},
    {'name': 'Dunia Fantasi', 'city': 'Jakarta'},
    {'name': 'Taman Bungkul', 'city': 'Surabaya'},
    {'name': 'Atlantis Land', 'city': 'Surabaya'},
    {'name': 'Pemandian Air Panas', 'city': 'Subang'},
    {'name': 'Gedung Sate', 'city': 'Bandung'},
  ];

  List<Map<String, String>> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filterPlaces('');
  }

  void _filterPlaces(String query) {
    setState(() {
      _filteredPlaces = _places
          .where((place) =>
              place['city'] == widget.cityName &&
              place['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tempat di ${widget.cityName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterPlaces,
              decoration: const InputDecoration(
                labelText: 'Cari Tempat Bermain',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPlaces.length,
                itemBuilder: (context, index) {
                  final place = _filteredPlaces[index];
                  return ListTile(
                    title: Text(place['name']!),
                    leading: const Icon(Icons.place),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
