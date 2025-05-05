import 'package:va_bot_admin/presentation/onboard/onboard_screen/view/widget/step_three.dart';
import 'package:va_bot_admin/presentation/onboard/onboard_screen/view/widget/step_four.dart';
import 'package:va_bot_admin/presentation/onboard/onboard_screen/view/widget/step_one.dart';
import 'package:va_bot_admin/presentation/onboard/onboard_screen/view/widget/step_two.dart';
import 'package:va_bot_admin/data/model/onboard_model/crm_tools_model.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:country_picker/country_picker.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardController extends GetxController {
  ScrollController scrollController = ScrollController();
  PageController twoPageController = PageController();
  PageController threePageController = PageController();
  final GlobalKey<FormState> twoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> threeFormKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> threeFormKe2 = GlobalKey<FormState>();
  final GlobalKey<FormState> threeFormKe3 = GlobalKey<FormState>();
  int currentStep = 0;
  int twoCurrentPage = 1;
  int threeCurrentPage = 1;

  PlatformFile? pickedFile;

  final List<String> steps = [
    "Future of VA Bot Technology",
    "Tailor VA Bot to Your Business!",
    "Transaction & Lead Control!",
    "VA Bot Automates Your Workflow"
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void changeStepIndex(int index) {
    currentStep = index;
    update();
  }

  Widget getStepWidget(int step) {
    switch (step) {
      case 0:
        return StepOne(key: ValueKey(0));
      case 1:
        return StepTwo(key: ValueKey(1));
      case 2:
        return StepThree(key: ValueKey(2));
      default:
        return StepFour(key: ValueKey(3));
    }
  }

  List<CrmToolsModel> crmToolsList = [
    CrmToolsModel(
      imagePath: Assets.icons.icGoogleCalender.path,
      title: AppStrings.googleCalender,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icOutlook.path,
      title: AppStrings.outlookCalender,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icLofty.path,
      title: AppStrings.lofty,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icCrm.path,
      title: AppStrings.crmIntegrations,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icIcloudCalender.path,
      title: AppStrings.iCloudCalender,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icDotloop.path,
      title: AppStrings.dotLoop,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icGmail.path,
      title: AppStrings.gmail,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icKvCore.path,
      title: AppStrings.kvCore,
      onConnect: () {},
    ),
    CrmToolsModel(
      imagePath: Assets.icons.icFollowUpBoss.path,
      title: AppStrings.followUpBoss,
      onConnect: () {},
    ),
  ];

  String? selectedRole;

  Country? selectedCountry;
  bool isShowTransactionContainer = false;
  TextEditingController transactionController = TextEditingController();
  List<String> transactionDetails = [
    '0-2 transactions',
    '3-5 transactions',
    '6-10 transactions',
    '11-20 transactions',
    '21-50 transactions',
    '50+ transactions',
  ];

  TextEditingController followUpTimeController = TextEditingController();
  TextEditingController bookShowingController = TextEditingController();
  TextEditingController showingConfirmationController = TextEditingController();
  bool isShowFollowUpContainer = false;
  bool isShowBookShowingContainer = false;
  bool isShowShowingConfirmations = false;
  List<String> followUpTimeDetail = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
  ];
  List<String> bookShowingDetail = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
  ];
  List<String> showConfirmationDetail = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
  ];
  String selectedCallReason = '';
  List<String> callLeadReason = [
    'Yes, call all leads immediately',
    'Yes, but only warm leads.',
    'No, I will call leads myself.',
  ];
  bool isShowCrmDetails = false;
  bool isShowTrackLeadClientDetails = false;
  TextEditingController crmController = TextEditingController();
  TextEditingController leadClientController = TextEditingController();
  List<String> crmDetails = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
  ];
  List<String> leadClientDetails = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
  ];
  TextEditingController businessGoalController = TextEditingController();
  bool isShowBusinessDetail = false;

  List<String> businessGoalDetails = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
  ];
  List<String> prefilledCommonGoals = [
    AppStrings.closeMoreDeals,
    AppStrings.save10HoursPerWeek,
    AppStrings.increaseLeadConversation,
    AppStrings.automateOfferWriting,
  ];
  String selectedPreFilledGoal = '';

  List<String> basedOnDetails = [
    AppStrings.scheduleShowingConfirmAppointments,
    AppStrings.handlePostOfferTransactionManagement,
    AppStrings.followUpWithLeads,
    AppStrings.writeSubmitOffers,
  ];
  List<String> selectedBasedOnDetails = [];

  bool isLeadAutoReply = false;
  bool isLeadFollowUpReminders = false;
  int? selectedHours;
  bool isWorkflowAutomations = false;
  List<Map<String, dynamic>> notificationPreference = [
    {
      'title': AppStrings.newOffers,
      'status': true,
    },
    {
      'title': AppStrings.callSummary,
      'status': false,
    },
    {
      'title': AppStrings.leadAutoReply,
      'status': true,
    },
    {
      'title': AppStrings.scheduleChanges,
      'status': false,
    },
    {
      'title': AppStrings.leadFollowUps,
      'status': true,
    },
  ];

  void turnOnAllNotification() {
    for (int i = 0; i < notificationPreference.length; i++) {
      notificationPreference[i]['status'] = true;
    }
    update();
  }

  void turnOffAllNotification() {
    for (int i = 0; i < notificationPreference.length; i++) {
      notificationPreference[i]['status'] = false;
    }
    update();
  }
}
