import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class WeekViewWidget extends StatelessWidget {
  final GlobalKey<WeekViewState>? state;
  final double? width;
  final EventController<CalendarEventData> controller;

  const WeekViewWidget({super.key, this.state, this.width, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: WeekView(
        controller: controller,
        key: state,
        showWeekends: false,
        showLiveTimeLineInAllDays: true,
        eventArranger: const SideEventArranger(),
        timeLineWidth: 65,
        scrollPhysics: const BouncingScrollPhysics(),
        liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
          color: Colors.indigo,
          showTime: true,
        ),
        eventTileBuilder: (date, events, boundary, startDuration, endDuration) => SizedBox(width: 100,),
        onTimestampTap: (date) {
          SnackBar snackBar = SnackBar(
            content: Text("On tap: ${date.hour} Hr : ${date.minute} Min"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onEventTap: (events, date) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetailsScreen(
                event: events.first,
                date: date,
              ),
            ),
          );
        },
        onEventLongTap: (events, date) {
          SnackBar snackBar = SnackBar(content: Text("on LongTap"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
