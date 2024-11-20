import 'package:flutter/material.dart';
import 'places_page.dart';

class DashboardPage extends StatefulWidget {
  final String username;

  const DashboardPage({super.key, required this.username});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _cities = [
    {'name': 'Bandung', 'image': 'assets/images/bandung.jpg'},
    {'name': 'Jakarta', 'image': 'assets/images/jakarta.jpg'},
    {'name': 'Surabaya', 'image': 'assets/images/surabaya.jpg'},
    {'name': 'Sumedang', 'image': 'assets/images/sumedang.jpg'},
    {'name': 'Subang', 'image': 'assets/images/subang.jpg'},
    {'name': 'Semarang', 'image': 'assets/images/semarang.jpg'},
    {'name': 'Denpasar', 'image': 'assets/images/denpasar.jpg'},
    {'name': 'Makassar', 'image': 'assets/images/makassar.jpg'},
    {'name': 'Palembang', 'image': 'assets/images/palembang.jpg'},
    {'name': 'Pekanbaru', 'image': 'assets/images/pekanbaru.jpg'},
  ];

  List<Map<String, String>> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _filteredCities = _cities; // Initialize with all cities
  }

  void _filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCities = _cities;
      } else {
        _filteredCities = _cities
            .where((city) =>
                city['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, ${widget.username}!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              onChanged: _filterCities,
              decoration: const InputDecoration(
                labelText: 'Cari Kota',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 4, // Adjust aspect ratio for images
                ),
                itemCount: _filteredCities.length,
                itemBuilder: (context, index) {
                  final city = _filteredCities[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the PlacesPage with the selected city name
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlacesPage(cityName: city['name']!),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.asset(
                                city['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              city['name']!,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
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
