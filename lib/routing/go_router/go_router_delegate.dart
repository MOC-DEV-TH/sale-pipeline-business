import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/auth/presentations/choose_task_page.dart';
import 'package:sale_pipeline_business/features/auth/presentations/login_page.dart';
import 'package:sale_pipeline_business/features/contracts/presentation/contracts_page.dart';
import 'package:sale_pipeline_business/features/leads/presentation/leads_page.dart';
import 'package:sale_pipeline_business/features/logout/presentation/logout_page.dart';
import 'package:sale_pipeline_business/features/new_lead_step_page/presentation/new_lead_step_page.dart';
import 'package:sale_pipeline_business/features/traget/presentation/target_page.dart';
import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../utils/secure_storage.dart';
import '../../utils/strings.dart';
import '../route_error_screen/route_error_screen.dart';

part 'go_router_delegate.g.dart';

enum RoutePath {
  initial(path: '/'),
  root(path: "root"),
  home(path: "home"),
  login(path: '/login'),
  dashboard(path: '/dashboard'),
  leads(path: '/leads'),
  contracts(path: '/contract'),
  target(path: '/target'),
  logout(path: '/logout'),
  chooseTask(path: '/choose_task'),
  newLeadStep(path: '/newLead_step');

  const RoutePath({required this.path});

  final String path;
}

@riverpod
GoRouter goRouterDelegate(GoRouterDelegateRef ref) {
  final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'root');
  final GlobalKey<NavigatorState> shellNavigator = GlobalKey(
    debugLabel: 'shell',
  );

  final authStatus = ref.watch(getAuthStatusProvider).value;

  bool isDuplicate = false;

  return GoRouter(
    navigatorKey: rootNavigator,
    initialLocation: RoutePath.login.path,
    redirect: (context, state) {
      final isLoggedIn = authStatus == kAuthLoggedIn;
      final isGoingToLogin = state.matchedLocation == RoutePath.login.path;
      final isGoingToSchoolCode = state.matchedLocation == RoutePath.login.path;

      if (!isLoggedIn && !isGoingToLogin && !isGoingToSchoolCode) {
        isDuplicate = true;
        return RoutePath.login.path;
      }
      if (isLoggedIn && (isGoingToLogin || isGoingToSchoolCode)) {
        isDuplicate = true;
        return RoutePath.chooseTask.path;
      }

      if (isDuplicate) {
        isDuplicate = false;
      }

      return null;
    },
    routes: [
      ///login page
      GoRoute(
        path: RoutePath.login.path,
        parentNavigatorKey: rootNavigator,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: LoginPage(key: state.pageKey),
          );
        },
      ),
      ///choose task page
      GoRoute(
        path: RoutePath.chooseTask.path,
        parentNavigatorKey: rootNavigator,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: ChooseTaskPage(key: state.pageKey),
          );
        },
      ),

      ///dashboard page
      ShellRoute(
        navigatorKey: shellNavigator,
        builder: (context, state, child) =>
            DashboardPage(key: state.pageKey),
        routes: [
          ///home page
          GoRoute(
            path: '/',
            name: RoutePath.home.name,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: SafeArea(child: HomePage(key: state.pageKey)),
              );
            },
          ),
          ///leads page
          GoRoute(
            path: RoutePath.leads.path,
            name: RoutePath.leads.name,
            parentNavigatorKey: shellNavigator,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: SafeArea(child: LeadsPage(key: state.pageKey)),
              );
            },
          ),
          ///contracts page
          GoRoute(
            path: RoutePath.contracts.path,
            name: RoutePath.contracts.name,
            parentNavigatorKey: shellNavigator,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: SafeArea(child: ContractsPage(key: state.pageKey)),
              );
            },
          ),
          ///target page
          GoRoute(
            path: RoutePath.target.path,
            name: RoutePath.target.name,
            parentNavigatorKey: shellNavigator,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: SafeArea(child: TargetPage(key: state.pageKey)),
              );
            },
          ),

          ///logout page
          GoRoute(
            path: RoutePath.logout.path,
            name: RoutePath.logout.name,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: LogoutPage(key: state.pageKey),
              );
            },
          ),
        ],
      ),

      ///new lead step page
      GoRoute(
        path: RoutePath.newLeadStep.path,
        name: RoutePath.newLeadStep.name,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: NewLeadStepPage(key: state.pageKey),
          );
        },
      ),

    ],
    errorBuilder: (context, state) =>
        RouteErrorScreen(errorMsg: state.error.toString(), key: state.pageKey),
  );
}

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 280),
    child: child,
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.98,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
    },
  );
}
