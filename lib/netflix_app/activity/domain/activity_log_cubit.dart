import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_freezed.dart';

class ActivityLogCubit extends Cubit<ActivitySingle> {
  ActivityLogCubit() : super(const ActivitySingle());
  void addSingleActivity(DateTime date, String title) {
    List<String> list = [];
    for (var element in state.addedMovie) {
      list.add(element);
    }
    list.add(title);
    emit(state.copyWith(dateTime: date, addedMovie: list));
  }

  void addSingleReview(DateTime date, String title) {
    List<String> list = [];
    for (var element in state.addedReview) {
      list.add(element);
    }
    list.add(title);
    emit(state.copyWith(dateTime: date, addedReview: list));
  }

  void addSingleTickets(DateTime date, String title) {
    List<String> list = [];
    for (var element in state.addedTickets) {
      list.add(element);
    }
    list.add(title);
    emit(state.copyWith(dateTime: date, addedTickets: list));
  }

  void resetActivity() {
    emit(const ActivitySingle());
  }
}
