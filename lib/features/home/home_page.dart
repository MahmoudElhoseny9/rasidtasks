import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rasidtasks/core/constants/defaults.dart';
import 'package:rasidtasks/core/constants/ghaps.dart';
import 'package:rasidtasks/features/home/task_container.dart';
import 'package:rasidtasks/features/location/presentation/views/geo_home.dart';
import 'package:rasidtasks/features/notification/presentation/views/notification_view.dart';
import 'package:rasidtasks/features/portfolio/presentation/views/portfolio_creation_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rasid Tasks'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TaskContainer(
                taskName: "Local Notifications",
                goToTask: () => context.push(NotificationPage.routeName),
                iconData: Icons.notifications,
              ),
              gapH20,
              TaskContainer(
                taskName: "Portfolio PDF",
                goToTask: () => context.push(PortfolioCreationPage.routeName),
                iconData: Icons.edit_document,
              ),
              gapH20,
              TaskContainer(
                taskName: "Get Location",
                goToTask: () => context.push(GeoHomePage.routeName),
                iconData: Icons.location_on,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
