import 'package:budgetplanner/SlideRightRoute.dart';
import 'package:budgetplanner/screens/dashboard.dart';
import 'package:budgetplanner/screens/user/email_signin.dart';
import 'package:flutter/material.dart';

import 'screens/welcome.dart';
import 'utils/route_constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print("${settings.name} settings route name");
    switch (settings.name) {
      case homeRoute:
        //Welcome()
        return SlideRightRoute(page: Welcome());
      case loginRoute:
        return SlideRightRoute(page: EmailSignin());

      case dashboardRoute:
        return SlideRightRoute(page: Dashboard());
      // case allCourse:
      //   return SlideRightRoute(page: Courses());

      // case courseDetail:
      //   late CourseMaster cd;
      //   if (args is CourseMaster) cd = args;
      //   return SlideRightRoute(
      //       page: CourseDetail(
      //     courseMaster: cd,
      //   ));

      // //mycourseDetail
      // case mycourseDetail:
      //   late CourseMaster cd;
      //   if (args is CourseMaster) cd = args;
      //   return SlideRightRoute(
      //       page: MyCourseDetail(
      //     courseMaster: cd,
      //   ));

      // //buy now course
      // case buycourse:
      //   return SlideRightRoute(
      //     page: BuyCourse(
      //       courseMaster: null,
      //       userMaster: null,
      //     ),
      //   );

      // case viewMaterial:
      //   late CourseMaster courseMaster;
      //   late MaterialMaster materialMaster;
      //   late SyllabusMaster syllabusMaster;
      //   if (args is Map) {
      //     courseMaster = args['courseMaster'];
      //     materialMaster = args['materialMaster'];
      //     syllabusMaster = args['syllabusMaster'];
      //   }
      //   return SlideRightRoute(
      //       page: MaterialView(
      //     materialMaster: materialMaster,
      //     courseMaster: courseMaster,
      //     syllabusMaster: syllabusMaster,
      //   ));
      // case viewMaterialQueries:
      //   late CourseMaster courseMaster;
      //   late MaterialMaster materialMaster;
      //   late SyllabusMaster syllabusMaster;
      //   if (args is Map) {
      //     courseMaster = args['courseMaster'];
      //     materialMaster = args['materialMaster'];
      //     syllabusMaster = args['syllabusMaster'];
      //   }
      //   return SlideRightRoute(
      //       page: MaterialQuery(
      //     materialMaster: materialMaster,
      //     courseMaster: courseMaster,
      //     syllabusMaster: syllabusMaster,
      //   ));

      // //registeration route
      // case registerRoute:
      //   return SlideRightRoute(page: Registration());

      // //edit profile route
      // case editProfile:
      //   late UserMaster um;
      //   if (args is UserMaster) um = args;
      //   return SlideRightRoute(
      //     page: EditProfile(
      //       userMaster: um,
      //     ),
      //   );

      // case faq:
      //   return SlideRightRoute(page: Faq());

      // case caffairs:
      //   return SlideRightRoute(page: CurrentAffairs());
      // case caffairDetail:
      //   late CaffairModel cad;
      //   if (args is CaffairModel) cad = args;

      //   return SlideRightRoute(
      //       page: CaffairDetail(
      //     caffairModel: cad,
      //   ));

      // //open test detail screen
      // case testDetail:
      //   late TestMaster tm;
      //   if (args is TestMaster) tm = args;
      //   return SlideRightRoute(
      //     page: QuizExamScreen(
      //       testMaster: tm,
      //     ),
      //   );
      // case blogPost:
      //   late BlogMaster bm;
      //   if (args is BlogMaster) bm = args;
      //   return SlideRightRoute(
      //       page: BlogDetail(
      //     blogMaster: bm,
      //   ));

      // case resultRoute:
      //   late int totalQuestion;
      //   late int correctAnswer;
      //   if (args is Map) {
      //     totalQuestion = args['total_question'];
      //     correctAnswer = args['correct_answer'];
      //   }
      //   return SlideRightRoute(
      //       page: QuizResult(
      //           questionCount: totalQuestion, correctAnswer: correctAnswer));

      // case testList:
      //   return SlideRightRoute(page: PracticeList());

      // case checkout:
      //   late CourseMaster cm;
      //   if (args is CourseMaster) cm = args;
      //   return SlideRightRoute(
      //       page: Checkout(
      //     courseMaster: cm,
      //   ));
      // case forgotpassword:
      //   return SlideRightRoute(page: ForgotPassword());
      // case verificationRoute:
      //   late UserMaster um;
      //   if (args is UserMaster) um = args;
      //   return SlideRightRoute(
      //       page: OtpPage(
      //     userMaster: um,
      //   ));
      //
//
      /*
  
      

      case chatRoute:
        return SlideRightRoute(page: ChatWidget());

      case doctorsRoute:
        return SlideRightRoute(
            page: DoctorsList(
          testing: args,
        ));

      case doctorProfilRoute:
        int doctorId = 0;
        String npi = "";
        if (args is DoctorsModel) {
          doctorId = args.doctorId;
          npi = args.nPI;
        }
        if (args is SearchDoctorModel) {
          doctorId = args.doctorId;
          npi = args.npi;
        }
        if (args is FeatureDoctorModel) {
          doctorId = args.doctorId;
          npi = args.npi;
        }
        return SlideRightRoute(
            page: DoctorAcount(doctorId: doctorId, npi: npi));

      case facilityProfilRoute:
        int organizaionId = 0;
        if (args is FeatureFacilityModel) {
          organizaionId = args.organisationId;
        }
        if (args is FacilitySearchModel) {
          organizaionId = args.organisationId;
        }

        return SlideRightRoute(
            page: FacilityDetail(
          organizationId: organizaionId,
        ));

      case seniorCareProfilRoute:
        int organizaionId = 0;
        /* if (args is FeatureSpecialityModel) {
          organizaionId = args.;
        } */
        if (args is SearchSeniorCareDetail) {
          organizaionId = args.organisationId;
        }
        return SlideRightRoute(
            page: SeniorCareDetail(
          organizationId: organizaionId,
        ));

      case pharmacyProfilRoute:
        return SlideRightRoute(
            page: PharmacyDetail(
          searchPharmacyModel: args,
        ));

      case firstDoctorBookRoute:
        DoctorDetailModel doctorDetailModel;
        List<FacilityOpeningHourDetail> facilityOpeningHour;
        if (args is Map) {
          doctorDetailModel = args['doctorModel'];
          facilityOpeningHour = args['doctorOpeningHour'];
        }
        return SlideRightRoute(
            page: DoctorBookFirstStep(
          doctorDetailModel: doctorDetailModel,
          facilityOpeningHour: facilityOpeningHour,
        ));

      case firstFacilityBookRoute:
        return SlideRightRoute(
            page: FacilityBookFirstStep(
          facilityDetailModel: args,
        ));

      case firstPharmacyBookRoute:
        return SlideRightRoute(
            page: PharmacyBookFirstStep(
          pharmacyDetailModel: args,
        ));

      case firstSeniorCareBookRoute:
        return SlideRightRoute(
            page: SeniorCareFirstStep(
          seniorCareDetailModel: args,
        ));

      case secondeDoctorBookRoute:
        return SlideRightRoute(page: DoctorBookSecondeStep());

      case offersRoute:
        return SlideRightRoute(page: OffersList());
      /* case bookTestRoute:
        return SlideRightRoute(page: BookTestsOnline()); */

      case bookTestRoute:
        return SlideRightRoute(page: FacilitySearchList());

      case seniorCareRoute:
        return SlideRightRoute(page: SeniorCareSearchList());

      case secondeBookTestRoute:
        return SlideRightRoute(page: BookTestsOnlineSecondeStep());

      case thirdBookTestRoute:
        return SlideRightRoute(page: BookTestsOnlineThirdStep());

      case fourthBookTestRoute:
        return SlideRightRoute(page: BookTestsOnlineFourthStep());
      /* case medecinesRoute:
        return SlideRightRoute(page: Medecines()); */

      case medecinesRoute:
        return SlideRightRoute(page: PharmacySearchList());

      case medecinesSecondeRoute:
        return SlideRightRoute(page: MedecinesSlected());

      case mydoctorsRoute:
        return SlideRightRoute(page: MyDoctorsList());

      case appointmentRoute:
        return SlideRightRoute(page: AppointmentsList());

      //doctor pending bookng list
      case bookingsRoute:
        return SlideRightRoute(page: BookingList());

      case healthRoute:
        return SlideRightRoute(page: HealthTips());

      case userTypeRoute:
        return SlideRightRoute(page: UserType());

      case searchDoctorRoute:
        print("Search page");
        return SlideRightRoute(
            page: SearchList(
          searchString: args,
        ));

      case demoRoute:
        return SlideRightRoute(
            page: InfiniteList(
          title: "demo",
        ));

      case drBookingListRoute:
        return SlideRightRoute(page: DrBookingList());

      case facilityBookingListRoute:
        return SlideRightRoute(page: FacilityBookingList());

      case pharmacyBookingListRoute:
        return SlideRightRoute(page: PharmacyBookingList());

      case seniorCareBookingListRoute:
        return SlideRightRoute(page: SeniorCareBookingList());

      //booking detail routes
      case patientBookingDetail:
        return SlideRightRoute(
            page: PatientBookingDetail(
          bookingDetailModel: args,
        ));
      case doctorBookingDetail:
        return SlideRightRoute(
            page: DoctorBookingDetail(
          bookingDetailModel: args,
        ));
      case facilityBookingDetail:
        return SlideRightRoute(
            page: FacilityBookingDetail(
          bookingDetailModel: args,
        ));
      case pharmacyBookingDetail:
        return SlideRightRoute(
            page: PharmacyBookingDetail(
          bookingDetailModel: args,
        ));
      case seniorCareBookingDetail:
        return SlideRightRoute(
            page: SeniorCareBookingDetail(
          bookingDetailModel: args,
        ));

      //pharmacy search navigation
      case pharmacySearchRoute:
        return SlideRightRoute(
            page: PharmaQuery(
          searchString: args,
        ));*/
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
