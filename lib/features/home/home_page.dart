import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TaskContainer(
                taskName: "Local Notifications with Scheduling and Management",
                goToTask: () => context.push(NotificationPage.routeName)),
            TaskContainer(
              taskName: "Generate a Portfolio PDF",
              goToTask: () => context.push(PortfolioCreationPage.routeName),
            ),
            TaskContainer(
                taskName: "Get Location and Address",
                goToTask: () => context.push(GeoHomePage.routeName)),
          ],
        ),
      ),
    );
  }
}
