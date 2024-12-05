import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasidtasks/features/portfolio/manager/cubit/portfolio_cubit.dart';

import '../widgets/portfolio_card.dart';

class PortfolioManagementPage extends StatelessWidget {
  static const String routeName = "/portfoliosScreen";

  const PortfolioManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portfolio Management"),
      ),
      body: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.pdfPath.isEmpty) {
            return const Center(child: Text("No Portfolios Found."));
          }
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return PortfolioCard(
                title: "My Portfolio",
                filePath: state.pdfPath,
                onShare: () => context.read<PortfolioCubit>().sharePDF(),
                onOpen: () => context.read<PortfolioCubit>().openPDF(),
                onDownload: () => context.read<PortfolioCubit>().downloadPDF(),
              );
            },
          );
        },
      ),
    );
  }
}
