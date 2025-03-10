# flutter_notification_listener

Flutter Plugin to listen to all incoming notifications for Android.

> :warning: This plugin is Android only.

### Features

- **Service**: start a service to listen the notifications.
- **Easy**: you can get the notifaction fields: `timestamp`, `title`, `message` and `package`.

**Note:** If have any fields to add, feel free to pull request.

### Get Start

**1. Register the service in the manifest**

The plugin uses an Android system service to track notifications. To allow this service to run on your application, the following code should be put inside the Android manifest, between the tags.

```xml
<service android:name="im.zoe.labs.flutter_notification_listener.NotificationsHandlerService"
    android:label="Flutter Notifications Handler"
    android:permission="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE">
    <intent-filter>
        <action android:name="android.service.notification.NotificationListenerService" />
    </intent-filter>
</service>
```

If you want to start the service after reboot, also should put the following code.

```xml
<receiver android:name="im.zoe.labs.flutter_notification_listener.RebootBroadcastReceiver"
    android:enabled="true">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED" />
    </intent-filter>
</receiver>
```

**2. Init the plugin and add listen handelr**

```dart
Future<void> initPlatformState() async {
    NotificationsListener.initialize();
    NotificationsListener.receivePort.listen((evt) => onData(evt));
}

void onData(NotificationEvent event) {
    print(event.toString());
}
```

**3. Check permission and start the service**


```dart
void startListening() async {
    print("start listening");
    var hasPermission = await NotificationsListener.hasPermission;
    if (!hasPermission) {
        print("no permission, so open settings");
        NotificationsListener.openPermissionSettings();
        return;
    }

    var isR = await NotificationsListener.isRunning;

    if (!isR) {
        await NotificationsListener.startService();
    }

    setState(() => started = true);
}
```

Please check the [./example/lib/main.dart](./example/lib/main.dart) for more detail.

### APIs

**NotificationsListener** static methods or fields.

- **hasPermission()**: check if we have grant the listen notifaction permission.
- **openPermissionSettings()**: open the system listen notifactoin permission setting page.
- **initialize()**: int the service, this should be called at first.
- **isRunning**: check if the service is already running.
- **startService()**: start the listening service.
- **stopService()**: stop the listening service.
- **registerEventHandle(Function callback)**:  register the event handler.

