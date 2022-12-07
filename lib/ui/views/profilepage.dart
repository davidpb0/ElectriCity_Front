import 'package:electricity_front/ui/components/default_header.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/user_controller.dart';
import '../components/personal_ubi_preview.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
      color: Colors.grey[300],
      home: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
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
                    SizedBox(height: screensize.height * 0.18),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: Text(userCtrl.currentUser.username,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Icon(Icons.account_circle,
                                size: 60, color: Colors.white
                            )
                          ],
                        )
                    ),
                  ])
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(children: [
                    const SizedBox(height: 20),

                    // PERSONAL LOCATIONS
                    Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(children: [
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
                                const Expanded(child: SizedBox(height: 20)),
                                Builder(builder: (context) {
                                  if (visiblePersonalList) {
                                    return const Icon(Icons.keyboard_arrow_up,
                                        size: 28, color: Colors.white);
                                  } else {
                                    return const Icon(Icons.keyboard_arrow_down,
                                        size: 28, color: Colors.white);
                                  }
                                }),
                              ])
                          ),
                          Visibility(
                              visible: visiblePersonalList,
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(builder: (context) {
                                      return listaPersonalUbi();
                                    }),
                                  )
                              )
                          )
                        ])
                    ),

                    const SizedBox(height: 40),

                    // FAVOURITE STATIONS
                    Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
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
                                const Expanded(child: SizedBox(height: 20)),
                                Builder(builder: (context) {
                                  if (visibleFavouriteList) {
                                    return const Icon(Icons.keyboard_arrow_up,
                                        size: 28, color: Colors.white);
                                  } else {
                                    return const Icon(Icons.keyboard_arrow_down,
                                        size: 28, color: Colors.white);
                                  }
                                }),
                              ])
                          ),
                          Visibility(
                              visible: visibleFavouriteList,
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(builder: (context) {
                                      return listaFavStations();
                                    }),
                                  )
                              )
                          ),
                        ])
                    ),

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
                                  boxShadow: const [
                                    BoxShadow(
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
                                  boxShadow: const [
                                    BoxShadow(
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
                                              logout(context);
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
                      const Expanded(flex: 4, child: SizedBox())
                    ]),
                  ])
              )
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: DefaultHeader(
              size: Size(screensize.width, (screensize.height * 0.15))),
        )
      ]),
    );
  }

  Widget listaFavStations() {
    return const Material(
        color: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "No favourite stations found",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )
        )
    );
  }

  Widget listaPersonalUbi() {
    if (userCtrl.currentUser.personalUbi.isEmpty) {
      return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Material(
              color: Colors.transparent,
              child: Text(
                "No personal locations found",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
          )
      );
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userCtrl.currentUser.personalUbi.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
                padding: const EdgeInsets.all(20),
                child: Row(children: const [
                  Icon(
                    Icons.delete_forever,
                    size: 60,
                    color: Colors.red,
                    textDirection: TextDirection.ltr,
                  ),
                  Expanded(child: SizedBox())
                ])),
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) async {
              await userCtrl.deletePersonalUbiEveryWhere(index);
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
                child: PersonalUbiPreview(
                    info: userCtrl.currentUser.personalUbi.elementAt(index)
                )
            ),
          );
        });
  }

  Widget listaPersonalUbi2() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userCtrl.currentUser.personalUbi.length,
        itemBuilder: (context, index) {
          return Padding(
              key: UniqueKey(),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    userCtrl.currentUser.personalUbi
                        .elementAt(index)
                        .infoWindow
                        .title
                        .toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {
                        userCtrl.currentUser.personalUbi.removeAt(index);
                        Navigator.of(context).build(context);
                      },
                      icon: const Icon(Icons.delete,
                          size: 24, color: Colors.black))
                ],
              )
          );
        });
  }

  void logout(BuildContext context) async {
    await userCtrl.deleteUser();
    if (!mounted) return;
    userCtrl.logOut(context);
  }

  void delete(int index) async {
    await userCtrl.deletePersonalUbiEveryWhere(index);
  }
}
