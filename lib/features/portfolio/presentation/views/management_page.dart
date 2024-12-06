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
          if (state.portfolios.isEmpty) {
            return const Center(child: Text("No Portfolios Found."));
          }
          return ListView.builder(
            itemCount: state.portfolios.length,
            itemBuilder: (context, index) {
              return PortfolioCard(
                portfolio: state.portfolios[index],
                onShare: () => context
                    .read<PortfolioCubit>()
                    .sharePDF(filepath: state.portfolios[index].filePath),
                onOpen: () => context
                    .read<PortfolioCubit>()
                    .openPDF(filepath: state.portfolios[index].filePath),
                onDownload: () => context
                    .read<PortfolioCubit>()
                    .downloadPDF(filePath: state.portfolios[index].filePath),
              );
            },
          );
        },
      ),
    );
  }
}
