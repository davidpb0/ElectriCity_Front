// ignore_for_file: depend_on_referenced_packages

import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:electricity_front/core/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/test.dart';

void main() {

  test('User should created with json values passed', () {
    var json = {
      "username": "example",
      "email": "example@email.com",
      "id": 1,
      "favouriteLocations": [],
      "electryCoins": 100
    };
    final user = User.fromJson(json);

    expect(user.getUsername(), "example");
    expect(user.getEmail(), "example@email.com");
    expect(user.getUserId(), 1);
    expect(user.getPersonalUbi().length, 0);
  });

  test("A personal ubi should be added to personalUbi", () {
    User auxUsr = User();
    auxUsr.addPersonalUbi(const Marker(
      markerId: MarkerId("id"),
    ));
    expect(auxUsr.getPersonalUbi().length, 1);
    auxUsr.addPersonalUbi(const Marker(
      markerId: MarkerId("id2"),
    ));
    expect(auxUsr.getPersonalUbi().length, 2);
  });

  test("A personal ubi should be deleted of personalUbi", () {
    User auxUsr = User();
    auxUsr.addPersonalUbi(const Marker(
      markerId: MarkerId("id"),
    ));
    auxUsr.addPersonalUbi(const Marker(
      markerId: MarkerId("id"),
    ));
    auxUsr.deletePersonalUbi(0);
    expect(auxUsr.getPersonalUbi().length, 1);
  });

  test("Favourite Bicing station should be added", () {
    User auxUsr = User();
    Station bicing = Station();
    bicing.address = "example";
    auxUsr.addFavBicing(bicing);

    expect(auxUsr.getFavBicing().length, 1);
    expect(auxUsr.getFavBicing().elementAt(0).address, "example");

    Station bicing2 = Station();
    bicing2.address = "example2";
    auxUsr.addFavBicing(bicing2);
  });

  test("Favourite Charger station should be added", () {
    User auxUsr = User();
    RechargeStation bicing = RechargeStation();
    bicing.id = 1;
    bicing.address = "example";
    auxUsr.addFavCharger(bicing);

    expect(auxUsr.getFavCharger().length, 1);
    expect(auxUsr.getFavCharger().elementAt(0).address, "example");

    RechargeStation bicing2 = RechargeStation();
    bicing2.id = 2;
    auxUsr.addFavCharger(bicing2);
  });

  test("Favourite Charger station should be deleted", () {
    User auxUsr = User();
    RechargeStation bicing = RechargeStation();
    bicing.id = 1;
    auxUsr.deleteFavCharger(bicing);

    expect(auxUsr.getFavBicing().length, 0);
  });

  test("Favourite bicing should return true", () {
    User auxUsr = User();
    Station bicing2 = Station();
    bicing2.id = 1;
    auxUsr.addFavBicing(bicing2);
    bool b = auxUsr.isFavouriteBicing(bicing2);

    expect(b, true);
  });

  test("Favourite bicing should return false", () {
    User auxUsr = User();
    Station bicing = Station();
    bicing.id = 1;
    bool b = auxUsr.isFavouriteBicing(bicing);

    expect(b, false);
  });

  test("Favourite Charger should return true", () {
    User auxUsr = User();
    RechargeStation bicing2 = RechargeStation();
    bicing2.id = 1;
    auxUsr.addFavCharger(bicing2);
    bool b = auxUsr.isFavouriteCharger(bicing2);

    expect(b, true);
  });

  test("Favourite Charger should return false", () {
    User auxUsr = User();
    RechargeStation bicing = RechargeStation();
    bicing.id = 1;
    bool b = auxUsr.isFavouriteCharger(bicing);

    expect(b, false);
  });
}
