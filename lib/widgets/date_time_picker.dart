import 'package:bptracker/utils/export.dart';
import 'package:bptracker/widgets/app_card.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
  DateTimePicker({
    Key? key,
    required this.date,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.time,
  }) : super(key: key);

  DateTime date;
  Function(DateTime date) onDateChanged;
  Function(TimeOfDay date) onTimeChanged;
  TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 4,
          offset: Offset(0, 3), // Shadow position
        ),
      ],
    );
    return Column(
      children: [
        Row(
          children: [
            AppTitle(
              txt: "Date & Time",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(.7),
            ),
          ],
        ),
        const SizedBox(height: 10),
        AppCard(
          padding: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    // print("day");
                    DateTime? r = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2200));

                    if (r != null) {
                      onDateChanged(r);
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: decoration,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: AppColors().onBoarding,
                          ),
                          const SizedBox(width: 6),
                          AppTitle(
                            txt: "${date.day}/${date.month}/${date.year}",
                            fontSize: 16,
                            color: Colors.black.withOpacity(.5),
                          )
                        ]),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    TimeOfDay? r = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );

                    if (r != null) {
                      onTimeChanged(r);
                    }
                    debugPrint(r.toString());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: decoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 20,
                          color: AppColors().onBoarding,
                        ),
                        const SizedBox(width: 10),
                        AppTitle(
                          txt: "${time.hour}:${time.minute}:${time.period.name}",
                          fontSize: 17,
                          color: Colors.black.withOpacity(.5),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
