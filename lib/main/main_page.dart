import 'package:flutter/material.dart';
import 'package:github_user_listing_demo/features/user_listing/display/pages/favorites_page.dart';
import 'package:github_user_listing_demo/features/user_listing/display/pages/listing_page.dart';
import 'package:github_user_listing_demo/core/providers/navigation_provider.dart';
import 'package:github_user_listing_demo/features/user_listing/display/providers/user_provider.dart';
import 'package:provider/provider.dart';

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
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Users: ${Provider.of<UserProvider>(context).users.length}'),
          )),
        ],
      ),
      body:
      IndexedStack(
        index: Provider.of<NavigationProvider>(context).selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, data, child){
          return BottomNavigationBar(
            currentIndex: data.selectedIndex,
            onTap: (index){
              data.changeIndex(index);
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
          );
        },
      )

    );
  }
}
