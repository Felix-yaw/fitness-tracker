import 'package:fitness_tracker/data/models/activity.dart';
import 'package:fitness_tracker/data/models/activity_type.dart';
import 'package:fitness_tracker/data/repositories/fitness_repository.dart';
import 'package:fitness_tracker/main.dart';
import 'package:fitness_tracker/viewmodels/add_activity_viewmodel.dart';
import 'package:fitness_tracker/viewmodels/friends_viewmodel.dart';
import 'package:fitness_tracker/viewmodels/home_viewmodel.dart';
import 'package:fitness_tracker/viewmodels/stats_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FitnessRepository', () {
    test('starts with seeded activities and friends', () {
      final FitnessRepository repo = FitnessRepository();
      expect(repo.activities, isNotEmpty);
      expect(repo.friends, isNotEmpty);
    });

    test('adds and removes activities', () {
      final FitnessRepository repo = FitnessRepository(
        activities: <Activity>[],
      );
      repo.addActivity(
        Activity(
          id: 'x',
          title: 'Test',
          type: ActivityType.run,
          date: DateTime.now(),
          duration: const Duration(minutes: 20),
        ),
      );
      expect(repo.activities.length, 1);
      repo.removeActivity('x');
      expect(repo.activities, isEmpty);
    });

    test('toggles applaud', () {
      final FitnessRepository repo = FitnessRepository();
      final friend = repo.friends.first;
      expect(repo.isApplauded(friend), isFalse);
      repo.toggleApplaud(friend);
      expect(repo.isApplauded(friend), isTrue);
      repo.toggleApplaud(friend);
      expect(repo.isApplauded(friend), isFalse);
    });
  });

  group('ViewModels', () {
    test('home exposes derived dashboard figures', () {
      final HomeViewModel vm = HomeViewModel(FitnessRepository());
      expect(vm.userName, 'Miranda');
      expect(vm.todaySteps, greaterThan(0));
      expect(vm.todayDistance, greaterThan(0));
      expect(vm.todayCalories, greaterThan(0));
      expect(vm.last7DaySteps.length, 7);
      expect(vm.weeklyPercent, inInclusiveRange(0, 1));
    });

    test('stats weekly bars and intensity', () {
      final StatsViewModel vm = StatsViewModel(FitnessRepository());
      expect(vm.weeklyBars.length, 7);
      expect(vm.weeklyValueLabels.length, 7);
      expect(vm.intensity, inInclusiveRange(0, 1));
      expect(vm.weather.city, isNotEmpty);
    });

    test('friends are ranked and applaudable', () {
      final FriendsViewModel vm = FriendsViewModel(FitnessRepository());
      final friends = vm.friends;
      expect(friends.length, greaterThan(1));
      for (int i = 1; i < friends.length; i++) {
        expect(
          friends[i - 1].activePercent >= friends[i].activePercent,
          isTrue,
        );
      }
      vm.applaud(friends.first);
      expect(vm.isApplauded(friends.first), isTrue);
    });
  });

  group('AddActivityViewModel', () {
    test('validates and saves', () {
      final FitnessRepository repo = FitnessRepository(activities: <Activity>[]);
      final vm = AddActivityViewModel(repo);
      expect(vm.isValid, isFalse);
      vm.setTitle('Evening run');
      expect(vm.isValid, isTrue);
      expect(vm.save(), isTrue);
      expect(repo.activities.length, 1);
    });
  });

  testWidgets('app renders the dashboard', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FitnessTrackerApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Miranda', findRichText: true), findsWidgets);
    expect(find.text('Activity'), findsOneWidget);
    expect(find.text('Weekly goal'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('every bottom-nav destination renders', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FitnessTrackerApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.insights_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Statistics'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.groups_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Friends'), findsWidgets);

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('miranda@example.com'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pumpAndSettle();
    expect(find.textContaining('Miranda', findRichText: true), findsWidgets);

    expect(tester.takeException(), isNull);
  });

  testWidgets('the + action opens the Log activity screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FitnessTrackerApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Log activity'), findsOneWidget);
    expect(find.text('Activity title'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
