import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState());

  void changeTab(int index) {
    emit(state.copyWith(currentTab: index));
  }

  void loadHomeData() {
    emit(state.copyWith(status: HomeStatus.loaded));
  }

  void refreshHomeData() {
    emit(state.copyWith());
  }

  void clear() {
    emit(const HomeState());
  }
}
