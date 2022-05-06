import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:github_user_listing_demo/features/user_listing/display/bloc/user_local_listing/bloc/local_listing_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocalListingBloc>(context, listen: false)
        .add(LocalEventsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocalListingBloc, LocalListingState>(
          listener: (context, state) {},
          child: BlocBuilder<LocalListingBloc, LocalListingState>(
              builder: (context, state) {
            if (state.uiState == LocalState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.uiState == LocalState.success) {
              return StreamBuilder<List<User>>(
                  stream: state.users,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<User>> snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return const Center(child:  CircularProgressIndicator());
                    // }
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('state..error!.errorMessage!');
                      } else if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 30),
                              child: Text(
                                'Favorite Users',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            snapshot.data!.isEmpty
                                ? const Center(
                                    child: Center(
                                      child: Text('No Favorites for now '),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          var user = snapshot.data![index];
                                          return Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        // Border width
                                                        decoration:
                                                            const BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: ClipOval(
                                                          child:
                                                              SizedBox.fromSize(
                                                            size: const Size
                                                                .fromRadius(40),
                                                            // Image radius
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  user.avatar,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Text(
                                                          user.name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  BlocBuilder<LocalListingBloc,
                                                          LocalListingState>(
                                                      builder:
                                                          (context, state) {
                                                    return Checkbox(
                                                        value: user.isSelected,
                                                        onChanged: (value) {
                                                          if (value == false) {
                                                            BlocProvider.of<
                                                                        LocalListingBloc>(
                                                                    context)
                                                                .add(
                                                                    UserEventDelete(
                                                                        user));
                                                          }
                                                        });
                                                  }),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                          ],
                        );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return const Center(
                          child: Text('Add Users to Favorites'));
                    }
                  });
            } else {
              return Container(
                child: Text('This is text'),
              );
            }
          })),

      // Consumer<UserProvider>(
      //   builder: (context, data , child) {
      //     return StreamBuilder<List<User>>(
      //         stream: data.databaseUsers,
      //         builder: (BuildContext context,
      //             AsyncSnapshot<List<User>> snapshot) {
      //           // if (snapshot.connectionState == ConnectionState.waiting) {
      //           //   return const Center(child:  CircularProgressIndicator());
      //           // }
      //           if (snapshot.connectionState == ConnectionState.active
      //               || snapshot.connectionState == ConnectionState.done) {
      //             if (snapshot.hasError) {
      //               return  Text(data.error!.errorMessage!);
      //             }
      //             else if (snapshot.hasData) {
      //               return Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const Padding(
      //                     padding:  EdgeInsets.symmetric(vertical: 30,horizontal: 30),
      //                     child:  Text('Favorite Users', style: TextStyle(
      //                       fontSize: 25
      //                     ),),
      //                   ),
      //                   snapshot.data!.isEmpty ?
      //                      const  Center(
      //                         child: Center(
      //                           child: Text('No Favorites for now '),
      //                         ),
      //                       ):
      //                   Expanded(
      //                     child: ListView.builder(
      //                       shrinkWrap: true,
      //                         itemCount: snapshot.data?.length ?? 0,
      //                         itemBuilder: (context, index){
      //                           var user = snapshot.data![index];
      //                           return Card(
      //                             child: Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Row(
      //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                 children: [
      //                                   Row(
      //                                     children: [
      //                                       Container(
      //                                         padding: const EdgeInsets.all(2), // Border width
      //                                         decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      //                                         child: ClipOval(
      //                                           child: SizedBox.fromSize(
      //                                             size: const Size.fromRadius(40), // Image radius
      //                                             child: CachedNetworkImage(
      //                                               imageUrl: user.avatar,
      //                                               placeholder: (context, url) => const CircularProgressIndicator(),
      //                                               errorWidget: (context, url, error) => const Icon(Icons.error),
      //                                             ),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //                                         child: Text(user.name, style:const TextStyle(
      //                                             fontSize: 12
      //                                         ),),
      //                                       )
      //                                     ],
      //                                   ),
      //                                   Checkbox(
      //                                       value: user.isSelected,
      //                                       onChanged:(value){
      //                                         if(value == false)
      //                                           {
      //                                             data.deleteUser(user);
      //                                           }
      //                                       }
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                           );
      //                         }),
      //                   ),
      //                 ],
      //               );
      //             }
      //             else {
      //               return const Text('Empty data');
      //             }
      //           }
      //           else {
      //             return const Center(child:  Text('Add Users to Favorites'));
      //           }}
      //     );
      // }

      // ),
    );
  }
}
