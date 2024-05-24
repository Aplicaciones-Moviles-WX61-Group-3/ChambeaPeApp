import 'package:chambeape/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouterLogged = GoRouter(
  initialLocation: '/',
  routes: routes,
);

final appRouterNotLogged = GoRouter(
  initialLocation: '/login',
  routes: routes,
);

final routes = <GoRoute>[
    GoRoute(
      path: '/',
      name: HomeView.routeName,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/login',
      name: LoginView.routeName,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/workers',
      name: WorkersView.routeName,
      builder: (context, state) => const WorkersView(),
    ),
    GoRoute(
      path: '/posts',
      name: PostView.routeName,
      builder: (context, state) => const PostView(),
    ),
    GoRoute(
      path: '/notifications',
      name: NotificationsView.routeName,
      builder: (context, state) => const NotificationsView(),
    ),
    GoRoute(
      path: '/profile',
      name: ProfileView.routeName,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: '/chat',
      name: ChatListView.routeName,
      builder: (context, state) => const ChatListView(),
    )
  ];