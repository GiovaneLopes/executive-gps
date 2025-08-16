part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeStatus status;
  final int currentTab;
  const HomeState({
    this.status = HomeStatus.initial,
    this.currentTab = 0,
  });

  HomeState copyWith({
    HomeStatus? status,
    int? currentTab,
  }) {
    return HomeState(
      status: status ?? this.status,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object> get props => [status, currentTab];
}
