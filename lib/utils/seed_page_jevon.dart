import 'package:flutter/material.dart';
import 'movie_seeder_jevon.dart';

class SeedPageJevon extends StatefulWidget {
  const SeedPageJevon({super.key});

  @override
  State<SeedPageJevon> createState() => _SeedPageJevonState();
}

class _SeedPageJevonState extends State<SeedPageJevon> {
  final MovieSeederJevon _seeder = MovieSeederJevon();
  bool _isSeeding = false;
  bool _isUpdating = false;
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Seeder'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.movie_filter, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text(
                'Movie Database Seeder',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Anggota 1: Backend Engineer & Data Seeder',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              
              if (_status.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(_status),
                ),
              
              ElevatedButton.icon(
                onPressed: _isSeeding ? null : _seedMovies,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Seed Movies (10 Films)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(250, 50),
                ),
              ),
              const SizedBox(height: 20),
              
              ElevatedButton.icon(
                onPressed: _isUpdating ? null : _updateMovies,
                icon: const Icon(Icons.update),
                label: const Text('Update Field Names'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(250, 50),
                ),
              ),
              const SizedBox(height: 20),
              
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Home'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(250, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _seedMovies() async {
    setState(() {
      _isSeeding = true;
      _status = 'Seeding movies... Please wait.';
    });
    
    await _seeder.seedMovies();
    
    setState(() {
      _isSeeding = false;
      _status = 'Seeding completed! 10 movies added to Firestore.';
    });
  }

  Future<void> _updateMovies() async {
    setState(() {
      _isUpdating = true;
      _status = 'Updating field names...';
    });
    
    await _seeder.updateExistingMovies();
    
    setState(() {
      _isUpdating = false;
      _status = 'Update completed! Fields renamed to match specification.';
    });
  }
}