import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:horarios_phone/api/api.dart';
import 'package:horarios_phone/screens/screens.dart';
import 'package:horarios_phone/widgets/widgets.dart';

import '../models/models.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, this.state});

  final GlobalKey<WeekViewState>? state;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late EventController controller;
  List<CalendarEventData> calendarEvents = [];

  @override
  void initState() {
    super.initState();
    controller = EventController();
    getAulas();
  }

  void getAulas() async {
    List<Aula> aulas = await Api().getAulas();
    calendarEvents = aulas
        .map(
          (aula) => CalendarEventData(
            date: DateTime.utc(int.parse(aula.dia.split("-")[0]) > 6 ? 2024 : 2025, int.parse(aula.dia.split("-")[0]),
                int.parse(aula.dia.split("-")[1])),
            endDate: DateTime.utc(int.parse(aula.dia.split("-")[0]) > 6 ? 2024 : 2025, int.parse(aula.dia.split("-")[0]),
                int.parse(aula.dia.split("-")[1])),
            title: aula.uc,
            description: aula.curso + "\n" + aula.turma,
            startTime: DateTime.utc(
                int.parse(aula.dia.split("-")[0]) > 6 ? 2024 : 2025,
                int.parse(aula.dia.split("-")[0]),
                int.parse(aula.dia.split("-")[1]),
                int.parse(aula.inicio.split(":")[0]),
                int.parse(aula.inicio.split(":")[1]),
                int.parse(aula.inicio.split(":")[2])),
            endTime: DateTime.utc(
                int.parse(aula.dia.split("-")[0]) > 6 ? 2024 : 2025,
                int.parse(aula.dia.split("-")[0]),
                int.parse(aula.dia.split("-")[1]),
                int.parse(aula.fim.split(":")[0]),
                int.parse(aula.fim.split(":")[1]),
                int.parse(aula.fim.split(":")[2])),
            event: aula
          ),
        )
        .toList();
    setState(() {
      controller.addAll(calendarEvents);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: WeekView(
            controller: controller,
            key: widget.state,
            width: MediaQuery.of(context).size.width * 0.9,
            showWeekends: false,
            showLiveTimeLineInAllDays: true,
            eventArranger: const SideEventArranger(),
            timeLineWidth: 65,
            scrollPhysics: const BouncingScrollPhysics(),
            liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
              color: Colors.indigo,
              showTime: true,
            ),
            eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
              return  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                ),
                  child: Text(
                    events.first.title,
                    style: const TextStyle(
                      fontSize: 8, // Change this value to adjust the title size
                      color: Colors.white,
                    ),
                  ),
              );
            },
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
        )
      ],
    );
  }
}