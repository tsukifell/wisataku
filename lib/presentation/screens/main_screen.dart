import 'package:flutter/material.dart';
import 'package:wisataku/data/services/firebase_service.dart';
import 'package:wisataku/presentation/screens/input_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisataku'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const InputScreen()));
          },
          child: const Icon(Icons.add)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: StreamBuilder<Map<String, dynamic>>(
                  stream: getTourismPlace(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> places = snapshot.data!;
                      if (places.isEmpty) {
                        return const Center(
                            child: Text('Data Wisata masih kosong!'));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final key = places.keys.elementAt(index);
                          final place = places[key];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey[200], // Background color
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                place['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.tour),
                                      Text('Lokasi: ${place['location']}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.place),
                                      Text(
                                          'Luas Area: ${place['areaSize']} km'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.description),
                                      Text(
                                          'Deskripsi: ${place['description']}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('An error occured ${snapshot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}
