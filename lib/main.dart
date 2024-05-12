import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
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

class CustomDropDown extends ConsumerWidget {
  const CustomDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStatus = ref.watch(favoriteStatusProvider);
    return DropdownButton(
      value: currentStatus,
      items: FavoriteStatus.values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value.name),
            ),
          )
          .toList(),
      onChanged: (value) {
        ref.read(favoriteStatusProvider.notifier).state =
            value ?? FavoriteStatus.all;
      },
    );
  }
}

//enum favorite status
enum FavoriteStatus {
  all,
  favorites,
  nonFavorites,
}

//listview widget
class FilmListWidget extends ConsumerWidget {
  const FilmListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(filmProvider);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final isFavorite = items[index].isFavorite;
            return ListTile(
              title: Text(items[index].title),
              subtitle: Text(items[index].subtitle),
              trailing: IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  ref.read(filmProvider.notifier).favorite(items[index]);
                },
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}

//film Model
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

//list of movies
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

//stateNotifer class
class FilmListProvider extends StateNotifier<List<Film>> {
  FilmListProvider() : super(films);

  void favorite(Film film) {
    state = state.map((element) {
      if (element.id == film.id) {
        element.isFavorite = !element.isFavorite;
        return element;
      } else {
        return element;
      }
    }).toList();
  }
}

//filmListProvider

final filmProvider = StateNotifierProvider<FilmListProvider, List<Film>>(
  (ref) => FilmListProvider(),
);

//favoriteStatusProvider

final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (ref) => FavoriteStatus.all,
);
