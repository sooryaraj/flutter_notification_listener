

import 'dart:convert';

class NotificationEvent {
  DateTime createAt;
  int timestamp;
  String packageName;
  String title;
  String text;
  String message;
  dynamic extra;

  dynamic _data;

  NotificationEvent({
    this.createAt,
    this.packageName,
    this.title,
    this.text,
    this.message,
    this.timestamp,
    this.extra
  });

  factory NotificationEvent.fromMap(Map<dynamic, dynamic> map) {

    return NotificationEvent(
      createAt: DateTime.now(),
      packageName: map['package_name'],
      title: map['title'],
      text: map['text'],
      message: map["message"],
      timestamp: map["timestamp"],
      extra:map["extra"]
    ).._data = map;
  }

  @override
  String toString() {
      return json.encode(this._data).toString();
  }
}

NotificationEvent newEvent(Map<dynamic, dynamic> data) {
  return NotificationEvent.fromMap(data);
}
