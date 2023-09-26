import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/coaches/coach_model/datum.dart'
    as coachdatum;
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/aboutus/aboutus.dart';
import 'package:vlivemooc/ui/components/contactus/contactus.dart';
import 'package:vlivemooc/ui/screens/auth/create_account.dart';
import 'package:vlivemooc/ui/screens/auth/forgot_password.dart';
import 'package:vlivemooc/ui/screens/auth/mobile_otp_verification.dart';
import 'package:vlivemooc/ui/screens/blogs/blogs.dart';
import 'package:vlivemooc/ui/screens/bottomnav/account.dart';
import 'package:vlivemooc/ui/screens/categories/category_detail_screen.dart';
import 'package:vlivemooc/ui/screens/coaches/coach_detail_screen.dart';
import 'package:vlivemooc/ui/screens/coaches/coaches_screen.dart';
import 'package:vlivemooc/ui/screens/courses/course_play_screen.dart';
import 'package:vlivemooc/ui/screens/courses/courses_screen.dart';
import 'package:vlivemooc/ui/screens/events/events_screen.dart';
import 'package:vlivemooc/ui/screens/notification/notification_screen.dart';
import 'package:vlivemooc/ui/screens/plans/plans_screen.dart';
import 'package:vlivemooc/ui/screens/search/search_screen.dart';
import 'package:vlivemooc/ui/screens/series/series_detail_screen.dart';
import 'package:vlivemooc/ui/screens/videos/video_detail_screen.dart';
import 'package:vlivemooc/ui/screens/videos/videos_screen.dart';

import '../screens/auth/login.dart';
import '../screens/auth/signup.dart';
import '../screens/courses/course_detail_screen.dart';
import '../screens/events/event_detail_screen.dart';
import '../screens/home/home_screen.dart';

class AppRouter {
  static const String signup = "/signup";
  static const String login = "/login";
  static const String videos = "/videos";
  static const String series = "/series";
  static const String courses = "/courses";
  static const String coaches = "/coaches";
  static const String createaccount = "/createaccount";
  static const String categories = "/categories";
  static const String events = "/events";
  static const String search = "/search";
  static const String aboutus = "/aboutus";
  static const String plans = "/plans";
  static const String aboutusSEO = "/about-us";
  static const String notifications = "/notifications";

  static const String contactus = "/contactus";
  static const String account = "/account";
  static const String blogs = "/blogs";

  static const String home = "/";

  static const forgotPassword = "/forgotpassword";

  static const verifyAccount = "/verifyAccount";
  BuildContext? get appContext =>
      routes.routerDelegate.navigatorKey.currentContext;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();
  late GoRouter routes;

  GoRouter getRoutes() {
    return routes;
  }

