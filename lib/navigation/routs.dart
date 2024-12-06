import 'package:go_router/go_router.dart';
import 'package:rasidtasks/features/home/home_page.dart';
import 'package:rasidtasks/features/location/presentation/views/geo_home.dart';
import 'package:rasidtasks/features/notification/presentation/views/notification_view.dart';
import 'package:rasidtasks/features/portfolio/presentation/views/management_page.dart';
import 'package:rasidtasks/features/portfolio/presentation/views/portfolio_creation_page.dart';

final router = GoRouter(initialLocation: HomePage.routeName, routes: [
  GoRoute(
    path: HomePage.routeName,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: PortfolioCreationPage.routeName,
    builder: (context, state) => const PortfolioCreationPage(),
  ),
  GoRoute(
    path: PortfolioManagementPage.routeName,
    builder: (context, state) => const PortfolioManagementPage(),
  ),
  GoRoute(
    path: GeoHomePage.routeName,
    builder: (context, state) => const GeoHomePage(),
  ),
  GoRoute(
    path: NotificationPage.routeName,
    builder: (context, state) => const NotificationPage(),
  ),
]);
