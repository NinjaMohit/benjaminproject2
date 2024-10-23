import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/frameworkcert_model.dart';
import '../models/frameworkcertindicator_model.dart';
import '../models/frameworkcorrectiveaction_model.dart';
import '../models/frameworkequipmentbasic_model.dart';
import '../models/frameworkequipmentex_model.dart';
import '../models/frameworkorganisation_model.dart';
import '../models/taskinspectiontype_model.dart';
import '../models/frameworkequipmentcert_model.dart';
import '../models/frameworkequipmentstandard_model';

class DBHelper {
  static Database? _database;

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'user_database.db');

    return await openDatabase(
      path,
      version: 1, // Incremented version
      onCreate: (db, version) async {
        await _createUserTables(db);
        await _createCertificateTable(db);
        await _createTaskInspectionTypeTable(db);
        await _createOrganisationTable(db);
        await _createCertificateIndicatorsTable(db);
        await _createCorrectiveActionTable(db);
        await _createFrameworkEquipmentCertTable(db);
        await _createFrameworkEquipmentExTable(db);
        await _createFrameworkEquipmentStandardTable(db);
        await _createFrameworkEquipmentBasicTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database upgrade logic if needed
        log('Database upgraded from version $oldVersion to $newVersion');
      },
    );
  }

  Future<void> _createUserTables(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE users_account_one (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE users_account_two (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE users_account_three (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
      ''');
      log('User account tables created successfully');
    } catch (e) {
      log('Error creating user account tables: $e');
    }
  }

  // Insert a user into the specified account table
  Future<void> insertUser(
      String username, String password, String accountSlug) async {
    final db = await database;

    try {
      String tableName = _getUserTableName(accountSlug);
      log('Inserting user into $tableName');
      await db.insert(
        tableName,
        {'username': username, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log('Error inserting user into $accountSlug: $e');
    }
  }

  // Retrieve user credentials from the specified account table
  Future<Map<String, dynamic>?> getUserCredentials(String accountSlug) async {
    final db = await database;
    String tableName = _getUserTableName(accountSlug);
    await logAllUsers();

    try {
      List<Map<String, dynamic>> result = await db.query(tableName);
      return result.isNotEmpty
          ? result.first
          : null; // Return the first user or null if no users
    } catch (e) {
      log('Error retrieving user credentials from $accountSlug: $e');
      return null;
    }
  }

  // Retrieve all user credentials from the specified account table
  Future<List<Map<String, dynamic>>> getAllData(String accountSlug) async {
    final db = await database;
    String tableName = _getUserTableName(accountSlug);
    await logAllUsers();

    try {
      List<Map<String, dynamic>> result = await db.query(tableName);
      return result; // Return all user data instead of just one
    } catch (e) {
      log('Error retrieving all data from $accountSlug: $e');
      return []; // Return an empty list on error
    }
  }

  // Retrieve the table name based on account slug
  String _getUserTableName(String accountSlug) {
    if (accountSlug == 'account-one') {
      return 'users_account_one';
    } else if (accountSlug == 'account-two') {
      return 'users_account_two';
    } else if (accountSlug == 'account-three') {
      return 'users_account_three';
    } else {
      throw Exception("Invalid account slug");
    }
  }

  // Log users from all account tables for debugging
  Future<void> logAllUsers() async {
    final db = await database;

    try {
      List<Map<String, dynamic>> usersAccountOne =
          await db.query('users_account_one');
      log('Users in account one: $usersAccountOne');

      List<Map<String, dynamic>> usersAccountTwo =
          await db.query('users_account_two');
      log('Users in account two: $usersAccountTwo');

      List<Map<String, dynamic>> usersAccountThree =
          await db.query('users_account_three');
      log('Users in account three: $usersAccountThree');
    } catch (e) {
      log('Error logging users: $e');
    }
  }

//*************************************Framework_certificate ********************* */

//http://localhost:3000/api/v1/frameworks/getCertificates

  Future<void> _createCertificateTable(Database db) async {
    try {
      await db.execute(
        'CREATE TABLE framework_certificate ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'cert_unique_id TEXT NOT NULL, '
        'cert_group TEXT NOT NULL, '
        'cert_type INTEGER NOT NULL, '
        'sort TEXT NOT NULL, '
        'competence INTEGER NOT NULL DEFAULT 0, '
        'title TEXT NOT NULL, '
        'cert_status INTEGER NOT NULL, '
        'valid_day_tick INTEGER NOT NULL, '
        'notuse_valid_day INTEGER NOT NULL DEFAULT 0, '
        'notuse_valid_hour INTEGER NOT NULL, '
        'valid_hour_tick INTEGER NOT NULL, '
        'is_cos INTEGER NOT NULL DEFAULT 0, '
        'is_major_cos INTEGER NOT NULL DEFAULT 0, '
        'is_intermediate_cos INTEGER NOT NULL DEFAULT 0, '
        'certificate_format TEXT NOT NULL, '
        'comments TEXT NOT NULL, '
        'parent_id INTEGER NOT NULL, '
        'created_by INTEGER NOT NULL, '
        'created_on TEXT NOT NULL, '
        'updated_by INTEGER NOT NULL, '
        'updated_on TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, '
        'published INTEGER NOT NULL, '
        'sync_date TEXT NOT NULL'
        ')',
      );
      log('framework_certificate table created successfully');
    } catch (e) {
      log('Error creating framework_certificate table: $e');
    }
  }

  // Insert a certificate into the framework_certificate table
  Future<void> insertCertificate(FrameworkCertModel certificate) async {
    final db = await database;
    try {
      await db.insert(
        'framework_certificate',
        certificate.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //  log('Inserted Certificate: ${certificate.toJson()}');
//
//log('Inserted Certificate: framework_certificate==//http://localhost:3000/api/v1/frameworks/getCertificates');
    } catch (e) {
      log('Error inserting certificate: $e');
    }
  }

  // Retrieve all certificates from the framework_certificate table
  Future<List<FrameworkCertModel>> getCertificates() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_certificate');
      return List.generate(maps.length, (i) {
        return FrameworkCertModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving certificates: $e');
      return []; // Return an empty list on error
    }
  }

  /////**********************************task_inspection_type ***************************/
//task_inspection_type==http://localhost:3000/api/v1/tasks/getInspectionTypes
  Future<void> _createTaskInspectionTypeTable(Database db) async {
    try {
      await db.execute(
        'CREATE TABLE task_inspection_type ('
        'inspection_id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'inspection_title TEXT NOT NULL, '
        'inspection_type_image TEXT, '
        'status INTEGER NOT NULL, '
        'created_at TEXT DEFAULT NULL'
        ')',
      );
      log('task_inspection_type table created successfully');
    } catch (e) {
      log('Error creating task_inspection_type table: $e');
    }
  }

  Future<void> insertTaskInspectionType(
      TaskInspectionTypeModel inspectionType) async {
    final db = await database;
    try {
      await db.insert(
        'task_inspection_type',
        inspectionType.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //  log('Inserted Task Inspection Type: ${inspectionType.toJson()}');
    } catch (e) {
      log('Error inserting task inspection type: $e');
    }
  }

  // Retrieve all task inspection types from the task_inspection_type table
  Future<List<TaskInspectionTypeModel>> getTaskInspectionTypes() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('task_inspection_type');
      return List.generate(maps.length, (i) {
        return TaskInspectionTypeModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving inspection types: $e');
      return []; // Return an empty list on error
    }
  }

  //********************************************** */
  //framework_organisation==http://localhost:3000/api/v1/frameworks/getLocations
  Future<void> _createOrganisationTable(Database db) async {
    try {
      await db.execute(
        'CREATE TABLE framework_organisation ('
        'organisation_id INTEGER PRIMARY KEY NOT NULL, '
        'parent_id INTEGER NOT NULL, '
        'location_key TEXT NOT NULL, '
        'title TEXT NOT NULL, '
        'drop_zone TEXT NOT NULL, '
        'ex_zone TEXT NOT NULL, '
        'rfid TEXT, '
        'latitude TEXT, '
        'longitude TEXT, '
        'hazards TEXT, '
        'location_notes TEXT, '
        'confined_space INTEGER NOT NULL, '
        'drops INTEGER NOT NULL, '
        'ex INTEGER NOT NULL, '
        'system_email_users TEXT NOT NULL, '
        'primary_node INTEGER NOT NULL, '
        'node_code TEXT NOT NULL, '
        'country INTEGER NOT NULL, '
        'city TEXT NOT NULL, '
        'GPS TEXT, '
        'PIC TEXT, '
        'PIC_no TEXT, '
        'PIC_email TEXT, '
        'created_by INTEGER NOT NULL, '
        'created_on TEXT NOT NULL, '
        'updated_by INTEGER NOT NULL, '
        'updated_on TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'status INTEGER NOT NULL, '
        'sync_date TEXT NOT NULL'
        ')',
      );
      log('framework_organisation table created successfully');
    } catch (e) {
      log('Error creating framework_organisation table: $e');
    }
  }

  Future<void> insertFrameworkOrganisation(
      FrameworkOrganisationModel organisation) async {
    final db = await database;
    try {
      await db.insert(
        'framework_organisation',
        organisation.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //    log('Inserted Organisation: ${organisation.toJson()}');
      // log('Inserted Organisation:   //framework_organisation==http://localhost:3000/api/v1/frameworks/getLocations');
    } catch (e) {
      log('Error inserting organisation: $e');
    }
  }

// Add a method to retrieve organisations
  Future<List<FrameworkOrganisationModel>> getFrameworkOrganisations() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_organisation');
      return List.generate(maps.length, (i) {
        return FrameworkOrganisationModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving organisations: $e');
      return []; // Return an empty list on error
    }
  }

  //************************************framework_certificate_indicators */
  //framework_certificate_indicators==http://localhost:3000/api/v1/frameworks/getIndicators

  Future<void> _createCertificateIndicatorsTable(Database db) async {
    try {
      await db.execute(
        'CREATE TABLE framework_certificate_indicators ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'framework_certificate_id INTEGER NOT NULL, '
        'indicator_unique_id TEXT NOT NULL, '
        'sort INTEGER, '
        'title TEXT NOT NULL, '
        'min_old TEXT, '
        'min REAL NOT NULL DEFAULT 0, '
        'max REAL NOT NULL DEFAULT 0, '
        'max_old TEXT, '
        'set_limit INTEGER NOT NULL, '
        'is_fh INTEGER NOT NULL DEFAULT 0, '
        'ca_title TEXT, '
        'created_by INTEGER NOT NULL, '
        'created_on TEXT, '
        'updated_by INTEGER NOT NULL, '
        'updated_on TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, '
        'status INTEGER NOT NULL DEFAULT 1, '
        'sync_date TEXT NOT NULL, '
        'FOREIGN KEY (framework_certificate_id) REFERENCES framework_certificate(id) ON DELETE CASCADE'
        ')',
      );
      log('framework_certificate_indicators table created successfully');
    } catch (e) {
      log('Error creating framework_certificate_indicators table: $e');
    }
  }

  Future<void> insertCertificateIndicator(
      FrameworkCertIndicatorModel indicator) async {
    final db = await database;
    try {
      await db.insert(
        'framework_certificate_indicators',
        indicator.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      //   log('Inserted Certificate Indicator: ${indicator.toJson()}');
      // log('Inserted Certificate Indicator: framework_certificate_indicators==http://localhost:3000/api/v1/frameworks/getIndicators');
    } catch (e) {
      log('Error inserting certificate indicator: $e');
    }
  }

  Future<List<FrameworkCertIndicatorModel>> getCertificateIndicators() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_certificate_indicators');
      return List.generate(maps.length, (i) {
        return FrameworkCertIndicatorModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving certificate indicators: $e');
      return []; // Return an empty list on error
    }
  }

  //*********************************************** */
  //==framework_corrective_action http://localhost:3000/api/v1/frameworks/getFrmCorrectiveActions

  Future<void> _createCorrectiveActionTable(Database db) async {
    try {
      await db.execute(
        'CREATE TABLE framework_corrective_action ('
        'corrective_action_id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'parent_id INTEGER NOT NULL, '
        'title TEXT NOT NULL, '
        'ca_code TEXT NOT NULL, '
        'ca_class INTEGER NOT NULL DEFAULT 1, '
        'ca_type TEXT, '
        'standard_ref TEXT, '
        'suggested_remedial TEXT, '
        'close_out_duration INTEGER, '
        'notes TEXT, '
        'ca_status INTEGER NOT NULL DEFAULT 1, '
        'created_by INTEGER NOT NULL, '
        'created_on TEXT NOT NULL, '
        'updated_by INTEGER NOT NULL, '
        'updated_on TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, '
        'sync_date TEXT NOT NULL'
        ')',
      );
      log('framework_corrective_action table created successfully');
    } catch (e) {
      log('Error creating framework_corrective_action table: $e');
    }
  }

// Insert a corrective action into the framework_corrective_action table
  Future<void> insertCorrectiveAction(
      FrameworkCorrectiveActionModel correctiveAction) async {
    final db = await database;
    try {
      await db.insert(
        'framework_corrective_action',
        correctiveAction.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //     log('Inserted Corrective Action: ${correctiveAction.toJson()}');
//log('Inserted Corrective Action:        //==framework_corrective_action http://localhost:3000/api/v1/frameworks/getFrmCorrectiveActions');
    } catch (e) {
      log('Error inserting corrective action: $e');
    }
  }

// Retrieve all corrective actions from the framework_corrective_action table
  Future<List<FrameworkCorrectiveActionModel>> getCorrectiveActions() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_corrective_action');
      return List.generate(maps.length, (i) {
        return FrameworkCorrectiveActionModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving corrective actions: $e');
      return []; // Return an empty list on error
    }
  }

  //*******************************************framework_equipment_cert**************** */
  //framework_equipment_cert==http://localhost:3000/api/v1/frameworks/getFrmEquipmentCerts
  Future<void> _createFrameworkEquipmentCertTable(Database db) async {
    try {
      await db.execute(
        'CREATE TABLE framework_equipment_cert ('
        'cert_id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'equipment_id INTEGER NOT NULL, '
        'frm_cert_id INTEGER NOT NULL, '
        'cert_title TEXT NOT NULL, '
        'valid_days INTEGER NOT NULL, '
        'valid_hours INTEGER NOT NULL, '
        'unexpirable INTEGER NOT NULL, '
        'cert_type INTEGER NOT NULL, '
        'created_by INTEGER NOT NULL, '
        'created_on TEXT NOT NULL, '
        'day_hour TEXT NOT NULL DEFAULT "d", '
        'sort INTEGER NOT NULL, '
        'updated_by INTEGER NOT NULL, '
        'updated_on TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, '
        'status INTEGER NOT NULL DEFAULT 1, '
        'not_active INTEGER NOT NULL DEFAULT 0, '
        'maintenance_task INTEGER NOT NULL DEFAULT 0, '
        'sync_date TEXT NOT NULL'
        ')',
      );
      log('framework_equipment_cert table created successfully');
    } catch (e) {
      log('Error creating framework_equipment_cert table: $e');
    }
  }

  // Insert a new equipment cert into the table
  Future<void> insertFrameworkEquipmentCert(
      FrameworkEquipmentCertModel equipmentCert) async {
    final db = await database;
    try {
      await db.insert(
        'framework_equipment_cert',
        equipmentCert.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // log('Inserted Framework Equipment Cert: ${equipmentCert.toJson()}');
//log('Inserted Framework Equipment Cert:   //framework_equipment_cert==http://localhost:3000/api/v1/frameworks/getFrmEquipmentCerts');
    } catch (e) {
      log('Error inserting framework equipment cert: $e');
    }
  }

  // Retrieve all equipment certificates from the table
  Future<List<FrameworkEquipmentCertModel>> getFrameworkEquipmentCerts() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_equipment_cert');
      return List.generate(maps.length, (i) {
        return FrameworkEquipmentCertModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving framework equipment certs: $e');
      return []; // Return an empty list on error
    }
  }

  //************************************framework_equipment_ex************/
  //framework_equipment_ex==http://localhost:3000/api/v1/frameworks/getFrmEquipmentEx
  Future<void> _createFrameworkEquipmentExTable(Database db) async {
    try {
      await db.execute('''
      CREATE TABLE framework_equipment_ex (
        ex_id INTEGER PRIMARY KEY AUTOINCREMENT,
        equipment_id INTEGER NOT NULL,
        epl_atex_marking TEXT NOT NULL,
        ex_category TEXT NOT NULL,
        ex_division TEXT NOT NULL,
        ex_protection TEXT DEFAULT NULL,
        ex_gas_group TEXT NOT NULL,
        ex_ip_code TEXT NOT NULL,
        ex_standards TEXT DEFAULT NULL,
        ex_pmi TEXT DEFAULT NULL,
        ex_temp_class TEXT NOT NULL,
        ex_ambient_temp TEXT NOT NULL,
        ex_cert_no TEXT DEFAULT NULL,
        ex_notified_body TEXT DEFAULT NULL,
        ex_link_to_certificates TEXT DEFAULT NULL,
        ex_general_procedure TEXT DEFAULT NULL,
        ex_special_procedure TEXT DEFAULT NULL,
        created_by INTEGER NOT NULL,
        updated_by INTEGER NOT NULL,
        created_on TEXT NOT NULL,
        updated_on TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        sync_date TEXT NOT NULL
      )
      ''');
      log('framework_equipment_ex table created successfully');
    } catch (e) {
      log('Error creating framework_equipment_ex table: $e');
    }
  }

  Future<void> insertFrameworkEquipmentEx(
      FrameworkEquipmentExModel equipmentEx) async {
    final db =
        await database; // Assumes a 'database' getter or reference is available
    try {
      await db.insert(
        'framework_equipment_ex',
        equipmentEx.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // log('Inserted Framework Equipment Ex: ${equipmentEx.toJson()}');
      //log('Inserted Framework Equipment Ex:  //framework_equipment_ex==http://localhost:3000/api/v1/frameworks/getFrmEquipmentEx');
    } catch (e) {
      log('Error inserting framework equipment ex: $e');
    }
  }

  Future<List<FrameworkEquipmentExModel>> getFrameworkEquipmentEx() async {
    final db =
        await database; // Assumes a 'database' getter or reference is available
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_equipment_ex');
      return List.generate(maps.length, (i) {
        return FrameworkEquipmentExModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving framework equipment ex: $e');
      return []; // Return an empty list on error
    }
  }

//*******************************framework_equipment_standard******************* */
//framework_equipment_standard==http://localhost:3000/api/v1/frameworks/getFrmEquipmentStandard
  Future<void> _createFrameworkEquipmentStandardTable(Database db) async {
    try {
      await db.execute('''
      CREATE TABLE framework_equipment_standard (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        equipment_id INTEGER NOT NULL,
        international_standards TEXT DEFAULT NULL,
        regional_standards TEXT DEFAULT NULL,
        contractor_standards TEXT DEFAULT NULL,
        system_note_on_general TEXT DEFAULT NULL,
        drop_standards TEXT DEFAULT NULL,
        system_notes_on_drops TEXT DEFAULT NULL,
        international_standards_details TEXT DEFAULT NULL,
        regional_standards_details TEXT DEFAULT NULL,
        contractor_standards_details TEXT DEFAULT NULL,
        primary_fixing TEXT DEFAULT NULL,
        secondary_retention TEXT DEFAULT NULL,
        safety_securing TEXT DEFAULT NULL,
        drops_inspection_procedure TEXT DEFAULT NULL,
        ex_standard TEXT DEFAULT NULL,
        ex_system_notes TEXT DEFAULT NULL,
        ex_general_procedure TEXT DEFAULT NULL,
        ex_special_procedure TEXT DEFAULT NULL,
        drops_frequency TEXT DEFAULT NULL,
        standards TEXT DEFAULT NULL,
        standards_details TEXT DEFAULT NULL,
        register_update INTEGER NOT NULL DEFAULT 0,
        created_by INTEGER NOT NULL,
        created_on TEXT NOT NULL,
        updated_by INTEGER NOT NULL,
        updated_on TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        sync_date TEXT NOT NULL
      )
      ''');
      log('framework_equipment_standard table created successfully');
    } catch (e) {
      log('Error creating framework_equipment_standard table: $e');
    }
  }

  // Future<void> insertFrameworkEquipmentStandard(
  //     List<FrameworkEquipmentStandardModel> equipmentStandardList) async {
  //   final db =
  //       await database; // Assumes a 'database' getter or reference is available
  //   try {
  //     Batch batch = db.batch();
  //     for (var basic in equipmentStandardList) {
  //       await db.insert(
  //         'framework_equipment_standard',
  //         basic.toJson(),
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );
  //     }
  //     log('Inserted ${equipmentStandardList.length} Framework Equipment Standard entries');
  //     // Commit the batch of operations to the database
  //     await batch.commit(
  //         noResult: true); // Use noResult: true for performance improvement
  //     //   log('Inserted Framework Equipment Standard: ${equipmentStandard.toJson()}');
  //     // log('Inserted Framework Equipment Standard://framework_equipment_standard==http://localhost:3000/api/v1/frameworks/getFrmEquipmentStandard');
  //   } catch (e) {
  //     log('Error inserting framework equipment standard: $e');
  //   }
  // }
  Future<void> insertFrameworkEquipmentStandardBatch(
      List<FrameworkEquipmentStandardModel> equipmentStandardList) async {
    final db = await database; // Get the database instance

    try {
      // Use batch to group multiple insert operations
      Batch batch = db.batch();

      for (var standard in equipmentStandardList) {
        batch.insert(
          'framework_equipment_standard',
          standard.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // Commit the batch of operations to the database
      await batch.commit(
          noResult: true); // Use noResult: true for performance improvement
      log('Inserted ${equipmentStandardList.length} Framework Equipment Standard entries');

      // Optional: Print inserted data for verification
      await printInsertedData(); // Ensure this method is implemented in DBHelper
    } catch (e) {
      log('Error inserting framework equipment standards: $e');
    }
  }

// Method to fetch and print all records from the framework_equipment_standard table
  Future<void> printInsertedData() async {
    final db = await database; // Get the database instance

    try {
      final List<Map<String, dynamic>> records =
          await db.query('framework_equipment_standard');

      for (var record in records) {
        log('Inserted Record: $record'); // Log each inserted record
      }
    } catch (e) {
      log('Error fetching inserted data: $e');
    }
  }

  Future<List<FrameworkEquipmentStandardModel>>
      getFrameworkEquipmentStandards() async {
    final db =
        await database; // Assumes a 'database' getter or reference is available
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_equipment_standard');
      return List.generate(maps.length, (i) {
        return FrameworkEquipmentStandardModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving framework equipment standards: $e');
      return []; // Return an empty list on error
    }
  }

  //*************************************framework_equipment_basic**************************************************** */
//framework_equipment_basic==http://localhost:3000/api/v1/frameworks/getFrameworkEquipments

  Future<void> _createFrameworkEquipmentBasicTable(Database db) async {
    try {
      await db.execute('''
      CREATE TABLE framework_equipment_basic (
        equipment_id INTEGER PRIMARY KEY,
        parent_id INTEGER NOT NULL,
        sort INTEGER NOT NULL DEFAULT 0,
        title TEXT NOT NULL,
        photo TEXT NOT NULL,
        status INTEGER NOT NULL,
        drops_frequency TEXT DEFAULT NULL,
        coc_valid_days INTEGER DEFAULT 0,
        coc_unexpirable INTEGER NOT NULL,
        in_service_valid_days INTEGER DEFAULT 0,
        in_service_unexpirable INTEGER NOT NULL,
        asset INTEGER NOT NULL,
        critical INTEGER NOT NULL,
        grouping INTEGER NOT NULL DEFAULT 0,
        eqgroups INTEGER NOT NULL DEFAULT 0,
        api INTEGER NOT NULL,
        engine INTEGER NOT NULL DEFAULT 0,
        hose INTEGER NOT NULL DEFAULT 0,
        capital_equipment INTEGER NOT NULL DEFAULT 0,
        manufacturer TEXT DEFAULT NULL,
        model TEXT DEFAULT NULL,
        weight TEXT DEFAULT NULL,
        SWL TEXT DEFAULT NULL,
        WLL TEXT DEFAULT NULL,
        test_load TEXT NOT NULL,
        visual_inspection_international_standards TEXT DEFAULT NULL,
        visual_inspection_system_notes TEXT DEFAULT NULL,
        ndt_inspection_international_standards TEXT DEFAULT NULL,
        ndt_inspection_system_notes TEXT DEFAULT NULL,
        drops_standards TEXT DEFAULT NULL,
        drops_primary_fixing TEXT DEFAULT NULL,
        drops_safety_securing TEXT DEFAULT NULL,
        ex_standards TEXT DEFAULT NULL,
        ex_general_procedure TEXT DEFAULT NULL,
        general_equipment_notes TEXT DEFAULT NULL,
        widget_type TEXT DEFAULT NULL,
        reginal_standards TEXT DEFAULT NULL,
        drops_system_notes TEXT DEFAULT NULL,
        secondary_retention TEXT DEFAULT NULL,
        drops_inspection_procedure TEXT DEFAULT NULL,
        ex_system_notes TEXT DEFAULT NULL,
        ex_special_procedure TEXT DEFAULT NULL,
        components TEXT DEFAULT NULL,
        consumables TEXT DEFAULT NULL,
        reg_widget INTEGER NOT NULL DEFAULT 0,
        cost REAL NOT NULL DEFAULT 0,
        selling_cost REAL NOT NULL DEFAULT 0,
        display_format REAL NOT NULL DEFAULT 0,
        sort_order TEXT DEFAULT NULL,
        dimension TEXT DEFAULT NULL,
        pattern_number TEXT NOT NULL,
        catalogue_number TEXT NOT NULL,
        code_rfid TEXT DEFAULT NULL,
        mro TEXT DEFAULT NULL,
        details TEXT DEFAULT NULL,
        system TEXT NOT NULL,
        updated_by INTEGER NOT NULL,
        updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        created_by INTEGER NOT NULL,
        created_on DATETIME NOT NULL,
        published INTEGER NOT NULL DEFAULT 1,
        sync_date DATETIME NOT NULL
      )
    ''');
      log('framework_equipment_basic table created successfully');
    } catch (e) {
      log('Error creating framework_equipment_basic table: $e');
    }
  }

  // Future<void> insertFrameworkEquipmentBasic(
  //     FrameworkEquipmentBasicModel equipmentBasic) async {
  //   final db =
  //       await database; // Assumes a 'database' getter or reference is available
  //   try {
  //     await db.insert(
  //       'framework_equipment_basic',
  //       equipmentBasic.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //     // log('Inserted Framework Equipment Basic: ${equipmentBasic.toJson()}');
  //     log('Inserted Framework Equipment Basic://framework_equipment_basic==http://localhost:3000/api/v1/frameworks/getFrameworkEquipments}');
  //   } catch (e) {
  //     log('Error inserting framework equipment basic: $e');
  //   }
  // }

  // Insert data using batch operation
  Future<void> insertFrameworkEquipmentBasicBatch(
      List<FrameworkEquipmentBasicModel> equipmentBasicList) async {
    final db = await database; // Get the database instance

    try {
      // Use batch to group multiple insert operations
      Batch batch = db.batch();

      for (var basic in equipmentBasicList) {
        batch.insert(
          'framework_equipment_basic',
          basic
              .toJson(), // Convert model to a Map<String, dynamic> using toJson()
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      log('Inserted ${equipmentBasicList.length} Framework Equipment Basic entries');

      // Commit the batch of operations to the database
      await batch.commit(
          noResult: true); // Use noResult: true for performance improvement

      //  await printInsertedData(); // Optional: Print inserted data for verification
    } catch (e) {
      log('Error inserting framework equipment basics: $e');
    }
  }

  // // Method to fetch and print all records from the framework_equipment_basic table
  // Future<void> printInsertedData() async {
  //   final db = await database; // Get the database instance

  //   try {
  //     final List<Map<String, dynamic>> records =
  //         await db.query('framework_equipment_basic');

  //     for (var record in records) {
  //       log('Inserted Record: $record'); // Log each inserted record
  //     }
  //   } catch (e) {
  //     log('Error fetching inserted data: $e');
  //   }
  // }

  Future<List<FrameworkEquipmentBasicModel>>
      getFrameworkEquipmentBasics() async {
    final db =
        await database; // Assumes a 'database' getter or reference is available
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('framework_equipment_basic');
      return List.generate(maps.length, (i) {
        return FrameworkEquipmentBasicModel.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error retrieving framework equipment basics: $e');
      return []; // Return an empty list on error
    }
  }
}
