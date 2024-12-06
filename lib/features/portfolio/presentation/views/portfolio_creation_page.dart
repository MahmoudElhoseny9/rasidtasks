import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rasidtasks/core/constants/defaults.dart';
import 'package:rasidtasks/core/constants/ghaps.dart';
import 'package:rasidtasks/features/portfolio/manager/cubit/portfolio_cubit.dart';
import 'package:rasidtasks/features/portfolio/presentation/views/management_page.dart';
import 'package:rasidtasks/features/portfolio/presentation/widgets/styled_button.dart';

import '../widgets/custom_text_field.dart';

class PortfolioCreationPage extends StatefulWidget {
  static const String routeName = "/portfolioCreation";

  const PortfolioCreationPage({super.key});

  @override
  PortfolioCreationPageState createState() => PortfolioCreationPageState();
}

class PortfolioCreationPageState extends State<PortfolioCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> personalInfo = {};
  final TextEditingController workExperienceController =
      TextEditingController();
  final TextEditingController projectsController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController arabicContentController = TextEditingController();
  final TextEditingController englishContentController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Portfolio"),
      ),
      body: BlocConsumer<PortfolioCubit, PortfolioState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppDefaults.padding16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                    label: "Name",
                    onChanged: (value) => personalInfo['Name'] = value,
                  ),
                  CustomTextField(
                    label: "Contact Details",
                    onChanged: (value) => personalInfo['Contact'] = value,
                  ),
                  CustomTextField(
                    label: "Work Experience",
                    controller: workExperienceController,
                  ),
                  CustomTextField(
                    label: "Projects & Achievements",
                    controller: projectsController,
                  ),
                  CustomTextField(
                    label: "Skills",
                    controller: skillsController,
                  ),
                  CustomTextField(
                    label: "Arabic Content (RTL)",
                    controller: arabicContentController,
                    textDirection: TextDirection.rtl,
                  ),
                  CustomTextField(
                    label: "English Content (LTR)",
                    controller: englishContentController,
                  ),
                  gapH16,
                  StyledButton(
                    label: state.isLoading
                        ? "Generating porfgolios..."
                        : "Generate porfgolios",
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await context.read<PortfolioCubit>().generatePDF(
                                    arabicContent: arabicContentController.text,
                                    englishContent:
                                        englishContentController.text,
                                    workExperience:
                                        workExperienceController.text,
                                    projects: projectsController.text,
                                    skills: skillsController.text,
                                    personalInfo: personalInfo,
                                  );
                            }
                          },
                  ),
                  gapH12,
                  StyledButton(
                    label: state.isLoading ? "Loading" : "Veiw portfolios",
                    onPressed: () =>
                        context.push(PortfolioManagementPage.routeName),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
