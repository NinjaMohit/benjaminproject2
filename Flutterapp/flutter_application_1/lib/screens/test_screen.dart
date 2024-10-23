import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/frameworkorgaisation_controller.dart';
import 'package:flutter_application_1/test/uiframework_certificate.dart';
import 'package:flutter_application_1/test/uiframeworkcertificateIndicator.dart';
import 'package:flutter_application_1/test/uiframeworkcorrectiveaction.dart';
import 'package:flutter_application_1/test/uiframeworkorganisation.dart';
import 'package:flutter_application_1/test/uitaskinspectiontype.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/framework_certcontroller.dart';
import '../controllers/frameworkcertificateindicator_controller.dart';
import '../controllers/frameworkcorrectiveaction_controller.dart';
import '../controllers/frameworkequipmentbasic_controller.dart';
import '../controllers/frameworkequipmentcert_controller.dart';
import '../controllers/frameworkequipmentstandard_controller.dart';
import '../controllers/frameworkequipmetex_controller.dart';
import '../controllers/taskinspectiontype_controller.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Certificate App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: CertificateView(),
//     );
//   }
// }import 'package:flutter/material.dart';

class CertificateView extends StatefulWidget {
  const CertificateView({super.key});

  @override
  State<CertificateView> createState() => _CertificateViewState();
}

