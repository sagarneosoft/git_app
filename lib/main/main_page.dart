import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_listing_demo/core/bloc/cubit/navigation_cubit.dart';
import 'package:github_user_listing_demo/features/user_listing/display/pages/favorites_page.dart';
import 'package:github_user_listing_demo/features/user_listing/display/pages/listing_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<Widget> _pages = <Widget>[
    UserListing(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Git hub Users'),
      ),
      body: IndexedStack(
        index: context.watch<NavigationCubit>().state.index,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<NavigationCubit>().state.index,
        onTap: (index) {
          context.read<NavigationCubit>().onTap(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken_rounded),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
