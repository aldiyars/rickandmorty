part of 'character_cubit.dart';@immutableabstract class CharacterState {}class CharacterInitialState extends CharacterState {}class CharacterSuccesLoadedState extends CharacterState {  CharacterSuccesLoadedState(this.characters);  final List<Character> characters;}class CharacterLoadingState extends CharacterState {  CharacterLoadingState(this.oldCharacters, {this.isFirstFetch = false});  final List<Character> oldCharacters;  final bool isFirstFetch;}class CharacterErrorState extends CharacterState {  CharacterErrorState({this.error});  final Object? error;}