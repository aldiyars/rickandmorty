import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:rickandmorty/presenter/character/cubit/character_cubit.dart';
import 'package:rickandmorty/presenter/character/view/characters_list_view.dart';
import 'package:rickandmorty/presenter/character_detail/cubit/character_detail_cubit.dart';

import 'data/rest_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RestClient(
            dio..interceptors.add(LogInterceptor(requestBody: true, responseBody: true)),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CharacterCubit(RepositoryProvider.of<RestClient>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Rickandmorty Api',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: BlocProvider(
            create: (context) => CharacterCubit(RepositoryProvider.of<RestClient>(context)),
            child: CharactersView(),
          ),
        ),
      ),
    );
  }
}
