import 'dart:async';

import 'package:electricity_front/core/controllers/booking_controller.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/controllers/list_controller.dart';
import '../../fonts/test_icons_icons.dart';
import '../components/default_header.dart';

class ExpandedStationPage extends StatefulWidget {
  const ExpandedStationPage(
      {Key? key, required this.index, required this.bicing})
      : super(key: key);

  final int index;
  final bool bicing;

  @override
  State<ExpandedStationPage> createState() => _ExpandedStationPageState();
}

class _ExpandedStationPageState extends State<ExpandedStationPage> {
  late ListController listCtrl;
  late Station bicingStation;
  late RechargeStation rechargeStation;

  @override
  void initState() {
    super.initState();
    listCtrl = ListController();
    if (widget.bicing) {
      bicingStation = listCtrl.getBicingStation(widget.index);
    } else {
      rechargeStation = listCtrl.getRechargeStation(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size screensize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(children: [
          Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: screensize.width,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    const SizedBox(height: 112),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                    (widget.bicing)
                                        ? bicingStation.address
                                        : rechargeStation.address,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    height: 60,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: Text(
                                        (widget.bicing)
                                            ? bicingStation.id.toString()
                                            : rechargeStation.id.toString(),
                                        style: const TextStyle(
                                            fontSize: 28,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))))
                          ],
                        )),
                  ]),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: screensize.width / 3,
                          color: Colors.grey[800],
                          disabledColor: Colors.grey[800],
                          child: const Text("Favourite",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  BookingController booking = BookingController();
                                  booking.wipe();

                                  String dateError = '';
                                  String startTimeError = '';
                                  String endTimeError = '';
                                  bool completedBooking = false;

                                  TextEditingController dateinput = TextEditingController();
                                  TextEditingController starttimeinput = TextEditingController();
                                  TextEditingController endtimeinput = TextEditingController();
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text(AppLocalizations.of(context)
                                          .reservation_title),
                                      content: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(children: [
                                            TextField(
                                              controller: dateinput,
                                              decoration: InputDecoration(
                                                  icon: const Icon(
                                                      Icons.calendar_today),
                                                  labelText:
                                                      AppLocalizations.of(
                                                              context)
                                                          .reservation_date),
                                              readOnly: true,
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime.now(),
                                                        lastDate: DateTime.now()
                                                            .add(const Duration(
                                                                days: 60)));

                                                if (pickedDate != null) {
                                                  print(
                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement
                                                  booking.setDate(formattedDate);
                                                  setState(() {
                                                    dateinput.text = formattedDate;
                                                    dateError = "";
                                                  });
                                                } else {
                                                  print("Date is not selected");
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
                                                  print(pickedTime.format(context)); //output 10:51 PM
                                                  DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());

                                                  booking.setStartTime(parsedTime);
                                                  setState(() {
                                                    starttimeinput.text = DateFormat('HH:mm:ss').format(parsedTime);
                                                    startTimeError = "";
                                                  });


                                                } else {
                                                  print("Time is not selected");

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
                                                  print(pickedTime.format(context)); //output 10:51 PM
                                                  DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                  booking.setEndTime(parsedTime);

                                                  setState(() {
                                                    starttimeinput.text = DateFormat('HH:mm:ss').format(parsedTime);
                                                    endTimeError = "";
                                                  });
                                                } else {
                                                  print("Time is not selected");
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
                                                  if (dateError == "" && startTimeError == "" && endTimeError == "") {
                                                    booking.setStationId(
                                                        rechargeStation.id
                                                            .toString());
                                                    if (booking
                                                        .validateDuration()) {
                                                      print("valid");
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
                                            Visibility(
                                              visible: (completedBooking),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16),
                                                child: Text(
                                                  "Booking successful",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green[900]),
                                                ),
                                              ),
                                            ),
                                          ])),
                                    );
                                  });
                                });
                          },
                          minWidth: screensize.width / 3,
                          color: Colors.grey[800],
                          disabledColor: Colors.grey[800],
                          child: const Text("Book a slot",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ])
              ]),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: DefaultHeader(
                size: Size(screensize.width, (screensize.height * 0.15))),
          ),
          Material(
              color: Colors.transparent,
              child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 40),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.white,
                      ))))
        ]));
  }
}
