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
          Text("data"),
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
