import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_confirm_dialog.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/privacy_policy/delete_account_dialog.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/privacy_policy/error_dialog.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/upcoming_appointment_details_dialog.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_widgets/lead_details.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_widgets/lead_status.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_widgets/send_offer.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_widgets/property.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/my_profile_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/offer_widget/form_select_dialog.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/offer_widget/signature_dialog.dart';
import 'package:va_bot_admin/data/model/home_screen_model/notification_model.dart';
import 'package:va_bot_admin/data/model/home_screen_model/appointment_model.dart';
import 'package:va_bot_admin/data/model/dashboard_model/property_list_model.dart';
import 'package:va_bot_admin/data/model/dashboard_model/all_offers_model.dart';
import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:universal_html/html.dart' as html;
import 'package:file_picker/file_picker.dart';
import 'package:universal_html/js.dart' as js;
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui_web' as ui_web;
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:convert';

class DashboardScreenController extends GetxController
    with GetTickerProviderStateMixin {
  /// ######## OFFER MANAGEMENT MODULE ######## ///
  PageController pageController = PageController();
  PageController dialogPageController = PageController();
  int dialogCurrentIndex = 0;
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;
  // bool isDarkMode = false;
  bool isShowFullSideMenu = true;
  bool isPDFEditor = false;
  int selectedSignatureIndex = 0;
  PageController signaturePageController = PageController();
  late TabController controller1;
  late TabController controller2;
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: AppColors.black141414,
    exportBackgroundColor: AppColors.transparent,
  );
  TextEditingController signatureEditingController = TextEditingController();

  late TabController appointmentController;
  onInit() {
    controller1 = TabController(length: 2, vsync: this);
    controller2 = TabController(length: 2, vsync: this);
    appointmentController = TabController(length: 4, vsync: this);

    super.onInit();
  }

  List<Map<String, dynamic>> sideBarMenu = [
    {
      'image': Assets.icons.icHome.path,
      'title': 'Home',
      'fullName': 'Home',
    },
    {
      'image': Assets.icons.icCallManagement.path,
      'title': 'Call Management',
      'fullName': 'Call Management',
    },
    {
      'image': Assets.icons.icScheduling.path,
      'title': 'Scheduling',
      'fullName': 'Scheduling',
    },
    {
      'image': Assets.icons.icOffers.path,
      'title': 'Offers',
      'fullName': 'Offers Management',
    },
    {
      'image': Assets.icons.icTransacions.path,
      'title': 'Transaction',
      'fullName': 'Transaction',
    },
    {
      'image': Assets.icons.icLeadFollowUp.path,
      'title': 'Leads & Follow-Ups',
      'fullName': 'Leads & Follow-Ups',
    },
    {
      'image': Assets.icons.icLeadFollowUp.path,
      'title': 'AI Notes & Insights',
      'fullName': 'AI Notes & Insights',
    },
    {
      'image': Assets.icons.icNotification.path,
      'title': 'Notification',
      'fullName': 'Notification',
    },
    {
      'image': Assets.icons.icSetting.path,
      'title': 'Setting',
      'fullName': 'Setting',
    },
    {
      'image': Assets.icons.icDarkMode.path,
      'title': 'Dark mode',
      'fullName': 'Dark Mode',
    },
  ];

  List<AllOffersModel> allOffersDetails = [
    AllOffersModel(
      imagePath: Assets.images.house1.path,
      title: '123 Main Street, Suite 100',
      offerAmount: '750,00',
      status: 'Waiting for Signature',
      profile: AllOfferProfile(
        imagePath: Assets.images.profile1.path,
        name: 'Sarah Smith',
        status: 'Buyer',
      ),
    ),
    AllOffersModel(
      imagePath: Assets.images.house2.path,
      title: '123 Main Street, Suite 100',
      offerAmount: '750,00',
      status: 'Signed by Buyer',
      profile: AllOfferProfile(
        imagePath: Assets.images.profile2.path,
        name: 'Sarah Smith',
        status: 'Buyer',
      ),
    ),
    AllOffersModel(
      imagePath: Assets.images.house3.path,
      title: '123 Main Street, Suite 100',
      offerAmount: '750,00',
      status: 'Signed by Buyer',
      profile: AllOfferProfile(
        imagePath: Assets.images.profile3.path,
        name: 'Sarah Smith',
        status: 'Buyer',
      ),
    ),
    AllOffersModel(
      imagePath: Assets.images.house4.path,
      title: '123 Main Street, Suite 100',
      offerAmount: '750,00',
      status: 'Sent to Listing Agent',
      profile: AllOfferProfile(
        imagePath: Assets.images.profile4.path,
        name: 'Sarah Smith',
        status: 'Buyer',
      ),
    ),
    AllOffersModel(
      imagePath: Assets.images.house5.path,
      title: '123 Main Street, Suite 100',
      offerAmount: '750,00',
      status: 'Under Review',
      profile: AllOfferProfile(
        imagePath: Assets.images.profile2.path,
        name: 'Sarah Smith',
        status: 'Buyer',
      ),
    ),
    AllOffersModel(
      imagePath: Assets.images.house6.path,
      title: '123 Main Street, Suite 100',
      offerAmount: '750,00',
      status: 'Waiting for Signature',
      profile: AllOfferProfile(
        imagePath: Assets.images.profile5.path,
        name: 'Sarah Smith',
        status: 'Buyer',
      ),
    ),
  ];

  List<Map<String, dynamic>> recentActivityList = [
    {
      'imagePath': Assets.icons.icNotificationFilled.path,
      'title': 'Buyer signed offer for 123 Main Street',
      'time': 'Today at ${DateFormat("h:mm a").format(DateTime.now())}',
    },
    {
      'imagePath': Assets.icons.icSend.path,
      'title': 'Offer sent to listing agent for 456 Park Avenue',
      'time': 'Today at ${DateFormat("h:mm a").format(DateTime.now())}',
    },
    {
      'imagePath': Assets.icons.icReminder.path,
      'title': 'Reminder sent to buyer for 789 Oak Road',
      'time': 'Today at ${DateFormat("h:mm a").format(DateTime.now())}',
    },
  ];

  void openFormSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return FormSelectDialog();
      },
    );
  }

  void openSignatureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SignatureDialog();
      },
    );
  }

  List<Map<String, dynamic>> formLists = [
    {
      'title': 'CB01 The ABC\'s of Agency',
      'isSelected': false,
    },
    {
      'title': 'CB04 Lead-Based Paint Pamphlet',
      'isSelected': false,
    },
    {
      'title': 'CB07 Mold Pamphlet',
      'isSelected': false,
    },
    {
      'title': 'CB10 Protect Yourself When Selling Real Property',
      'isSelected': false,
    },
    {
      'title': 'CB13 Protect Yourself When Buying Real Property',
      'isSelected': false,
    },
    {
      'title':
          'CB16 What to Consider When Buying Real Property in a Community Association',
      'isSelected': false,
    },
    {
      'title': 'CB19 What to Consider When Buying a Home in a Condominium',
      'isSelected': false,
    },
    {
      'title': 'CB22 Protect Yourself When Buying a Home to be Constructed',
      'isSelected': false,
    },
    {
      'title':
          'CB25 What Buyers Should Know About Flood Hazard Areas and Flood Insurance',
      'isSelected': false,
    },
    {
      'title': 'CB31 What New Landlords Need to Know About Leasing Property',
      'isSelected': false,
    },
  ];
  TextEditingController searchFormController = TextEditingController();
  TextEditingController searchAddressController = TextEditingController();
  List<String> addressList = [
    'Address 1',
    'Address 2',
    'Address 3',
    'Address 4',
    'Address 5',
  ];
  List<String> searchedAddress = [];
  void searchAddress(String val) {
    List<String> searchResult = [];
    if (val.isEmpty) {
      searchResult.clear();
    } else {
      searchResult = addressList
          .where((e) => e.toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
    searchedAddress = searchResult;
    update();
  }

  TextEditingController sellerNameController =
      TextEditingController(text: 'John Doe');
  TextEditingController sellerEmailController =
      TextEditingController(text: 'johndoe@example.com');
  TextEditingController sellerPhoneNumberController =
      TextEditingController(text: '+1 (123) 456-7890');
  TextEditingController sellerAddressController =
      TextEditingController(text: '123 Main Street, Springfield, IL, 62704');
  TextEditingController sellerOfferPriceController =
      TextEditingController(text: '\$350,000');
  TextEditingController sellerBrokerNameController =
      TextEditingController(text: 'Sarah Johnson');
  TextEditingController sellerPercentageBrokerageController =
      TextEditingController(text: '\$10,500');

  TextEditingController buyerNameController =
      TextEditingController(text: 'John Doe');
  TextEditingController buyerEmailController =
      TextEditingController(text: 'johndoe@example.com');
  TextEditingController buyerPhoneNumberController =
      TextEditingController(text: '+1 (123) 456-7890');
  TextEditingController buyerAddressController =
      TextEditingController(text: '123 Main Street, Springfield, IL, 62704');
  TextEditingController buyerOfferPriceController =
      TextEditingController(text: '\$350,000');
  TextEditingController buyerBrokerNameController =
      TextEditingController(text: 'Sarah Johnson');
  TextEditingController buyerPercentageBrokerageController =
      TextEditingController(text: '\$10,500');
  List<Uint8List> savedSignatures = [];
  Uint8List? pickedSignatureImage;
  Future<void> pickSignatureImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      pickedSignatureImage = result.files.single.bytes;
    }
    update();
  }

  String selectedSignatureFontFamily = autografFonts;
  final GlobalKey signatureGlobalKey = GlobalKey();

  Future<Uint8List?> captureAndSaveSignature(BuildContext context) async {
    RenderRepaintBoundary boundary = signatureGlobalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }
    return null;
  }

  void clearSignatureValues() {
    signatureController.clear();
    pickedSignatureImage = null;
    signatureEditingController.clear();
    update();
  }

  void onSignatureCancelPressed(BuildContext context) {
    clearSignatureValues();
    NavigatorRoute.navigateBack(context: context);
    update();
  }

  Future<void> onSignatureApplyPressed(BuildContext context) async {
    if (selectedSignatureIndex == 0) {
      Uint8List? drawnSignature = await signatureController.toPngBytes();
      if (drawnSignature != null) {
        savedSignatures.add(drawnSignature);
      }
    } else if (selectedSignatureIndex == 1) {
      if (pickedSignatureImage != null) {
        savedSignatures.add(pickedSignatureImage!);
      }
    } else {
      if (signatureEditingController.text.isNotEmpty) {
        Uint8List? typedSignature = await captureAndSaveSignature(context);
        if (typedSignature != null) {
          savedSignatures.add(typedSignature);
        }
      }
    }
    clearSignatureValues();
    NavigatorRoute.navigateBack(context: context);
    update();
  }

  bool isPDFLoading = false;
  void registerViewFactory() {
    ui_web.platformViewRegistry.registerViewFactory(
      'pspdfkit-view',
      (int viewId) {
        final div = html.DivElement()
          ..id = 'pspdfkit-container'
          ..style.width = '100%'
          ..style.height = '100vh';

        // ✅ Load PSPDFKit Web
        Future.delayed(Duration(milliseconds: 500), () {
          loadPspdfkit();
        });

        return div;
      },
    );
  }

  html.ScriptElement script = html.ScriptElement();
  void loadPspdfkit() {
    script.src =
        "https://cdn.jsdelivr.net/npm/pspdfkit@latest/dist/pspdfkit.js";
    // script.src = "https://unpkg.com/pspdfkit@latest/dist/pspdfkit.js";
    script.async = true;
    script.defer = true;

    html.window.console.log("✅ PSPDFKit Loaded!");

    // isPDFLoading = false;
    // update();
    Future.delayed(Duration(seconds: 1), () {
      if (js.context.hasProperty("PSPDFKit")) {
        loadPdf();
      } else {
        html.window.console
            .error("❌ PSPDFKit is still not available. Retrying...");
        Future.delayed(Duration(seconds: 1), loadPspdfkit);
      }
    });
    // ✅ Append script using `querySelector`
    html.querySelector('body')?.append(script);
  }

  TextEditingController currentPDFPageController =
      TextEditingController(text: '1');

  TextEditingController currentPDFZoomPercentage =
      TextEditingController(text: '100');

  String fileName = '';
  int pdfTotalPages = 0;
  Future<void> loadPdf() async {
    /*String assetPath = Assets.pdf.samplePdf;
    fileName = '${assetPath.split('/').last}';
    ByteData data = await rootBundle.load(assetPath);
    Uint8List? bytes = data.buffer.asUint8List();
    html.Blob blob = html.Blob([bytes], 'application/pdf');
    String url = html.Url.createObjectUrlFromBlob(blob);
    update();
    js.context.callMethod("loadPSPDFKit", [url]);*/
    /// ======================================= ///
    listner();
    String assetPath = Assets.pdf.samplePdf;
    fileName = '${assetPath.split('/').last}';
    ByteData data = await rootBundle.load(assetPath);
    Uint8List? bytes = data.buffer.asUint8List();
    html.Blob blob = html.Blob([bytes], 'application/pdf');
    String url = html.Url.createObjectUrlFromBlob(blob);
    update();
    js.context.callMethod("loadPSPDFKit", [url]);
  }

  listner() {
    html.window.onMessage.listen((event) {
      if (event.data is Map) {
        var data = event.data as Map;
        if (data["type"] == "PSPDFKitLoaded") {
          log("✅ PSPDFKit successfully loaded!");
          _fetchDocumentMetadata();
        } else if (data["type"] == "PSPDFKitError") {
          log("❌ Error: ${data["error"]}");
        } else if (data["type"] == "DocumentMetadata") {
          log(data.toString());
          pdfTotalPages = int.parse('${data["data"]["totalPages"].toString()}');
          update();
        } else if (data["type"] == "CurrentPage") {
          int currentPage = data["data"];
          currentPDFPageController.text = '${currentPage + 1}';
        } else if (data["type"] == "ZoomChanged") {
          double zoomLevel = data["zoom"];
          log('🎁 PAGE ZOOM = = ${zoomLevel}');
          currentPDFZoomPercentage.text = '${zoomLevel.toInt()}';
        } else if (event.data['type'] == 'DownloadPDF') {
          String base64String = event.data['data'];
          Uint8List pdfBytes = base64Decode(base64String);
          html.Blob blob = html.Blob([pdfBytes]);
          String url = html.Url.createObjectUrlFromBlob(blob);
          /*final anchor = */ html.AnchorElement(href: url)
            ..setAttribute("download", "${fileName}")
            ..click();
          html.Url.revokeObjectUrl(url);
        } else if (event.data['type'] == 'PrintPDF') {
          String base64String = event.data['data'];
          Uint8List pdfBytes = base64Decode(base64String);
          html.Blob blob = html.Blob([pdfBytes], 'application/pdf');
          String url = html.Url.createObjectUrlFromBlob(blob);

          // Open PDF in new tab
          html.window.open(url, '_blank');

          // Revoke URL after a short delay
          Future.delayed(Duration(seconds: 2), () {
            html.Url.revokeObjectUrl(url);
          });
        }
      }
    });
  }

  void _fetchDocumentMetadata() {
    js.context.callMethod("getDocumentMetadata");
  }

  void goToPage(int pageNumber) {
    js.context.callMethod("goToPage", [pageNumber]);
  }

  void setZoom(double zoomPercentage) {
    if (zoomPercentage >= 50 && zoomPercentage <= 130) {
      js.context.callMethod("setZoom", [zoomPercentage]);
    }
  }

  void savePDF() {
    js.context.callMethod('saveEditedPDF', [fileName]);
  }

  void printPDF() {
    js.context.callMethod('printPDF');
  }

  /// ######## CALL MANAGEMENT MODULE ######## ///
  String enteredNumber = '';

  void onKeyPressed(String value) {
    enteredNumber += value;
    update();
  }

  void onBackSpace() {
    if (enteredNumber.isNotEmpty) {
      enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
    }
    update();
  }

  bool isCallActive = false;
  void onCall() {
    print("Calling: $enteredNumber");
    isCallActive = true;
    update();
  }

  List<Map<String, dynamic>> emailDraftDetails = [
    {
      'name': 'John',
      'description': 'Thank you for your call regarding order #12345...',
    },
    {
      'name': 'John',
      'description': 'Thank you for your call regarding order #12345...',
    },
    {
      'name': 'John',
      'description': 'Thank you for your call regarding order #12345...',
    },
  ];
  List<Map<String, dynamic>> liveTranscriptionDetails = [
    {
      'message':
          'Hello! How can I assist you with your real estate needs today?',
      'send': false,
    },
    {
      'message':
          'I\'m interested in scheduling a viewing for 123 Main Street this weekend.',
      'send': true,
    },
    {
      'message': 'What is your name?',
      'send': false,
    },
    {
      'message': 'John Anderson',
      'send': true,
    },
    {
      'message': 'On which date are you free?',
      'send': false,
    },
    {
      'message': '26-Feb 2025',
      'send': true,
    },
    {
      'message': '  You Have Meeting Today at 10:00AM',
      'send': false,
      'type': 'meeting',
    },
  ];
  PropertyListModel? selectedProperty;
  List<PropertyListModel> propertyListDetails = [
    PropertyListModel(
      imagePath: Assets.images.house1.path,
      propertyName: '123 Maple Street, Austin, TX 78701',
      propertyViewedDate: DateTime.now(),
      interestLevel: 'Considering',
      equity: '\$250,000',
      lastSellDate: 'March 2020',
      lastSellPrice: '\$650,000',
      propertyTax: '\$8,500',
    ),
    PropertyListModel(
      imagePath: Assets.images.house2.path,
      propertyName: '123 Maple Street, Austin, TX 78701',
      propertyViewedDate: DateTime.now(),
      interestLevel: 'Favorite',
      equity: '\$250,000',
      lastSellDate: 'March 2020',
      lastSellPrice: '\$650,000',
      propertyTax: '\$8,500',
    ),
    PropertyListModel(
      imagePath: Assets.images.house3.path,
      propertyName: '123 Maple Street, Austin, TX 78701',
      propertyViewedDate: DateTime.now(),
      interestLevel: 'Considering',
      equity: '\$250,000',
      lastSellDate: 'March 2020',
      lastSellPrice: '\$650,000',
      propertyTax: '\$8,500',
    ),
  ];

  void handleKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (enteredNumber.isNotEmpty) {
          onCall();
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        onBackSpace();
      }

      String key = event.logicalKey.keyLabel.replaceFirst('Numpad ', '');
      if ('0123456789'.contains(key)) {
        onKeyPressed(key);
      }
    }
  }

  Map<String, dynamic> callerInfo = {
    'image': Assets.images.johnAnderson.path,
    'name': 'John Andreson',
    'email': 'john.anderson@email.com',
  };

  showMyProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return MyProfileDialog();
      },
    );
  }

  String selectedProfileTab = 'My Profile';
  PageController myProfilePageController = PageController();
  int myProfileCurrentIndex = 0;

  List<Map<String, dynamic>> myProfileSideBarMenu = [
    {
      'image': Assets.icons.icMyProfile.path,
      'title': 'My Profile',
    },
    {
      'image': Assets.icons.icProfessional.path,
      'title': 'Professional ',
    },
    {
      'image': Assets.icons.icSecurity.path,
      'title': 'Security',
    },
    {
      'image': Assets.icons.icNotification.path,
      'title': 'Notification',
    },
    {
      'image': Assets.icons.icPrivacyPolicy.path,
      'title': 'Privacy Policy',
    },
    {
      'image': Assets.icons.icLogout.path,
      'title': 'Log Out',
    },
  ];

  TextEditingController myProfileFirstNameController =
      TextEditingController(text: 'Angelina');
  TextEditingController myProfileLastNameController =
      TextEditingController(text: 'Gotelli');
  TextEditingController myProfileEmailController =
      TextEditingController(text: 'angelinagotelli@email.com');
  TextEditingController myProfilePhoneController =
      TextEditingController(text: '7035555678');
  String selectedCountryCode = '91';
  Country? selectedCountry;

  TextEditingController professionalBrokerageNameController =
      TextEditingController();
  TextEditingController professionalLicenseNumberController =
      TextEditingController(text: 'GJ0120XX0001923');

  TextEditingController professionalSpecializationAresController =
      TextEditingController(text: '-');
  TextEditingController professionalExperienceLevelController =
      TextEditingController(text: '-');

  TextEditingController linkedinController =
      TextEditingController(text: 'www.linkedin.com/in');
  TextEditingController linkImageController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedinSAController = TextEditingController();
  PageController securityPageController = PageController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool isOldPasswordShow = false;
  bool isNewPasswordShow = false;
  bool isConfirmNewPassShow = false;

  bool isMultiFactorAuthentication = false;
  bool iuSMSEnable = false;
  bool isEmailEnable = false;
  bool isAuthAppEnable = false;

  TreeViewController? treeController;
  int selectedTreeIndex = 0;
  TreeNode<dynamic> sampleTree = TreeNode.root()
    ..addAll(
      [
        TreeNode(key: "0"),
        TreeNode(key: "1"),
        TreeNode(key: "2"),
      ],
    );

  bool isSMSNotification = false;
  bool isEmailNotification = false;
  bool isInAppAlertsNotification = false;
  bool isQuiteHoursNotification = true;
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  void openDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteAccountDialog();
      },
    );
  }

  TextEditingController otpController = TextEditingController();

  void openErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog();
      },
    );
  }

  TimeOfDay? startTime;
  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      startTime = picked;
      startTimeController.text = startTime.toString();
    }
    update();
  }

  TimeOfDay? endTime;
  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      endTime = picked;
      endTimeController.text = endTime.toString();
    }
    update();
  }

  List<Map<String, dynamic>> homeMenu = [
    {
      'image': Assets.icons.icCallManagement.path,
      'title': 'Call Management',
    },
    {
      'image': Assets.icons.icScheduling.path,
      'title': 'Scheduling',
    },
    {
      'image': Assets.icons.icOffers.path,
      'title': 'Offer Management',
    },
    {
      'image': Assets.icons.icAnalytics.path,
      'title': 'Analytics',
    },
    {
      'image': Assets.icons.icTransacions.path,
      'title': 'Transactions',
    },
  ];

  List<AppointmentModel> appointmentData = [
    AppointmentModel(
      image: Assets.images.appointment1.path,
      name: 'Emily Watson',
      time: 'Tomorrow, 11:00 AM',
      status: 'Confirmed',
      amount: '\$525,000',
      address: 'Maple Avenue, Austin, TX 78701, U.S',
    ),
    AppointmentModel(
      image: Assets.images.appointment2.path,
      name: 'David Miller',
      time: 'Saturday, 3:30 PM',
      status: 'Pending',
      amount: '\$610,000',
      address: 'Ocean Drive, Miami, FL 33139, U.S',
    ),
    AppointmentModel(
      image: Assets.images.appointment1.path,
      name: 'Emily Watson',
      time: 'Tomorrow, 11:00 AM',
      status: 'Confirmed',
      amount: '\$525,000',
      address: 'Maple Avenue, Austin, TX 78701, U.S',
    ),
    AppointmentModel(
      image: Assets.images.appointment2.path,
      name: 'David Miller',
      time: 'Saturday, 3:30 PM',
      status: 'Pending',
      amount: '\$610,000',
      address: 'Ocean Drive, Miami, FL 33139, U.S',
    ),
  ];
  ScrollController scrollController = ScrollController();
  ScrollController recentScrollController = ScrollController();
  ScrollController menuScrollController = ScrollController();

  List<NotificationModel> notificationData = [
    NotificationModel(
      image: Assets.icons.icEmail.path,
      title: 'New offer received: 456 Oak Avenue.',
      description:
          'New offer on 456 Oak Ave for \$450,000! The seller typically responds in 24 hours—Do you want to send a follow-up?',
      time: 'Now',
    ),
    NotificationModel(
      image: Assets.icons.icEmail.path,
      title: 'New offer received: 456 Oak Avenue.',
      description:
          'New offer on 456 Oak Ave for \$450,000! The seller typically responds in 24 hours—Do you want to send a follow-up?',
      time: 'Now',
    ),
    NotificationModel(
      image: Assets.icons.icEmail.path,
      title: 'New offer received: 456 Oak Avenue.',
      description:
          'New offer on 456 Oak Ave for \$450,000! The seller typically responds in 24 hours—Do you want to send a follow-up?',
      time: 'Now',
    ),
  ];

  List<AppointmentModel> recentOffersData = [
    AppointmentModel(
      image: Assets.images.recentOffer1.path,
      name: 'Sarah Johnson',
      time: 'Monday, 9:00 AM',
      status: 'Rejected',
      amount: '\$450,000',
      address: 'Sunset Boulevard, Los Angeles, CA 90028, U.S',
    ),
    AppointmentModel(
      image: Assets.images.recentOffer2.path,
      name: 'Michael Brown',
      time: 'Wednesday, 5:00 PM',
      status: 'Pending Review',
      amount: '\$700,000',
      address: 'Fifth Avenue, New York, NY 10001, U.S',
    ),
    AppointmentModel(
      image: Assets.images.recentOffer1.path,
      name: 'Sarah Johnson',
      time: 'Monday, 9:00 AM',
      status: 'Rejected',
      amount: '\$450,000',
      address: 'Sunset Boulevard, Los Angeles, CA 90028, U.S',
    ),
    AppointmentModel(
      image: Assets.images.recentOffer2.path,
      name: 'Michael Brown',
      time: 'Wednesday, 5:00 PM',
      status: 'Pending Review',
      amount: '\$700,000',
      address: 'Fifth Avenue, New York, NY 10001, U.S',
    ),
  ];

  void openAppointmentDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return UpcomingAppointmentDetailsDialog();
      },
    );
  }

  void openConfirmAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AppointmentConfirmDialog();
      },
    );
  }

  void onTabPressed(int index) {
    update();
    /* appointPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
    ); // smooth animation, curve: curve)*/
  }

  Widget getAppointmentDialogWidgets(int index) {
    if (index == 0) {
      return LeadDetails();
    } else if (index == 1) {
      return AppointmentProperty();
    } else if (index == 2) {
      return AppointmentSendOffer();
    } else {
      return AppointmentLeadStatus();
    }
  }

  TextEditingController appLeadFirstController =
      TextEditingController(text: 'Nolan');
  TextEditingController appLeadSecondController =
      TextEditingController(text: 'Calzoni');
  TextEditingController appLeadEmailController =
      TextEditingController(text: 'nolancalzoni@email.com');
  TextEditingController appLeadPhoneController =
      TextEditingController(text: '(+1) 703-555-5678');
  TextEditingController appPropertyType = TextEditingController(text: 'House');
  TextEditingController appProLocationPreference =
      TextEditingController(text: 'Lincoln Drive Harrisburg, PA 17101 U.S.A');
  TextEditingController appSOSellerPrice =
      TextEditingController(text: '\$ 450,00');
  TextEditingController appSOBuyerPrice =
      TextEditingController(text: '\$ 400,000');
}
