import 'package:attraction_tracks/screens/new_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_places.dart';
import '../widgets/places_list.dart';

class FavoritePlacesScreen extends ConsumerStatefulWidget {
  const FavoritePlacesScreen({super.key});

  @override
  ConsumerState<FavoritePlacesScreen> createState() {
    return _FavoritePlacesScreenState();
  }
}
//final List<Place> _favoritePlaces = [];

class _FavoritePlacesScreenState extends ConsumerState<FavoritePlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    // Widget content = ListView.builder(
    //     itemCount: _favoritePlaces.length,
    //     itemBuilder: (context, index) {
    //       return InkWell(
    //         onTap: () {
    //           Navigator.of(context).push(MaterialPageRoute(
    //               builder: (ctx) =>
    //                   PlaceDetailScreen(place: _favoritePlaces[index])));
    //         },
    //         child: Text(_favoritePlaces[index].title,
    //             style: Theme.of(context).textTheme.titleMedium!.copyWith(
    //                 color: Theme.of(context).colorScheme.onBackground)),
    //       );
    //     });

    // if (_favoritePlaces.isEmpty) {
    //   content = Center(
    //     child: Text('No place added yet.',
    //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //             color: Theme.of(context).colorScheme.onSecondaryContainer)),
    //   );
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const NewPlaceScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: _placesFuture,
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : PlacesList(places: userPlaces),
            )));
  }
}