class _CertificateViewState extends State<CertificateView>
    with SingleTickerProviderStateMixin {
  final FrameworkCertController frameworkCertController =
      Get.put(FrameworkCertController());
  late AnimationController _animationController;
  final TaskInspectionTypeController taskInspectionTypeController =
      Get.put(TaskInspectionTypeController());
  final FrameworkOrganisationController frameworkOrganisationController =
      Get.put(FrameworkOrganisationController());

  final FrameworkCorrectiveActionController
      frameworkCorrectiveActionController =
      Get.put(FrameworkCorrectiveActionController());
  final FrameworkCertificateIndicatorController
      frameworkCertificateIndicatorController =
      Get.put(FrameworkCertificateIndicatorController());

  final FrameworkEquipmentCertController frameworkEquipmentCertController =
      Get.put(FrameworkEquipmentCertController());

  final FrameworkEquipmentExController frameworkEquipmentExController =
      Get.put(FrameworkEquipmentExController());

  final FrameworkEquipmentStandardController
      frameworkEquipmentStandardController =
      Get.put(FrameworkEquipmentStandardController());

  final FrameworkEquipmentBasicController frameworkEquipmentBasicController =
      Get.put(FrameworkEquipmentBasicController());

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(); // Repeat the animation

    // Fetch certificates when the view is initialized
    _fetchCertificates();
    _fetchTaskInspectionType();
    _fetchFrameworkOrganisation();
    _fetchFrameworkCorrectiveAction(); // Add this line
    _fetchFrameworkCertificateIndicators();
    _fetchFrameworkEquipmentCert();
    _fetchFrameworkEquipmentEx();
    _fetchFrameworkEquipmentStandards();
    _fetchFrameworkEquipmentBasic();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  Future<void> _fetchCertificates() async {
    frameworkCertController.isLoading.value = true; // Start loading
    await frameworkCertController.fetchCertificates();
    frameworkCertController.isLoading.value = false; // End loading
  }

  Future<void> _fetchTaskInspectionType() async {
    taskInspectionTypeController.isLoading.value = true; // Start loading
    await taskInspectionTypeController.fetchTaskInspectionTypes();
    taskInspectionTypeController.isLoading.value = false; // End loading
  }

  Future<void> _fetchFrameworkOrganisation() async {
    frameworkOrganisationController.isLoading.value = true; // Start loading
    await frameworkOrganisationController.fetchFrameworkOrganisations();
    frameworkOrganisationController.isLoading.value = false; // End loading
  }

  Future<void> _fetchFrameworkCorrectiveAction() async {
    frameworkCorrectiveActionController.isLoading.value = true;
    await frameworkCorrectiveActionController.fetchFrameworkCorrectiveActions();
    frameworkCorrectiveActionController.isLoading.value = false;
  }

  Future<void> _fetchFrameworkCertificateIndicators() async {
    frameworkCertificateIndicatorController.isLoading.value = true;
    await frameworkCertificateIndicatorController
        .fetchFrameworkCertificateIndicators();
    frameworkCertificateIndicatorController.isLoading.value = false;
  }

  Future<void> _fetchFrameworkEquipmentCert() async {
    frameworkEquipmentCertController.isLoading.value = true; // Start loading
    await frameworkEquipmentCertController.fetchFrameworkEquipmentCerts();
    frameworkEquipmentCertController.isLoading.value = false; // End loading
  }

  Future<void> _fetchFrameworkEquipmentEx() async {
    frameworkEquipmentExController.isLoading.value = true; // Start loading
    await frameworkEquipmentExController
        .fetchFrameworkEquipmentEx(); // Fetching equipment explosion proof details
    frameworkEquipmentExController.isLoading.value = false; // End loading
  }

  Future<void> _fetchFrameworkEquipmentStandards() async {
    frameworkEquipmentStandardController.isLoading.value =
        true; // Start loading
    await frameworkEquipmentStandardController
        .fetchFrameworkEquipmentStandards(); // Fetching equipment standards
    frameworkEquipmentStandardController.isLoading.value = false; // End loading
  }

  Future<void> _fetchFrameworkEquipmentBasic() async {
    frameworkEquipmentBasicController.isLoading.value = true; // Start loading
    await frameworkEquipmentBasicController.fetchFrameworkEquipmentBasics();
    frameworkEquipmentBasicController.isLoading.value = false; // End loading
  }

  @override
  Widget build(BuildContext context) {
    var widthm = MediaQuery.of(context).size.width;
    var heightm = MediaQuery.of(context).size.height;

    double width = widthm / 100;
    double height = heightm / 100;

    return Scaffold(
      appBar: AppBar(title: const Text('Certificates')),
      body: Obx(() {
        // Show rotating settings icon instead of loading indicator if data is being fetched
        //taskInspectionTypeController
//taskInspectionTypeController
//frameworkCorrectiveActionController
// frameworkCertificateIndicatorController
//frameworkEquipmentCertController
//frameworkEquipmentExController
// frameworkEquipmentBasicController
        if (frameworkCertController.isLoading.value &&
            taskInspectionTypeController.isLoading.value &&
            frameworkCorrectiveActionController.isLoading.value &&
            frameworkCertificateIndicatorController.isLoading.value &&
            frameworkEquipmentCertController.isLoading.value &&
            frameworkEquipmentExController.isLoading.value &&
            frameworkEquipmentBasicController.isLoading.value) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 32,
                ),
                RotationTransition(
                  turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.linear,
                    ),
                  ),
                  child: const Icon(
                    Icons.settings,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Loading",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
          );
        }

        if (frameworkCertController.certificates.isEmpty) {
          return Center(
            child: ElevatedButton(
              onPressed: () => frameworkCertController.fetchCertificates(),
              child: const Text('Load Certificates'),
            ),
          );
        }
        return Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 12,
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => UiframeworkCertificate());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 5,
                  width: width * 80,
                  decoration: BoxDecoration(
                    color: HexColor("#FFCA11"),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("4c4c4c"), // Shadow color
                        spreadRadius: 0, // How much the shadow spreads
                        blurRadius: 2,
                        // The blur effect for the shadow
                        offset: const Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'Framework_certifcates table',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: HexColor("#FFFFFF"),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => UiTaskinspectiontype());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 5,
                  width: width * 80,
                  decoration: BoxDecoration(
                    color: HexColor("#FFCA11"),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("4c4c4c"), // Shadow color
                        spreadRadius: 0, // How much the shadow spreads
                        blurRadius: 2,
                        // The blur effect for the shadow
                        offset: const Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'TaskInspectionType table',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: HexColor("#FFFFFF"),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => UiframeworkOrganisation());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 5,
                  width: width * 80,
                  decoration: BoxDecoration(
                    color: HexColor("#FFCA11"),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("4c4c4c"), // Shadow color
                        spreadRadius: 0, // How much the shadow spreads
                        blurRadius: 2,
                        // The blur effect for the shadow
                        offset: const Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'Framework Organisation',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: HexColor("#FFFFFF"),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => UiFrameworkCorrectiveAction());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 5,
                  width: width * 80,
                  decoration: BoxDecoration(
                    color: HexColor("#FFCA11"),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("4c4c4c"), // Shadow color
                        spreadRadius: 0, // How much the shadow spreads
                        blurRadius: 2,
                        // The blur effect for the shadow
                        offset: const Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'framework_corrective_action',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: HexColor("#FFFFFF"),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => UiFrameworkCertificateIndicator());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 5,
                  width: width * 80,
                  decoration: BoxDecoration(
                    color: HexColor("#FFCA11"),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("4c4c4c"), // Shadow color
                        spreadRadius: 0, // How much the shadow spreads
                        blurRadius: 2,
                        // The blur effect for the shadow
                        offset: const Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'framework_certificate_indicators',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: HexColor("#FFFFFF"),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
            ],
          ),
        );
      }),
    );
  }
}
