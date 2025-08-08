import 'package:chargebee_demo/features/subscription/presentation/subscription_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'subscription',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SubscriptionScreen(),
      ),
    ),
  ],
);
