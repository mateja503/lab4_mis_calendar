import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final LatLng location;

  Event({required this.name, required this.startTime, required this.endTime, required this.location});

  @override
  String toString() {
    return '$name\n'
        'Од: ${startTime.toLocal().hour}:${startTime.toLocal().minute == 0 ? '00' : startTime.toLocal().minute}\n'
        'До: ${endTime.toLocal().hour}:${endTime.toLocal().minute == 0 ? '00' : endTime.toLocal().minute}';
  }
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
  DateTime(2025, 1, 13): [
    Event(
      name: "Стуктурно прогамирање",
      startTime: DateTime(2025, 1, 13, 8, 0),
      endTime: DateTime(2025, 1, 13, 15, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Анализа и Дизајн на ИС",
      startTime: DateTime(2025, 1, 13, 11, 0),
      endTime: DateTime(2025, 1, 13, 12, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Интернет Програмирање/Интернет Програмирање на килентска страна",
      startTime: DateTime(2025, 1, 13, 16, 30),
      endTime: DateTime(2025, 1, 13, 20, 0),
      location: LatLng(42.004239, 21.409299),
    ),
  ],
  DateTime(2025, 1, 14): [
    Event(
      name: "Интерактивни апликации/Шаблони за дизајн на кориснички интерфејси",
      startTime: DateTime(2025, 1, 14, 8, 0),
      endTime: DateTime(2025, 1, 14, 12, 0),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Дизајн на дигитални кола",
      startTime: DateTime(2025, 1, 14, 8, 0),
      endTime: DateTime(2025, 1, 14, 10, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Дистрибуирани системи",
      startTime: DateTime(2025, 1, 14, 11, 0),
      endTime: DateTime(2025, 1, 14, 12, 0),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Дизајн и архитектура на софтвер",
      startTime: DateTime(2025, 1, 14, 15, 0),
      endTime: DateTime(2025, 1, 14, 16, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Програмирање на видео игри",
      startTime: DateTime(2025, 1, 14, 17, 0),
      endTime: DateTime(2025, 1, 14, 20, 30),
      location: LatLng(42.004239, 21.409299),
    ),
  ],
  DateTime(2025, 1, 15): [
    Event(
      name: "Бази на податоци",
      startTime: DateTime(2025, 1, 15, 8, 0),
      endTime: DateTime(2025, 1, 15, 15, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Бизниз и менаџмент",
      startTime: DateTime(2025, 1, 15, 16, 0),
      endTime: DateTime(2025, 1, 15, 17, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Управување со техничка подршка",
      startTime: DateTime(2025, 1, 15, 18, 0),
      endTime: DateTime(2025, 1, 15, 20, 30),
      location: LatLng(42.004239, 21.409299),
    ),
  ],
  DateTime(2025, 1, 16): [
    Event(
      name: "Дискретна Математика",
      startTime: DateTime(2025, 1, 16, 8, 0),
      endTime: DateTime(2025, 1, 16, 13, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Напредно програмирање",
      startTime: DateTime(2025, 1, 16, 16, 0),
      endTime: DateTime(2025, 1, 16, 18, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Економија за ИКТ инжинери",
      startTime: DateTime(2025, 1, 16, 19, 0),
      endTime: DateTime(2025, 1, 16, 20, 30),
      location: LatLng(42.004239, 21.409299),
    ),
  ],
  DateTime(2025, 1, 17): [
    Event(
      name: "Алгоритми и податочни структури",
      startTime: DateTime(2025, 1, 17, 8, 0),
      endTime: DateTime(2025, 1, 17, 13, 0),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Алгоритми и податочни структури",
      startTime: DateTime(2025, 1, 17, 14, 0),
      endTime: DateTime(2025, 1, 17, 20, 30),
      location: LatLng(42.004239, 21.409299),
    ),
  ],
  DateTime(2025, 1, 20): [
    Event(
      name: "Компјутерски мрежи и безбедност",
      startTime: DateTime(2025, 1, 20, 8, 0),
      endTime: DateTime(2025, 1, 20, 11, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Компјутерски мрежи",
      startTime: DateTime(2025, 1, 20, 12, 0),
      endTime: DateTime(2025, 1, 20, 14, 30),
      location: LatLng(42.004239, 21.409299),
    ),
    Event(
      name: "Вовед во наука за податоци",
      startTime: DateTime(2025, 1, 20, 15, 0),
      endTime: DateTime(2025, 1, 20, 19, 0),
      location: LatLng(42.004239, 21.409299),
    ),
  ],
  DateTime(2025, 1, 21): [
    Event(
      name: "Вовед во информатика",
      startTime: DateTime(2025, 1, 21, 8, 0),
      endTime: DateTime(2025, 1, 21, 14, 30),
      location: LatLng(42.004239, 21.409299),
    ),

  ],
});



final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
          (index) => Event(
        name: 'Event $item | ${index + 1}',
        startTime: DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5, 10),
        endTime: DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5, 12),
        location: LatLng(37.7749, -122.4194), // Example location
      ),
    ),
}..addAll({
  kToday: [
  //   Event(
  //     name: "Today's Event 1",
  //     startTime: DateTime.now(),
  //     endTime: DateTime.now().add(Duration(hours: 1)),
  //     location: LatLng(37.7749, -122.4194), // Example location
  //   ),
  //   Event(
  //     name: "Today's Event 2",
  //     startTime: DateTime.now().add(Duration(hours: 2)),
  //     endTime: DateTime.now().add(Duration(hours: 3)),
  //     location: LatLng(34.0522, -118.2437), // Example location
  //   ),
   ],
});


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);