import 'package:electricity_front/ui/components/default_header.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/models/user.dart';
import '../../core/controllers/user_controller.dart';
import '../components/personal_ubi_preview.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController userCtrl = UserController();
  bool visiblePersonalList = false;
  bool visibleFavouriteList = false;

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: DefaultHeader(
            size: Size(screensize.width, (screensize.height * 0.15))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height:20),
              Container(
                  height: 100,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(userCtrl.currentUser.username,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 20),
                      Icon(Icons.account_circle, size: 60, color: Colors.white)
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(children: [
                    const SizedBox(height: 20),

                    // PERSONAL LOCATIONS
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          const BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  if (visiblePersonalList) {
                                    visiblePersonalList = false;
                                  } else {
                                    visiblePersonalList = true;
                                  }
                                });
                              },
                              child: Row(children: [
                                const Text(
                                  'Personal locations',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: SizedBox(height: 20)),
                                Builder(builder: (context) {
                                  if (visiblePersonalList) {
                                    return const Icon(Icons.keyboard_arrow_up,
                                        size: 28, color: Colors.white);
                                  } else {
                                    return const Icon(Icons.keyboard_arrow_down,
                                        size: 28, color: Colors.white);
                                  }
                                }),
                              ])),
                          Visibility(
                              visible: visiblePersonalList,
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                  ),

                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:  Builder(builder: (context) {
                                            return ListaPersonalUbi();
                                          }),
                                      )

                              )
                          )
                        ]
                      )
                    ),


                    const SizedBox(height: 40),

                    // FAVOURITE STATIONS
                    Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            const BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  if (visibleFavouriteList) {
                                    visibleFavouriteList = false;
                                  } else {
                                    visibleFavouriteList = true;
                                  }
                                });
                              },
                              child: Row(children: [
                                const Text(
                                  'Favourite stations',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: SizedBox(height: 20)),
                                Builder(builder: (context) {
                                  if (visibleFavouriteList) {
                                    return const Icon(Icons.keyboard_arrow_up,
                                        size: 28, color: Colors.white);
                                  } else {
                                    return const Icon(Icons.keyboard_arrow_down,
                                        size: 28, color: Colors.white);
                                  }
                                }),
                              ])),
                          Visibility(
                              visible: visibleFavouriteList,
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: Column(children: [
                                    SizedBox(height: 60),
                                    Text('Fav stations go here')
                                  ]))),
                        ])),

                    const SizedBox(height: 40),

                    Row(children: [
                      Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: [
                                    const BoxShadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    userCtrl.logOut(context);
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Log Out',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 16),
                                        Icon(Icons.close,
                                            size: 28, color: Colors.white)
                                      ]),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: [
                                    const BoxShadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Delete Account"),
                                        content: const Text(
                                            "Are you sure you want to delete your account?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(ctx).pop();
                                              await userCtrl.deleteUser();
                                              userCtrl.logOut(context);
                                            },
                                            child: Container(
                                              color: Colors.green,
                                              padding: const EdgeInsets.all(14),
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Delete Account',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 16),
                                        Icon(Icons.delete_forever,
                                            size: 28, color: Colors.white)
                                      ]),
                                ),
                              ),
                            ],
                          )),
                      Expanded(flex: 4, child: const SizedBox())
                    ]),
                  ])
                  /*Expanded(
                    child: Visibility(
                      visible: visiblePersonalList,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userCtrl.currentUser.personalUbiBD.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 200,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),*/

                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget ListaPersonalUbi() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userCtrl.currentUser.personalUbiBD.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  const BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            key: ValueKey<Marker>(userCtrl.currentUser.personalUbi[index]),
            onDismissed: (DismissDirection direction) {
              setState(() {
                userCtrl.currentUser.deletePersonalUbi(index);
              });
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
                child: PersonalUbiPreview(
                    info: userCtrl.currentUser.personalUbi.elementAt(index))),
          );
        });
  }

  Widget ListaPersonalUbi2() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: userCtrl.currentUser.testlist.length, //userCtrl.currentUser.personalUbiBD.length,
        itemBuilder: (context, index) {
            return Padding(
                key: UniqueKey(),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      //userCtrl.currentUser.personalUbi.elementAt(index).infoWindow.title.toString(),
                      'Personal location ${index+1} = ${userCtrl.currentUser.testlist.elementAt(index)}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Expanded( child: SizedBox()),
                    IconButton(onPressed: (){
                      userCtrl.currentUser.testlist.removeAt(index);
                      Navigator.of(context).build(context);

                    }, icon: const Icon(Icons.delete, size: 24, color: Colors.black ))
                  ],
                )

            );
        });
  }
}
