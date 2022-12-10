import 'package:google_maps_flutter/google_maps_flutter.dart';

class RechargeStationList {
  late List<RechargeStation> chargeStation;
  late int totalItems;
  HydraView? hydraView;
  HydraSearch? hydraSearch;

  RechargeStationList();

  RechargeStationList.fromJson(Map<String, dynamic> json) {
    if (json['hydra:member'] != null) {
      chargeStation = <RechargeStation>[];
      json['hydra:member'].forEach((v) {
        chargeStation.add(RechargeStation.fromJson(v));
      });
    }
    totalItems = json['hydra:totalItems'];
    hydraView = json['hydra:view'] != null ? HydraView.fromJson(json['hydra:view']) : null;
    hydraSearch = json['hydra:search'] != null ? HydraSearch.fromJson(json['hydra:search']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hydra:member'] = chargeStation.map((v) => v.toJson()).toList();
    data['hydra:totalItems'] = totalItems;
    if (hydraView != null) {
      data['hydra:view'] = hydraView!.toJson();
    }
    if (hydraSearch != null) {
      data['hydra:search'] = hydraSearch!.toJson();
    }
    return data;
  }

  List<LatLng> getCoordsRcSt() {
    List<LatLng> listcoords = <LatLng>[];
    for (var e in chargeStation) {
      listcoords.add(e.coords);
    }
    return listcoords;
  }

  List<RechargeStation> getChargerStations() {
    return chargeStation;
  }
}

class RechargeStation {
  late String? speedType;
  late String? connectionType;
  late int? slots;
  late int id;
  late double latitude;
  late double longitude;
  late LatLng coords;
  late bool status;
  late String address;

  RechargeStation();

  RechargeStation.fromJson(Map<String, dynamic> json) {
    speedType = json['speedType'];
    connectionType = json['connectionType'];
    slots = json['slots'];
    id = json['id'];
    String obj = json['latitude'].toString();
    if (obj[2] != '.') {
      obj = '${obj.substring(0, 2)}.${obj.substring(2, obj.length)}';
    }
    latitude = double.parse(obj);
    longitude = json['longitude'];
    coords = LatLng(latitude.toDouble(), longitude);
    status = json['status'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speedType'] = speedType;
    data['connectionType'] = connectionType;
    data['slots'] = slots;
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['status'] = status;
    data['address'] = address;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      other is RechargeStation &&
          other.runtimeType == runtimeType &&
          other.address == address;
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
