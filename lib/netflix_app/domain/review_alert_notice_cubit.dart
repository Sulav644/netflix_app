import 'package:flutter_bloc/flutter_bloc.dart';

class ShowReviewNoticeCubit extends Cubit<bool> {
  ShowReviewNoticeCubit() : super(false);
  void toggleReviewState(bool status) {
    emit(status);
  }
}
