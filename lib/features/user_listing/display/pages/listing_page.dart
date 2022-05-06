import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_listing_demo/features/user_listing/display/bloc/user_local_listing/bloc/local_listing_bloc.dart';
import 'package:github_user_listing_demo/features/user_listing/display/bloc/user_remote_listing/bloc/listing_bloc.dart';

class UserListing extends StatefulWidget {
  const UserListing({Key? key}) : super(key: key);

  @override
  _UserListingState createState() => _UserListingState();
}

class _UserListingState extends State<UserListing> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ListingBloc>(context, listen: false).add(UserFetched());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<ListingBloc>(context, listen: false).add(UserFetched());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListingBloc, UserState>(
        builder: (context, state) {
          switch (state.status) {
            case UserStatus.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Error message"),
                    IconButton(
                        onPressed: () {
                          // Provider.of<UserProvider>(context, listen: false).fetchUsers();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
              );

            case UserStatus.success:
              if (state.users.isEmpty) {
                return const Center(child: Text('no users'));
              }

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    var user = state.users[index];
                    return index >= state.users.length
                        ? const BottomLoader()
                        : Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        // Border width
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle),
                                        child: ClipOval(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(40),
                                            // Image radius
                                            child: CachedNetworkImage(
                                              imageUrl: user.avatar,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text(
                                          user.name,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                  Checkbox(
                                      value: user.isSelected,
                                      onChanged: (value) {
                                        if (value == true) {
                                          user.isSelected = true;

                                          BlocProvider.of<LocalListingBloc>(
                                                  context,
                                                  listen: false)
                                              .add(UserSaveEvent(user));
                                        } else {
                                          user.isSelected = false;
                                        }

                                        BlocProvider.of<ListingBloc>(context,
                                                listen: false)
                                            .add(UserUpdated(user));
                                      }),
                                ],
                              ),
                            ),
                          );
                  });

            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
