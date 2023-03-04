import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_freezed.freezed.dart';

final dateTime = DateTime.now();

@freezed
class ActivityFreezed with _$ActivityFreezed {
  const ActivityFreezed._();
  const factory ActivityFreezed({
    @Default([]) List<ActivitySingle> activity,
  }) = _ActivityFreezed;
}

@freezed
class ActivitySingle with _$ActivitySingle {
  const ActivitySingle._();
  const factory ActivitySingle(
      {DateTime? dateTime,
      @Default([]) List<String> addedMovie,
      @Default([]) List<String> addedReview,
      @Default([]) List<String> addedTickets}) = _ActivitySingle;
}
