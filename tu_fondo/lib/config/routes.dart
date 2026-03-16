import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tu_fondo/modules/admin/pages/admin_fondos.dart';
import 'package:tu_fondo/modules/home/controllers/perfil.dart';
import 'package:tu_fondo/modules/home/pages/home_page.dart';
import 'package:tu_fondo/modules/login/pages/login.dart';
import 'package:tu_fondo/modules/login/pages/user_registration.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: InversionListView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              type: .bottomToTop,
              child: child,
            ).buildTransitions(context, animation, secondaryAnimation, child);
          },
        );
      },
    ),

      GoRoute(
      path: '/profile',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: Perfil(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              type: .fade,
              child: child,
            ).buildTransitions(context, animation, secondaryAnimation, child);
          },
        );
      },
    ),

    GoRoute(
      path: '/admin',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: AdminFondosView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              type: .rightToLeft,
              child: child,
            ).buildTransitions(context, animation, secondaryAnimation, child);
          },
        );
      },
    ),

    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: LoginView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              type: .bottomToTop,
              child: child,
            ).buildTransitions(context, animation, secondaryAnimation, child);
          },
        );
      },
    ),

    GoRoute(
      path: '/user_registration',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: UserRegistrationView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              type: .leftToRight,
              child: child,
            ).buildTransitions(context, animation, secondaryAnimation, child);
          },
        );
      },
    ),
  ],
);





// fade	
// rightToLeft	
// leftToRight	
// topToBottom	
// bottomToTop	
// scale	
// rotate	
// size	
// rightToLeftWithFade	
// leftToRightWithFade	