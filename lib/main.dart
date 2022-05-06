import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_listing_demo/core/bloc/cubit/navigation_cubit.dart';
import 'package:github_user_listing_demo/core/utils/network/observer/simple_bloc_observer.dart';
import 'package:github_user_listing_demo/features/user_listing/display/bloc/user_local_listing/bloc/local_listing_bloc.dart';
import 'package:github_user_listing_demo/features/user_listing/display/bloc/user_remote_listing/bloc/listing_bloc.dart';
import 'package:github_user_listing_demo/main/main_page.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListingBloc>(
          create: (BuildContext context) => ListingBloc(const UserState()),
        ),
        BlocProvider<LocalListingBloc>(
          create: (BuildContext context) =>
              LocalListingBloc(LocalListingState.initial()),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
