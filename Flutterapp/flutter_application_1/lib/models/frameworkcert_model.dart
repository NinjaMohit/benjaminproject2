// class FrameworkCertModel {
//   final int id; // Add this line

//   final String certUniqueId; // Nullable
//   final String certGroup;
//   final int certType;
//   final String sort;
//   final int competence;
//   final String title;
//   final int certStatus;
//   final int validDayTick;
//   final int notuseValidDay;
//   final int notuseValidHour;
//   final int validHourTick;
//   final int isCos;
//   final int isMajorCos;
//   final int isIntermediateCos;
//   final String certificateFormat;
//   final String comments;
//   final int parentId;
//   final int createdBy;
//   final String createdOn;
//   final int updatedBy;
//   final String updatedOn;
//   final int published;
//   final String syncDate;

//   FrameworkCertModel({
//     required this.id, // Update constructor to require id

//     required this.certUniqueId, // Nullable
//     required this.certGroup,
//     required this.certType,
//     required this.sort,
//     required this.competence,
//     required this.title,
//     required this.certStatus,
//     required this.validDayTick,
//     required this.notuseValidDay,
//     required this.notuseValidHour,
//     required this.validHourTick,
//     required this.isCos,
//     required this.isMajorCos,
//     required this.isIntermediateCos,
//     required this.certificateFormat,
//     required this.comments,
//     required this.parentId,
//     required this.createdBy,
//     required this.createdOn,
//     required this.updatedBy,
//     required this.updatedOn,
//     required this.published,
//     required this.syncDate,
//   });

//   factory FrameworkCertModel.fromJson(Map<String, dynamic> json) {
//     return FrameworkCertModel(
//       id: json['id'] as int, // Extract id from JSON

//       certUniqueId: json['cert_unique_id'],
//       certGroup: json['cert_group'] as String? ?? '', // Provide a default value
//       certType: json['cert_type'] as int? ?? 0, // Provide a default value
//       sort: json['sort'] as String? ?? '', // Provide a default value
//       competence: json['competence'] as int? ?? 0, // Provide a default value
//       title: json['title'] as String? ?? '', // Provide a default value
//       certStatus: json['cert_status'] as int? ?? 0, // Provide a default value
//       validDayTick:
//           json['valid_day_tick'] as int? ?? 0, // Provide a default value
//       notuseValidDay:
//           json['notuse_valid_day'] as int? ?? 0, // Provide a default value
//       notuseValidHour:
//           json['notuse_valid_hour'] as int? ?? 0, // Provide a default value
//       validHourTick:
//           json['valid_hour_tick'] as int? ?? 0, // Provide a default value
//       isCos: json['is_cos'] as int? ?? 0, // Provide a default value
//       isMajorCos: json['is_major_cos'] as int? ?? 0, // Provide a default value
//       isIntermediateCos:
//           json['is_intermediate_cos'] as int? ?? 0, // Provide a default value
//       certificateFormat: json['certificate_format'] as String? ??
//           '', // Provide a default value
//       comments: json['comments'] as String? ?? '', // Provide a default value
//       parentId: json['parent_id'] as int? ?? 0, // Provide a default value
//       createdBy: json['created_by'] as int? ?? 0, // Provide a default value
//       createdOn: json['created_on'] as String? ?? '', // Provide a default value
//       updatedBy: json['updated_by'] as int? ?? 0, // Provide a default value
//       updatedOn: json['updated_on'] as String? ?? '', // Provide a default value
//       published: json['published'] as int? ?? 0, // Provide a default value
//       syncDate: json['sync_date'] as String? ?? '', // Provide a default value
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, // Include id in toJson

//       'cert_unique_id': certUniqueId,
//       'cert_group': certGroup,
//       'cert_type': certType,
//       'sort': sort,
//       'competence': competence,
//       'title': title,
//       'cert_status': certStatus,
//       'valid_day_tick': validDayTick,
//       'notuse_valid_day': notuseValidDay,
//       'notuse_valid_hour': notuseValidHour,
//       'valid_hour_tick': validHourTick,
//       'is_cos': isCos,
//       'is_major_cos': isMajorCos,
//       'is_intermediate_cos': isIntermediateCos,
//       'certificate_format': certificateFormat,
//       'comments': comments,
//       'parent_id': parentId,
//       'created_by': createdBy,
//       'created_on': createdOn,
//       'updated_by': updatedBy,
//       'updated_on': updatedOn,
//       'published': published,
//       'sync_date': syncDate,
//     };
//   }
// }
class FrameworkCertModel {
  final int? id; // Nullable because it is auto-incremented
  final String certUniqueId;
  final String certGroup;
  final int certType;
  final String sort;
  final int competence;
  final String title;
  final int certStatus;
  final int validDayTick;
  final int notuseValidDay;
  final int notuseValidHour;
  final int validHourTick;
  final int isCos;
  final int isMajorCos;
  final int isIntermediateCos;
  final String certificateFormat;
  final String comments;
  final int parentId;
  final int createdBy;
  final String createdOn;
  final int updatedBy;
  final String updatedOn;
  final int published;
  final String syncDate;

