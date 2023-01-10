import 'package:electricity_front/core/controllers/station_controller.dart';
import 'package:electricity_front/ui/components/bicing_preview.dart';
import 'package:electricity_front/ui/components/default_header.dart';
import 'package:electricity_front/ui/views/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/controllers/user_controller.dart';
import '../components/personal_ubi_preview.dart';
import '../components/recharge_preview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/social_button.dart';

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
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      title: "Profile",
      color: Colors.grey[300],
      home: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: screenSize.width,
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
                    SizedBox(height: screenSize.height * 0.18),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: Text(userCtrl.currentUser.getUsername(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 20),
                            const Icon(Icons.account_circle,
                                size: 60, color: Colors.white)
                          ],
                        )),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditProfile(
                                    notifyParent: refresh,
                                  )));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context).editprofile_text,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.edit,
                                  size: 28, color: Colors.white)
                            ]),
                      ),
                    ),
                  ])),
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
                                Text(
                                  AppLocalizations.of(context)
                                      .profile_personallocations,
                                  style: const TextStyle(
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
                              ])),
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
                                  )))
                        ])),

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
                                Text(
                                  AppLocalizations.of(context)
                                      .profile_favouritestations,
                                  style: const TextStyle(
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
                              ])),
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
                                  ))),
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .profile_logout,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.close,
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
                                        title: Text(AppLocalizations.of(context)
                                            .profile_delete),
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .profile_checkdelete),
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .profile_delete,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.delete_forever,
                                            size: 28, color: Colors.white)
                                      ]),
                                ),
                              ),
                            ],
                          )),
                      const Expanded(flex: 4, child: SizedBox())
                    ]),
                    const SizedBox(height: 20),
                    SocialButton(
                        icon: FontAwesomeIcons.twitter,
                        color: const Color(0xFF1da1F2),
                        onClicked: () => share(SocialMedia.twitter)),
                    const SizedBox(height: 20),
                    SocialButton(
                        icon: FontAwesomeIcons.facebook,
                        color: const Color(0xff0c74b4),
                        onClicked: () => share(SocialMedia.facebook))
                  ]))
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: DefaultHeader(
              size: Size(screenSize.width, (screenSize.height * 0.15))),
        )
      ]),
    );
  }

  Widget listaFavStations() {
    if (userCtrl.currentUser.getFavouriteBicingStations().isEmpty &&
        userCtrl.currentUser.getFavouriteRechargeStations().isEmpty) {
      return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Material(
              color: Colors.transparent,
              child: Text(
                "No favourite stations found",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )));
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userCtrl.currentUser.getFavouriteBicingStations().length +
            userCtrl.currentUser.getFavouriteRechargeStations().length,
        itemBuilder: (context, index) {
          while (index <
              userCtrl.currentUser.getFavouriteBicingStations().length) {
            int item = int.parse(userCtrl.currentUser
                .getFavouriteBicingStations()
                .elementAt(index));
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
                await userCtrl.deleteFavBicingBD(item.toString());
                setState(() {});
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
                  child: Material(
                      color: Colors.transparent,
                      child: BicingPreview(
                          info:
                              StationController().getBicingStationbyId(item)))),
            );
          }

          ///End while Bicing Stations
          int item = int.parse(userCtrl.currentUser
              .getFavouriteRechargeStations()
              .elementAt(index -
                  userCtrl.currentUser.getFavouriteBicingStations().length));
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
              await userCtrl.deleteFavChargerBD(item.toString());
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
                child: RechargePreview(
                    info: StationController().getRechargeStation(item))),
          );
        });
  }

  Widget listaPersonalUbi() {
    if (userCtrl.currentUser.getPersonalUbi().isEmpty) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Material(
              color: Colors.transparent,
              child: Text(
                AppLocalizations.of(context).profile_nolocations,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )));
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userCtrl.currentUser.getPersonalUbi().length,
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
                    info: userCtrl.currentUser
                        .getPersonalUbi()
                        .elementAt(index))),
          );
        });
  }

  Widget listaPersonalUbi2() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userCtrl.currentUser.getPersonalUbi().length,
        itemBuilder: (context, index) {
          return Padding(
              key: UniqueKey(),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    userCtrl.currentUser
                        .getPersonalUbi()
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
                        userCtrl.currentUser.deletePersonalUbi(index);
                        Navigator.of(context).build(context);
                      },
                      icon: const Icon(Icons.delete,
                          size: 24, color: Colors.black))
                ],
              ));
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

  Future share(SocialMedia socialPlatform) async {
    //const subject = "ElectriCity best app";
    const text = "Hey i'm using ElectriCity";
    final urlShare =
        Uri.encodeComponent('https://electricity-download.w3spaces.com/index.html');
    final urls = {
      SocialMedia.twitter:
          'https://twitter.com/intent/tweet?url=$urlShare&text=$text',
      SocialMedia.facebook:
          'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text'
    };

    final url = urls[socialPlatform]!;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
