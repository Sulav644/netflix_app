import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_freezed.dart';

class ActivityLogListCubit extends Cubit<List<ActivitySingle>> {
  ActivityLogListCubit() : super([]);

  void removeActivity(String movieTitle, DateTime dateTime) {
    List<String> list = [];
    if (dateTime.difference(state[0].dateTime!).inSeconds < 60) {
      for (var element in state[0].addedMovie) {
        if (element != movieTitle) {
          list.add(element);
        }
      }
      ActivitySingle listWithoutRemovedItem =
          state[0].copyWith(addedMovie: list);
      int index = state.indexOf(state[0]);
      List<ActivitySingle> newList = [];
      newList.add(listWithoutRemovedItem);
      for (var element in state) {
        if (state.indexOf(element) != index) {
          newList.add(element);
        }
      }
      emit([...newList]);
      refineList();
    }
  }

  void addActivity(ActivitySingle movie) {
    if (state.isNotEmpty) {
      List<String> list = [];

      for (var element in state[0].addedMovie) {
        list.add(element);
      }

      list.add(movie.addedMovie[0]);
      DateTime dt1 = DateTime.parse(movie.dateTime.toString());
      DateTime dt2 = DateTime.parse(state[0].dateTime.toString());
      Duration difference = dt1.difference(dt2);

      if (difference.inMinutes >= 1) {
        emit([movie, ...state]);
      } else {
        ActivitySingle oldActivity = state[0].copyWith(addedMovie: list);
        int index = state.indexOf(state[0]);

        List<ActivitySingle> newActivityList = [];
        newActivityList.add(oldActivity);
        for (var element in state) {
          if (state.indexOf(element) != index) {
            newActivityList.add(element);
          }
        }
        emit([...newActivityList]);
      }
    } else if (state.isEmpty) {
      emit([movie, ...state]);
    }
  }

  void addReview(ActivitySingle movie) {
    if (state.isNotEmpty) {
      List<String> list = [];

      for (var element in state[0].addedReview) {
        list.add(element);
      }

      list.add(movie.addedReview[0]);
      DateTime dt1 = DateTime.parse(movie.dateTime.toString());
      DateTime dt2 = DateTime.parse(state[0].dateTime.toString());
      Duration difference = dt1.difference(dt2);

      if (difference.inMinutes >= 1) {
        emit([movie, ...state]);
      } else {
        ActivitySingle oldActivity = state[0].copyWith(addedReview: list);
        int index = state.indexOf(state[0]);

        List<ActivitySingle> newActivityList = [];
        newActivityList.add(oldActivity);
        for (var element in state) {
          if (state.indexOf(element) != index) {
            newActivityList.add(element);
          }
        }
        emit([...newActivityList]);
      }
    } else if (state.isEmpty) {
      emit([movie, ...state]);
    }
  }

  void addTickets(ActivitySingle movie) {
    if (state.isNotEmpty) {
      List<String> list = [];

      for (var element in state[0].addedTickets) {
        list.add(element);
      }

      list.add(movie.addedTickets[0]);
      DateTime dt1 = DateTime.parse(movie.dateTime.toString());
      DateTime dt2 = DateTime.parse(state[0].dateTime.toString());
      Duration difference = dt1.difference(dt2);

      if (difference.inMinutes >= 1) {
        emit([movie, ...state]);
      } else {
        ActivitySingle oldActivity = state[0].copyWith(addedTickets: list);
        int index = state.indexOf(state[0]);

        List<ActivitySingle> newActivityList = [];
        newActivityList.add(oldActivity);
        for (var element in state) {
          if (state.indexOf(element) != index) {
            newActivityList.add(element);
          }
        }
        emit([...newActivityList]);
      }
    } else if (state.isEmpty) {
      emit([movie, ...state]);
    }
  }

  void refineList() {
    List<ActivitySingle> listToFilter = [];
    for (var element in state) {
      if (element.addedMovie.isNotEmpty ||
          element.addedReview.isNotEmpty ||
          element.addedTickets.isNotEmpty) {
        listToFilter.add(element);
      }
    }
    emit([...listToFilter]);
  }
}
