import 'package:task_ftfl/ui/home/models/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded(this.profiles);
  final List<ProfileModel> profiles;
}

class HomeError extends HomeState {
  HomeError(this.message);
  final String message;
}
