
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationList {
  List<Station>? listMember;
  int? totalItems;
  HydraView? hydraView;
  HydraSearch? hydraSearch;

  StationList(
      {this.listMember,
        this.totalItems,
        this.hydraView,
        this.hydraSearch});

  StationList.fromJson(Map<String, dynamic> json) {
    if (json['hydra:member'] != null) {
      listMember = <Station>[];
      json['hydra:member'].forEach((v) {
        listMember!.add(new Station.fromJson(v));
      });
    }
    totalItems = json['hydra:totalItems'];
    hydraView = json['hydra:view'] != null
        ? new HydraView.fromJson(json['hydra:view'])
        : null;
    hydraSearch = json['hydra:search'] != null
        ? new HydraSearch.fromJson(json['hydra:search'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listMember != null) {
      data['hydra:member'] = this.listMember!.map((v) => v.toJson()).toList();
    }
    data['hydra:totalItems'] = this.totalItems;
    if (this.hydraView != null) {
      data['hydra:view'] = this.hydraView!.toJson();
    }
    if (this.hydraSearch != null) {
      data['hydra:search'] = this.hydraSearch!.toJson();
    }
    return data;
  }
}

class Station {
  int? capacity;
  int? mechanical;
  int? electrical;
  int? availableSlots;
  int? id;
  double? latitude;
  double? longitude;
  LatLng? coords;
  bool? status;
  String? address;

  Station(
      {this.capacity,
        this.mechanical,
        this.electrical,
        this.availableSlots,
        this.id,
        this.latitude,
        this.longitude,
        this.coords,
        this.status,
        this.address});

  Station.fromJson(Map<String, dynamic> json) {
    capacity = json['capacity'];
    mechanical = json['mechanical'];
    electrical = json['electrical'];
    availableSlots = json['availableSlots'];
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    coords = LatLng(latitude!, longitude!);
    status = json['status'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capacity'] = this.capacity;
    data['mechanical'] = this.mechanical;
    data['electrical'] = this.electrical;
    data['availableSlots'] = this.availableSlots;
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['address'] = this.address;
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
        this.hydraNext});

  HydraView.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
    type = json['type'];
    hydraFirst = json['hydra:first'];
    hydraLast = json['hydra:last'];
    hydraPrevious = json['hydra:previous'];
    hydraNext = json['hydra:next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.id;
    data['type'] = this.type;
    data['hydra:first'] = this.hydraFirst;
    data['hydra:last'] = this.hydraLast;
    data['hydra:previous'] = this.hydraPrevious;
    data['hydra:next'] = this.hydraNext;
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
        this.hydraMapping});

  HydraSearch.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    hydraTemplate = json['hydra:template'];
    hydraVariableRepresentation = json['hydra:variableRepresentation'];
    if (json['hydra:mapping'] != null) {
      hydraMapping = <HydraMapping>[];
      json['hydra:mapping'].forEach((v) {
        hydraMapping!.add(new HydraMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['hydra:template'] = this.hydraTemplate;
    data['hydra:variableRepresentation'] = this.hydraVariableRepresentation;
    if (this.hydraMapping != null) {
      data['hydra:mapping'] =
          this.hydraMapping!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['variable'] = this.variable;
    data['property'] = this.property;
    data['required'] = this.required;
    return data;
  }
}
