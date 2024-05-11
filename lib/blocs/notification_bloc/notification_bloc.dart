import 'package:bloc/bloc.dart';
import 'package:bloc_notification/bloc_notification.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medipal/pages/Notification/localNotification.dart';
import 'package:meta/meta.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:uuid/uuid.dart';

part 'notification_event.dart';
part 'notification_state.dart';

abstract class MyNotifications {}

class UpdateNotificationPageIndex extends MyNotifications {}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState>
    with BlocNotificationMixin<NotificationState, MyNotifications> {
  NotificationBloc() : super(NotificationState()) {
    on<ReceiveNotificationEvent>((event, emit) {
      // Add new reminder to the list
      final updatedEvents = List<Event>.from(state.events)..add(event.event);
      emit(state.copyWith(events: updatedEvents));

      // Notify the UI to update the notification page
      notify(UpdateNotificationPageIndex());

    });
  }

}