  AppRouter() {
    routes = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: home,
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder:
              (BuildContext context, GoRouterState state, Widget child) {
            return NoTransitionPage(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: home,
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: signup,
              builder: (BuildContext context, GoRouterState state) {
                bool isLoggedin =
                    Provider.of<UserProvider>(context, listen: false)
                        .isLoggedIn;
                if (isLoggedin) {
                  context.go(AppRouter.home);
                  return Container();
                }
                return const Signup();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: forgotPassword,
              builder: (BuildContext context, GoRouterState state) {
                return const ForgotPassword();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: verifyAccount,
              builder: (BuildContext context, GoRouterState state) {
                return const MobileOtpVerification();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: login,
              builder: (BuildContext context, GoRouterState state) {
                try {
                  state.extra as Map<String, dynamic>;
                } catch (e) {
                  context.go(signup);
                  //return const Signup();
                }
                return const Login();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: createaccount,
              builder: (BuildContext context, GoRouterState state) {
                try {
                  state.extra as Map<String, dynamic>;
                } catch (e) {
                  context.go(signup);
                  return const Signup();
                }
                return const CreateAccount();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: videos,
              builder: (BuildContext context, GoRouterState state) {
                return const VideosScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "$videos/:tag/:instructor/:name/media/:contentid",
              builder: (BuildContext context, GoRouterState state) {
                Datum? datum;
                try {
                  datum = state.extra as Datum;
                } catch (pageWasRefreshedException) {
                  //do nothing here, the corresponding screen will fetch the data from the url path
                }
                String contentid = state.pathParameters['contentid']!;
                return VideoDetailScreen(
                  content: datum,
                  contentid: contentid,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "$series/:tag/:instructor/:name/media/:contentid",
              builder: (BuildContext context, GoRouterState state) {
                Datum? datum;
                try {
                  datum = state.extra as Datum;
                } catch (pageWasRefreshedException) {
                  //do nothing here, the corresponding screen will fetch the data from the url path
                }
                String contentid = state.pathParameters['contentid']!;
                return SeriesDetailScreen(
                  content: datum,
                  contentid: contentid,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: courses,
              builder: (BuildContext context, GoRouterState state) {
                return const CoursesScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: notifications,
              builder: (BuildContext context, GoRouterState state) {
                return const NotificationScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "$courses/:tag/:instructor/:name/media/:contentid",
              builder: (BuildContext context, GoRouterState state) {
                Datum? datum;
                try {
                  datum = state.extra as Datum;
                } catch (pageWasRefreshedException) {
                  //do nothing here, the corresponding screen will fetch the data from the url path
                }
                String contentid = state.pathParameters['contentid']!;
                return CourseDetailScreen(
                  content: datum,
                  contentid: contentid,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "$courses/:contentid/:name/:moduleid/:chapterid/play",
              builder: (BuildContext context, GoRouterState state) {
                Datum? datum;
                try {
                  datum = state.extra as Datum;
                } catch (pageWasRefreshedException) {
                  //do nothing here, the corresponding screen will fetch the data from the url path
                }
                String contentid = state.pathParameters['contentid']!;
                String moduleid = state.pathParameters['moduleid']!;
                String chapterid = state.pathParameters['chapterid']!;

                // bool isLoggedin =
                //     Provider.of<UserProvider>(context, listen: false)
                //         .isLoggedIn;
                // if (!isLoggedin) {
                //   Provider.of<UserProvider>(context, listen: false)
                //       .setRedirectLocation(state.location);
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //       content: Text("Please login to continue")));
                //   context.go(AppRouter.signup);
                //   return Container();
                // }
                return CoursePlayScreen(
                  content: datum,
                  contentid: contentid,
                  moduleid: moduleid,
                  chapterid: chapterid,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: coaches,
              builder: (BuildContext context, GoRouterState state) {
                return const CoachesScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: events,
              builder: (BuildContext context, GoRouterState state) {
                return const EventsScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "$events/:idevent/:name",
              builder: (BuildContext context, GoRouterState state) {
                String idevent = state.pathParameters['idevent']!;
                return EventDetailScreen(
                  idevent: idevent,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: search,
              builder: (BuildContext context, GoRouterState state) {
                return const SearchScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: aboutus,
              builder: (BuildContext context, GoRouterState state) {
                return const AboutUs();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: aboutusSEO,
              builder: (BuildContext context, GoRouterState state) {
                return const AboutUs(
                  renderNavs: false,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: contactus,
              builder: (BuildContext context, GoRouterState state) {
                return const ContactUsScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: plans,
              builder: (BuildContext context, GoRouterState state) {
                return const PlansScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: blogs,
              builder: (BuildContext context, GoRouterState state) {
                return const Blogs();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: account,
              builder: (BuildContext context, GoRouterState state) {
                bool isLoggedin =
                    Provider.of<UserProvider>(context, listen: false)
                        .isLoggedIn;
                if (!isLoggedin) {
                  context.go(home);
                  return Container();
                }
                return const Account();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "$coaches/:coachid/:name",
              builder: (BuildContext context, GoRouterState state) {
                coachdatum.Datum? datum;
                try {
                  datum = state.extra as coachdatum.Datum;
                } catch (pageWasRefreshedException) {
                  //do nothing here, the corresponding screen will fetch the data from the url path
                }
                String coachid = state.pathParameters['coachid']!;
                return CoachDetailScreen(
                  coach: datum,
                  coachid: coachid,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "$categories/:categoryid/:name",
              builder: (BuildContext context, GoRouterState state) {
                Category? category;
                try {
                  category = state.extra as Category;
                } catch (pageWasRefreshedException) {
                  //do nothing here, the corresponding screen will fetch the data from the url path
                }
                String categoryid = state.pathParameters['categoryid']!;
                return CategoryDetail(
                  category: category,
                  categoryid: categoryid,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
