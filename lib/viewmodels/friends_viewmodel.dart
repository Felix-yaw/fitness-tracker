import '../data/models/friend.dart';
import 'view_model.dart';

/// Backs the Friends screen.
class FriendsViewModel extends ViewModel {
  FriendsViewModel(super.repository);

  /// Friends ordered by how close they are to their weekly goal.
  List<Friend> get friends {
    final List<Friend> list = repository.friends.toList()
      ..sort(
        (Friend a, Friend b) => b.activePercent.compareTo(a.activePercent),
      );
    return list;
  }

  int get activeTodayCount =>
      repository.friends.where((Friend f) => f.isActiveToday).length;

  bool isApplauded(Friend friend) => repository.isApplauded(friend);

  void applaud(Friend friend) => repository.toggleApplaud(friend);
}
