import 'package:flutter/material.dart';
import 'package:wisataku/data/services/firebase_service.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _areaSizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Wisata'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Nama Tempat Wisata',
                      icon: Icon(Icons.tour),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                      labelText: 'Lokasi',
                      icon: Icon(Icons.place),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _areaSizeController,
                  decoration: const InputDecoration(
                      labelText: 'Luas Area',
                      icon: Icon(Icons.width_full),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                      icon: Icon(Icons.description),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    bool uploadResult = await addTourismPlace(
                        _nameController.text,
                        _locationController.text,
                        double.parse(_areaSizeController.text),
                        _descriptionController.text);

                    if (uploadResult) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data berhasil di upload!.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Gagal mengupload data!.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _areaSizeController.dispose();
    _descriptionController.dispose();
  }
}
