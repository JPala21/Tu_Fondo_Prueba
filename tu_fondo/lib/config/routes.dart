import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tu_fondo/modules/login/pages/login.dart';
import 'package:tu_fondo/modules/login/pages/user_registration.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
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