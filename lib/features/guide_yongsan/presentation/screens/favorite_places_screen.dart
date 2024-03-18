import 'package:flutter/material.dart';

class FavoritePlacesScreen extends StatefulWidget {
  static const routeUrl = '/favorite_places';
  static const routeName = 'favorites';
  const FavoritePlacesScreen({super.key});

  @override
  State<FavoritePlacesScreen> createState() => _FavoritePlacesScreenState();
}

class _FavoritePlacesScreenState extends State<FavoritePlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('favorites')),
    );
  }
}
