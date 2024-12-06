import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rasidtasks/core/constants/defaults.dart';
import 'package:rasidtasks/features/portfolio/manager/model/portfolio_model.dart';
import 'package:rasidtasks/features/portfolio/presentation/views/portfoloi_view_page.dart';
import 'package:rasidtasks/theme/app_colors.dart';

class PortfolioCard extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onOpen;
  final VoidCallback onDownload;
  final Portfolio portfolio;

  const PortfolioCard({
    super.key,
    required this.onShare,
    required this.onOpen,
    required this.onDownload,
    required this.portfolio,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd')
        .format(portfolio.createdAt); // e.g., "2024-12-06"
    String formattedTime =
        DateFormat('hh:mm a').format(portfolio.createdAt); // e.g., "01:45 PM"
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding16, vertical: AppDefaults.padding8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PortfolioViewPage(
                        pdfPath: portfolio.filePath,
                      )));
        },
        child: Card(
          color: AppColors.secondaryBabyBlue,
          child: ListTile(
            title: Text(
              portfolio.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('$formattedTime \n$formattedDate'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: onShare,
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: onOpen,
                ),
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: onDownload,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
