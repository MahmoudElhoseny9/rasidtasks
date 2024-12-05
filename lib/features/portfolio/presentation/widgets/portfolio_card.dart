import 'package:flutter/material.dart';
import 'package:rasidtasks/features/portfolio/presentation/views/portfoloi_view_page.dart';

class PortfolioCard extends StatelessWidget {
  final String title;
  final String filePath;
  final VoidCallback onShare;
  final VoidCallback onOpen;
  final VoidCallback onDownload;

  const PortfolioCard({
    super.key,
    required this.title,
    required this.filePath,
    required this.onShare,
    required this.onOpen,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PortfolioViewPage(
                      pdfPath: filePath,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: Text(filePath),
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
    );
  }
}