  FrameworkCertModel({
    this.id,
    required this.certUniqueId,
    required this.certGroup,
    required this.certType,
    required this.sort,
    this.competence = 0, // Default value
    required this.title,
    required this.certStatus,
    required this.validDayTick,
    this.notuseValidDay = 0, // Default value
    required this.notuseValidHour,
    required this.validHourTick,
    this.isCos = 0, // Default value
    this.isMajorCos = 0, // Default value
    this.isIntermediateCos = 0, // Default value
    required this.certificateFormat,
    required this.comments,
    required this.parentId,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.published,
    required this.syncDate,
  });

  // Convert a FrameworkCertModel object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cert_unique_id': certUniqueId,
      'cert_group': certGroup,
      'cert_type': certType,
      'sort': sort,
      'competence': competence,
      'title': title,
      'cert_status': certStatus,
      'valid_day_tick': validDayTick,
      'notuse_valid_day': notuseValidDay,
      'notuse_valid_hour': notuseValidHour,
      'valid_hour_tick': validHourTick,
      'is_cos': isCos,
      'is_major_cos': isMajorCos,
      'is_intermediate_cos': isIntermediateCos,
      'certificate_format': certificateFormat,
      'comments': comments,
      'parent_id': parentId,
      'created_by': createdBy,
      'created_on': createdOn,
      'updated_by': updatedBy,
      'updated_on': updatedOn,
      'published': published,
      'sync_date': syncDate,
    };
  }

  // Convert a Map object into a FrameworkCertModel object
  factory FrameworkCertModel.fromMap(Map<String, dynamic> map) {
    return FrameworkCertModel(
      id: map['id'],
      certUniqueId: map['cert_unique_id'],
      certGroup: map['cert_group'],
      certType: map['cert_type'],
      sort: map['sort'],
      competence: map['competence'] ?? 0,
      title: map['title'],
      certStatus: map['cert_status'],
      validDayTick: map['valid_day_tick'],
      notuseValidDay: map['notuse_valid_day'] ?? 0,
      notuseValidHour: map['notuse_valid_hour'],
      validHourTick: map['valid_hour_tick'],
      isCos: map['is_cos'] ?? 0,
      isMajorCos: map['is_major_cos'] ?? 0,
      isIntermediateCos: map['is_intermediate_cos'] ?? 0,
      certificateFormat: map['certificate_format'],
      comments: map['comments'],
      parentId: map['parent_id'],
      createdBy: map['created_by'],
      createdOn: map['created_on'],
      updatedBy: map['updated_by'],
      updatedOn:
          map['updated_on'] ?? DateTime.now().toString(), // Default value
      published: map['published'],
      syncDate: map['sync_date'],
    );
  }

  // Convert a FrameworkCertModel object into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cert_unique_id': certUniqueId,
      'cert_group': certGroup,
      'cert_type': certType,
      'sort': sort,
      'competence': competence,
      'title': title,
      'cert_status': certStatus,
      'valid_day_tick': validDayTick,
      'notuse_valid_day': notuseValidDay,
      'notuse_valid_hour': notuseValidHour,
      'valid_hour_tick': validHourTick,
      'is_cos': isCos,
      'is_major_cos': isMajorCos,
      'is_intermediate_cos': isIntermediateCos,
      'certificate_format': certificateFormat,
      'comments': comments,
      'parent_id': parentId,
      'created_by': createdBy,
      'created_on': createdOn,
      'updated_by': updatedBy,
      'updated_on': updatedOn,
      'published': published,
      'sync_date': syncDate,
    };
  }

  factory FrameworkCertModel.fromJson(Map<String, dynamic> json) {
    return FrameworkCertModel(
      id: json['id'],
      certUniqueId: json['cert_unique_id'] ?? '', // Default to empty string
      certGroup: json['cert_group'] ?? '', // Default to empty string
      certType: json['cert_type'] ?? 0, // Default to 0 if null
      sort: json['sort'] ?? '', // Default to empty string
      competence: json['competence'] ?? 0, // Default to 0 if null
      title: json['title'] ?? '', // Default to empty string
      certStatus: json['cert_status'] ?? 0, // Default to 0 if null
      validDayTick: json['valid_day_tick'] ?? 0, // Default to 0 if null
      notuseValidDay: json['notuse_valid_day'] ?? 0, // Default to 0 if null
      notuseValidHour: json['notuse_valid_hour'] ?? 0, // Default to 0 if null
      validHourTick: json['valid_hour_tick'] ?? 0, // Default to 0 if null
      isCos: json['is_cos'] ?? 0, // Default to 0 if null
      isMajorCos: json['is_major_cos'] ?? 0, // Default to 0 if null
      isIntermediateCos:
          json['is_intermediate_cos'] ?? 0, // Default to 0 if null
      certificateFormat:
          json['certificate_format'] ?? '', // Default to empty string
      comments: json['comments'] ?? '', // Default to empty string
      parentId: json['parent_id'] ?? 0, // Default to 0 if null
      createdBy: json['created_by'] ?? 0, // Default to 0 if null
      createdOn: json['created_on'] ?? '', // Default to empty string
      updatedBy: json['updated_by'] ?? 0, // Default to 0 if null
      updatedOn:
          json['updated_on'] ?? DateTime.now().toString(), // Default to now
      published: json['published'] ?? 0, // Default to 0 if null
      syncDate: json['sync_date'] ?? '', // Default to empty string
    );
  }
}
