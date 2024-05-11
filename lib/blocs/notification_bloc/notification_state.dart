part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final List<Event> events;

  const NotificationState({this.events = const []});

  NotificationState copyWith({List<Event>? events}){
    return NotificationState(events: events ?? this.events);
  }

  @override
  List<Object?> get props => [events];
}

/*
class NotificationState extends Equatable{
  const NotificationState();

  @override
  List<Object> get props => [];
}
*/

/*class StartUpNotificationState extends NotificationState {}

class IndexedNotification extends NotificationState {
  final int index;

  IndexedNotification(this.index);

  @override
  List<Object> get props => [this.index];

  @override
  bool operator == (Object other) => false;

  @override
  int get hashCode => super.hashCode;
}*/

