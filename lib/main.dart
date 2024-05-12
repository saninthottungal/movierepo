import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo Home Page'),
      ),
      body: const Column(
        children: [
          CustomDropDown(),
          FilmListWidget(),
        ],
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: FavoriteStatus.all,
      items: FavoriteStatus.values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value.name),
            ),
          )
          .toList(),
      onChanged: (value) {},
    );
  }
}

enum FavoriteStatus {
  all,
  favorites,
  nonFavorites,
}

class FilmListWidget extends StatelessWidget {
  const FilmListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(films[index].title),
              subtitle: Text(films[index].subtitle),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}

class Film {
  final int id;
  final String title;
  final String subtitle;
  bool isFavorite;

  Film({
    required this.id,
    required this.title,
    required this.subtitle,
    this.isFavorite = false,
  });
}

final List<Film> films = [
  Film(id: 1, title: "Aavesham", subtitle: "Jithu Madhavan"),
  Film(id: 2, title: "Manjummel Boys", subtitle: "Chidambaram"),
  Film(id: 3, title: "Premalu", subtitle: "Gireesh A.D"),
  Film(id: 4, title: "Goat Life", subtitle: "Blessy"),
  Film(id: 5, title: "Varshangalkku Shesham", subtitle: "Vineeth Sreenivasan"),
  Film(id: 6, title: "Turbo", subtitle: "Vyshak"),
  Film(id: 7, title: "Barroz", subtitle: "Mohanlal"),
  Film(id: 8, title: "Lucifer", subtitle: "Pritviraj Sukumaran"),
  Film(id: 9, title: "Kaathal:The Core", subtitle: "Geo Baby"),
  Film(id: 10, title: "Minnal Murali", subtitle: "Basil Joseph"),
];
