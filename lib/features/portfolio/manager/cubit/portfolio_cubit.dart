import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rasidtasks/features/portfolio/manager/model/portfolio_model.dart';
import 'package:share_plus/share_plus.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit()
      : super(
          PortfolioState(
            isLoading: false,
            errorMessage: '',
            pdfPath: '',
          ),
        );

  /// Generate and save a PDF document
  Future<void> generatePDF({
    required String arabicContent,
    required String englishContent,
    required String workExperience,
    required String projects,
    required String skills,
    required Map<String, String> personalInfo,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      // Load fonts
      final arabicFont = await getArabicFont();
      final englishFont = await getEnglishFont();

      final pdf = pw.Document(
        theme: pw.ThemeData.withFont(
          base: englishFont, // Default English font
        ),
      );

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          header: (context) => _buildHeader(context),
          footer: (context) => _buildFooter(context),
          build: (pw.Context context) => [
            _buildPersonalInfoSection(personalInfo),
            pw.Divider(),
            _buildSection('Work Experience', workExperience, font: englishFont),
            _buildSection('Projects & Achievements', projects,
                font: englishFont),
            _buildSection('Skills', skills, font: englishFont),
            _buildSection('Arabic Content (RTL)', arabicContent,
                isRtl: true, font: arabicFont),
            _buildSection('English Content (LTR)', englishContent,
                font: englishFont),
          ],
        ),
      );

      // Save PDF to a local file
      final outputDir = await getApplicationDocumentsDirectory();
      final filePath = '${outputDir.path}/portfolio.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      emit(state.copyWith(pdfPath: filePath, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: 'Failed to generate PDF: $e', isLoading: false));
    }
  }

  /// Open the generated PDF within the app
  Future<void> openPDF() async {
    // Check if the platform is supported
    if (!Platform.isAndroid && !Platform.isIOS && !Platform.isWindows) {
      emit(state.copyWith(
          errorMessage: 'Opening PDF is not supported on this platform.'));
      return;
    }

    if (state.pdfPath.isEmpty) {
      emit(state.copyWith(errorMessage: 'No PDF file available to open.'));
      return;
    }

    final result = await OpenFile.open(state.pdfPath);
    if (result.type != ResultType.done) {
      emit(state.copyWith(errorMessage: 'Failed to open the PDF file.'));
    }
  }

  /// Share the generated PDF
  Future<void> sharePDF() async {
    if (state.pdfPath.isNotEmpty) {
      await Share.shareXFiles([XFile(state.pdfPath)]);
    } else {
      emit(state.copyWith(errorMessage: 'No PDF available to share.'));
    }
  }

  Future<void> downloadPDF() async {
  if (state.pdfPath.isNotEmpty) {
    try {
      final outputDir = await getApplicationDocumentsDirectory();
      final filePath = '${outputDir.path}/portfolio_downloaded.pdf';

      final file = File(state.pdfPath);
      final newFile = await file.copy(filePath);

      
      emit(state.copyWith(
          pdfPath: newFile.path, errorMessage: '', isLoading: false));
      
      log('PDF downloaded successfully: ${newFile.path}');
    } catch (e) {
      emit(state.copyWith(
          errorMessage: 'Failed to download PDF: $e', isLoading: false));
    }
  } else {
    emit(state.copyWith(errorMessage: 'No PDF available to download.'));
  }
}

  /// Build the header for the PDF
  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerLeft,
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(
        'Portfolio',
        style: pw.TextStyle(
          fontSize: 20,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue,
        ),
      ),
    );
  }

  /// Build the footer with page numbers
  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: const pw.TextStyle(
          fontSize: 12,
          color: PdfColors.grey700,
        ),
      ),
    );
  }

  /// Build a section with a title and content
  pw.Widget _buildSection(String title, String content,
      {bool isRtl = false, pw.Font? font}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Column(
        crossAxisAlignment:
            isRtl ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            textAlign: isRtl ? pw.TextAlign.right : pw.TextAlign.left,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.teal,
              font: font, // Use the provided font (Arabic or English)
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            content,
            textAlign: isRtl ? pw.TextAlign.right : pw.TextAlign.left,
            textDirection: isRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColors.black,
              font: font, // Use the provided font (Arabic or English)
            ),
          ),
        ],
      ),
    );
  }

  /// Build the personal information section
  pw.Widget _buildPersonalInfoSection(Map<String, String> personalInfo) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: personalInfo.entries.map((entry) {
        return pw.Text(
          '${entry.key}: ${entry.value}',
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.black),
        );
      }).toList(),
    );
  }

  /// Load a custom font for the PDF
  Future<pw.Font> getEnglishFont() async {
    final fontData = await rootBundle.load('fonts/Roboto-Regular.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<pw.Font> getArabicFont() async {
    final fontData = await rootBundle.load('fonts/Tajawal-Regular.ttf');
    return pw.Font.ttf(fontData);
  }
}
