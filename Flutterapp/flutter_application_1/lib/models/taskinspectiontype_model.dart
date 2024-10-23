class TaskInspectionTypeModel {
  final int? inspectionId; // Nullable because it's auto-incremented
  final String inspectionTitle;
  final String? inspectionTypeImage; // Nullable
  final int status;
  final String? createdAt; // Nullable with default value

  TaskInspectionTypeModel({
    this.inspectionId,
    required this.inspectionTitle,
    this.inspectionTypeImage,
    required this.status,
    this.createdAt,
  });

  // Convert a TaskInspectionTypeModel object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'inspection_id': inspectionId,
      'inspection_title': inspectionTitle,
      'inspection_type_image': inspectionTypeImage,
      'status': status,
      'created_at': createdAt,
    };
  }

  // Convert a Map object into a TaskInspectionTypeModel object
  factory TaskInspectionTypeModel.fromMap(Map<String, dynamic> map) {
    return TaskInspectionTypeModel(
      inspectionId: map['inspection_id'],
      inspectionTitle: map['inspection_title'],
      inspectionTypeImage: map['inspection_type_image'],
      status: map['status'],
      createdAt: map['created_at'],
    );
  }

  // Convert a TaskInspectionTypeModel object into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'inspection_id': inspectionId,
      'inspection_title': inspectionTitle,
      'inspection_type_image': inspectionTypeImage,
      'status': status,
      'created_at': createdAt,
    };
  }

  // Convert a JSON object into a TaskInspectionTypeModel object
  factory TaskInspectionTypeModel.fromJson(Map<String, dynamic> json) {
    return TaskInspectionTypeModel(
      inspectionId: json['inspection_id'],
      inspectionTitle: json['inspection_title'],
      inspectionTypeImage: json['inspection_type_image'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}
