import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ftfl/api/dio_helper.dart';
import 'package:task_ftfl/ui/home/bloc/home_event.dart';
import 'package:task_ftfl/ui/home/bloc/home_state.dart';
import 'package:task_ftfl/ui/home/models/home_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetUsersEvent>(_onGetUsersEvent);
  }

  Future<void> _onGetUsersEvent(final GetUsersEvent event, final Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final response = await DioHelper.getData(url: 'https://randomuser.me/api/?results=20');
      if (response.statusCode == 200) {
        final homeModel = HomeModel.fromJson(response.data as Map<String, dynamic>);
        emit(HomeLoaded(homeModel.results));
      } else {
        emit(HomeError('Failed to fetch data: ${response.statusCode}'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
