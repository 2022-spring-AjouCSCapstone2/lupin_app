// [{id: 14, day: tue, startTime: 1200, endTime: 1445, place: 팔410}]}]
enum Day { mon, tue, wed, thu, fri, empty }

class TimeTable {
  TimeTable(this.id, this.day, this.startTime, this.endTime, this.place);

  int id;
  Day day;
  String startTime;
  String endTime;
  String? place;

  factory TimeTable.fromJson(Map<String, dynamic> json) {
    Day day = Day.values.firstWhere(
        (element) => element.toString() == 'Day.' + json['day'].toString(),
        orElse: () => Day.empty);
    return TimeTable(
      json['id'],
      day,
      json['startTime'],
      json['endTime'],
      json['place'],
    );
  }

  @override
  String toString() {
    return 'TimeTable{id: $id, day: $day, startTime: $startTime, endTime: $endTime, place: $place}';
  }
}
