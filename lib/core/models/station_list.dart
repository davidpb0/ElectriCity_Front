import 'package:electricity_front/core/models/comment.dart';
import 'package:electricity_front/core/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class StationList {
  late List<Station> listMember;
  late int totalItems;
  HydraView? hydraView;
  HydraSearch? hydraSearch;

  StationList();

  StationList.fromJson(Map<String, dynamic> json) {
    if (json['hydra:member'] != null) {
      listMember = <Station>[];
      json['hydra:member'].forEach((v) {
        listMember.add(Station.fromJson(v));
      });
    }
    totalItems = json['hydra:totalItems'];
    hydraView = json['hydra:view'] != null ? HydraView.fromJson(json['hydra:view']) : null;
    hydraSearch = json['hydra:search'] != null ? HydraSearch.fromJson(json['hydra:search']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hydra:member'] = listMember.map((v) => v.toJson()).toList();
    data['hydra:totalItems'] = totalItems;
    if (hydraView != null) {
      data['hydra:view'] = hydraView!.toJson();
    }
    if (hydraSearch != null) {
      data['hydra:search'] = hydraSearch!.toJson();
    }
    return data;
  }

  List<LatLng> getCoords() {
    List<LatLng> listcoords = <LatLng>[];
    for (var e in listMember) {
      listcoords.add(e.coords);
    }
    return listcoords;
  }

  List<Station> getBicingStations() {
    return listMember;
  }
}


class Station {
  late int capacity;
  late int mechanical;
  late int electrical;
  late int availableSlots;
  late int id;
  late double latitude;
  late double longitude;
  late LatLng coords;
  late bool status;
  late String address;
  List<Comment> commentsBicing = [];

  addComment(String ctext, User creator){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM kk:mm:ss').format(now);
    Comment newComment = Comment(ctext, creator, formattedDate);
    commentsBicing.add(newComment);
  }

  Station();

  Station.fromJson(Map<String, dynamic> json) {
    capacity = json['capacity'];
    mechanical = json['mechanical'];
    electrical = json['electrical'];
    availableSlots = json['availableSlots'];
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    coords = LatLng(latitude, longitude);
    status = json['status'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['capacity'] = capacity;
    data['mechanical'] = mechanical;
    data['electrical'] = electrical;
    data['availableSlots'] = availableSlots;
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['status'] = status;
    data['address'] = address;
    return data;
  }
}

class HydraView {
  String? id;
  String? type;
  String? hydraFirst;
  String? hydraLast;
  String? hydraPrevious;
  String? hydraNext;

  HydraView(
      {this.id,
      this.type,
      this.hydraFirst,
      this.hydraLast,
      this.hydraPrevious,
      this.hydraNext
      });

  HydraView.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
    type = json['type'];
    hydraFirst = json['hydra:first'];
    hydraLast = json['hydra:last'];
    hydraPrevious = json['hydra:previous'];
    hydraNext = json['hydra:next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@id'] = id;
    data['type'] = type;
    data['hydra:first'] = hydraFirst;
    data['hydra:last'] = hydraLast;
    data['hydra:previous'] = hydraPrevious;
    data['hydra:next'] = hydraNext;
    return data;
  }
}

class HydraSearch {
  String? type;
  String? hydraTemplate;
  String? hydraVariableRepresentation;
  List<HydraMapping>? hydraMapping;

  HydraSearch(
      {this.type,
      this.hydraTemplate,
      this.hydraVariableRepresentation,
      this.hydraMapping
      });

  HydraSearch.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    hydraTemplate = json['hydra:template'];
    hydraVariableRepresentation = json['hydra:variableRepresentation'];
    if (json['hydra:mapping'] != null) {
      hydraMapping = <HydraMapping>[];
      json['hydra:mapping'].forEach((v) {
        hydraMapping!.add(HydraMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['hydra:template'] = hydraTemplate;
    data['hydra:variableRepresentation'] = hydraVariableRepresentation;
    if (hydraMapping != null) {
      data['hydra:mapping'] = hydraMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HydraMapping {
  String? type;
  String? variable;
  String? property;
  bool? required;

  HydraMapping({this.type, this.variable, this.property, this.required});

  HydraMapping.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    variable = json['variable'];
    property = json['property'];
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['variable'] = variable;
    data['property'] = property;
    data['required'] = required;
    return data;
  }
}
