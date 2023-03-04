import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/buy_tickets_components.dart';

class BuyTicketsCubit extends Cubit<List<List<int>>> {
  BuyTicketsCubit() : super([]);
  void addSitting(List<int> index) {
    if (index[0] == 100 || index[0] == 200) {
      index.add(price[0]);
    } else if (index[0] >= 300 && index[0] < 400) {
      index.add(price[1]);
    } else if (index[0] >= 400) {
      index.add(price[2]);
    }
    emit([index, ...state]);
  }

  void removeSitting(List<int> index) {
    state.removeWhere(
        (element) => element[0] == index[0] && element[1] == index[1]);
    emit([...state]);
  }

  void resetSitting() {
    emit([]);
  }
}
