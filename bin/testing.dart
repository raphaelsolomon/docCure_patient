import 'package:intl/intl.dart';

void main(List<String> args) {
//  DateTime now = DateTime.now();
//  DateTime start = now;
//  DateTime after = now.add(Duration(days: 180));

//  DateTime iterator = start;
//  List<Day> day = [];

//  while (iterator.isBefore(after)){
//   day.add(Day(dateTime: iterator));
//   iterator = iterator.add(Duration(days: 1));
//  }

//  print(day.toString());

print(DateFormat().dateSymbols.WEEKDAYS);
}

class Day{
  final DateTime dateTime;
  Day({required this.dateTime});

  String get day => DateFormat('EEEE').format(dateTime);
  String get date => DateFormat('yMMMd').format(dateTime);

  String toString() => '\t{\n\t\t"dayName": "$day", \n\t\t"date": "$date"\n\t}\n';

  Map<String, String> toMap() => {'dayName': day, 'date': date};
}