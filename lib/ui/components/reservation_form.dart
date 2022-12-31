import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/controllers/booking_controller.dart';


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

  @override
  void initState() {
    super.initState();
    booking = BookingController();

  }


  @override
  Widget build(BuildContext context) {
    if (completedBooking){
      return AlertDialog(
        content: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "Booking successful",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900]),
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
                color: Colors.green,
                padding: const EdgeInsets.all(14),
                child: const Text(
                  "Close",
                  style: TextStyle(
                      color: Colors.white,
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
                          dateError = "Please select a date";
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
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red),
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
                        DateTime parsedTime = DateFormat.jm().parse(
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
                          startTimeError = "Please select a starting time";
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
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red),
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
                        DateTime parsedTime = DateFormat.jm().parse(
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
                          endTimeError = "Please select an ending time";
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
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red),
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
                        color: Colors.green,
                        padding:
                        const EdgeInsets.all(14),
                        child: const Text(
                          "Request booking",
                          style: TextStyle(
                              color: Colors.white,
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
