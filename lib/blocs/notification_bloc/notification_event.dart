part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class ReceiveNotificationEvent extends NotificationEvent {

  final Event event;
  const ReceiveNotificationEvent(this.event);

  @override
  List<Object?> get props => [event];
}

/*final String id;
  final String medicine;
  final String dose;
  final DateTime date;
  final TimeOfDay time;*/