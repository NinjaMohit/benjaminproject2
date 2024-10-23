// models/frameworkorganisation_model.dart

class FrameworkOrganisationModel {
  final int organisationId;
  final int parentId;
  final String locationKey;
  final String title;
  final String dropZone;
  final String exZone;
  final String rfid;
  final String latitude;
  final String longitude;
  final String hazards;
  final String locationNotes;
  final int confinedSpace;
  final int drops;
  final int ex;
  final String systemEmailUsers;
  final int primaryNode;
  final String nodeCode;
  final int country;
  final String city;
  final String gps;
  final String pic;
  final String picNo;
  final String picEmail;
  final int createdBy;
  final String createdOn;
  final int updatedBy;
  final String updatedOn;
  final int status;
  final String syncDate;

  FrameworkOrganisationModel({
    required this.organisationId,
    required this.parentId,
    required this.locationKey,
    required this.title,
    required this.dropZone,
    required this.exZone,
    required this.rfid,
    required this.latitude,
    required this.longitude,
    required this.hazards,
    required this.locationNotes,
    required this.confinedSpace,
    required this.drops,
    required this.ex,
    required this.systemEmailUsers,
    required this.primaryNode,
    required this.nodeCode,
    required this.country,
    required this.city,
    required this.gps,
    required this.pic,
    required this.picNo,
    required this.picEmail,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.status,
    required this.syncDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'organisation_id': organisationId,
      'parent_id': parentId,
      'location_key': locationKey,
      'title': title,
      'drop_zone': dropZone,
      'ex_zone': exZone,
      'rfid': rfid,
      'latitude': latitude,
      'longitude': longitude,
      'hazards': hazards,
      'location_notes': locationNotes,
      'confined_space': confinedSpace,
      'drops': drops,
      'ex': ex,
      'system_email_users': systemEmailUsers,
      'primary_node': primaryNode,
      'node_code': nodeCode,
      'country': country,
      'city': city,
      'GPS': gps,
      'PIC': pic,
      'PIC_no': picNo,
      'PIC_email': picEmail,
      'created_by': createdBy,
      'created_on': createdOn,
      'updated_by': updatedBy,
      'updated_on': updatedOn,
      'status': status,
      'sync_date': syncDate,
    };
  }

  factory FrameworkOrganisationModel.fromJson(Map<String, dynamic> json) {
    return FrameworkOrganisationModel(
      organisationId: json['organisation_id'] ?? 0, // Provide a default value
      parentId: json['parent_id'] ?? 0,
      locationKey: json['location_key'] ?? '', // Provide a default value
      title: json['title'] ?? 'Unknown', // Provide a default value
      dropZone: json['drop_zone'] ?? 'Not Known', // Default value
      exZone: json['ex_zone'] ?? 'Non-Haz', // Default value
      rfid: json['rfid'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      hazards: json['hazards'] ?? '',
      locationNotes: json['location_notes'] ?? '',
      confinedSpace: json['confined_space'] ?? 0,
      drops: json['drops'] ?? 0,
      ex: json['ex'] ?? 0,
      systemEmailUsers: json['system_email_users'] ?? '',
      primaryNode: json['primary_node'] ?? 0,
      nodeCode: json['node_code'] ?? '',
      country: json['country'] ?? 0,
      city: json['city'] ?? '',
      gps: json['GPS'] ?? '',
      pic: json['PIC'] ?? '',
      picNo: json['PIC_no'] ?? '',
      picEmail: json['PIC_email'] ?? '',
      createdBy: json['created_by'] ?? 0,
      createdOn: json['created_on'] ?? '', // Adjust based on type
      updatedBy: json['updated_by'] ?? 0,
      updatedOn: json['updated_on'] ?? '', // Adjust based on type
      status: json['status'] ?? 0,
      syncDate: json['sync_date'] ?? '',
    );
  }
}
