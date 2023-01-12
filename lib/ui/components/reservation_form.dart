// ignore_for_file: use_build_context_synchronously

import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../../core/controllers/booking_controller.dart';
import '../../core/services/notifications.dart';


class ReservationForm extends StatefulWidget {

  const ReservationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  late BookingController booking;

  String dateError = '';
  String startTimeError = '';
  String endTimeError = '';
  bool completedBooking = false;

  TextEditingController dateinput = TextEditingController();
  TextEditingController starttimeinput = TextEditingController();
  TextEditingController endtimeinput = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    booking = BookingController();

  }


  @override
  Widget build(BuildContext context) {
    CosmeticsController cosmeticsController = CosmeticsController();
    if (completedBooking){
      return AlertDialog(
        content: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                AppLocalizations.of(context).booking_successful,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(cosmeticsController.getCurrentTheme().accentcoloralt)),
              ),
            )
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Center(
              child: Container(
                color: Color(cosmeticsController.getCurrentTheme().accentcolor),
                padding: const EdgeInsets.all(14),
                child: Text(
                  AppLocalizations.of(context).booking_close,
                  style: TextStyle(
                      color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      );

    }
    else {
      return AlertDialog(
        title: Text(AppLocalizations
            .of(context)
            .reservation_title),
        content: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                children: [
                  TextField(
                    controller: dateinput,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        labelText: AppLocalizations
                            .of(context)
                            .reservation_date),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate =
                      await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(hours: 24)));

                      if (pickedDate != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate);
                        //print(formattedDate);
                        booking.setDate(formattedDate);

                        setState(() {
                          dateinput.text = formattedDate;
                          dateError = "";
                        });
                      } else {
                        //print("Date is not selected");
                        setState(() {
                          dateError = AppLocalizations.of(context).booking_dateempty;
                        });
                      }
                    },
                  ),
                  Visibility(
                    visible: (dateError != ''),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8),
                      child: Text(
                        dateError,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(cosmeticsController.getCurrentTheme().elementcolordelete)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: starttimeinput,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.timer),
                        //icon of text field
                        labelText: AppLocalizations
                            .of(context)
                            .reservation_starttime //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime =
                      await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        DateTime parsedTime = DateFormat("HH:mm").parse(
                            pickedTime.format(context).toString());

                        booking.setStartTime(parsedTime);
                        setState(() {
                          starttimeinput.text =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          startTimeError = "";
                        });
                      } else {
                        //print("Time is not selected");

                        setState(() {
                          startTimeError = AppLocalizations.of(context).booking_starttimeempty;
                        });
                      }
                    },
                  ),
                  Visibility(
                    visible: (startTimeError != ''),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8),
                      child: Text(
                        startTimeError,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(cosmeticsController.getCurrentTheme().elementcolordelete)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: endtimeinput,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.timer),
                        //icon of text field
                        labelText: AppLocalizations
                            .of(context)
                            .reservation_endtime //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime =
                      await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        //print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat("HH:mm").parse(
                            pickedTime.format(context).toString());
                        booking.setEndTime(parsedTime);

                        setState(() {
                          endtimeinput.text =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          endTimeError = "";
                        });
                      } else {
                        //print("Time is not selected");
                        setState(() {
                          endTimeError = AppLocalizations.of(context).booking_endtimeempty;
                        });
                      }
                    },
                  ),
                  Visibility(
                    visible: (endTimeError != ''),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8),
                      child: Text(
                        endTimeError,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(cosmeticsController.getCurrentTheme().elementcolordelete)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        if (dateError == "" && startTimeError == "" &&
                            endTimeError == "") {
                          if (booking.validateDuration()) {
                            //print("valid");
                            //booking.mockSuccess();
                            //completedBooking = true;

                            Future<bool> success = booking.tryBooking(context);
                            if (await success) {
                              completedBooking = true;
                              Notifications.showSchedueleNotification(
                                  title: AppLocalizations.of(context).notification_booking_title,
                                  body: AppLocalizations.of(context).notification_booking_body1 + BookingController().gettStationId() + AppLocalizations.of(context).notification_booking_body2,
                                  seconds: 2,
                                  fln: flutterLocalNotificationsPlugin);

                            }


                          }

                          setState(() {
                            dateError =
                                booking.dateError();
                            startTimeError =
                                booking.timeError();
                            endTimeError =
                                booking.timeError();
                          });
                        }
                      },
                      child: Container(
                        color: Color(cosmeticsController.getCurrentTheme().accentcolor),
                        padding:
                        const EdgeInsets.all(14),
                        child: Text(
                          AppLocalizations.of(context).booking_request,
                          style: TextStyle(
                              color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                              fontSize: 20,
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ])),
      );
    }
  }
}
