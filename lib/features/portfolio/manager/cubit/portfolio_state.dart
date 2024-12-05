part of 'portfolio_cubit.dart';

class PortfolioState {
  final bool
      isLoading; // Indicates if the PDF generation or other actions are in progress
  final String errorMessage; // Holds any error messages
  final String pdfPath; // The file path of the generated PDF

  PortfolioState({
    required this.isLoading,
    required this.errorMessage,
    required this.pdfPath,
  });

  /// A copyWith method for immutability and easy state updates
  PortfolioState copyWith({
    List<Portfolio>? portfolios,
    bool? isLoading,
    String? errorMessage,
    String? pdfPath,
  }) {
    return PortfolioState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  /// Override the toString method for easier debugging and logging
  @override
  String toString() {
    return 'PortfolioState(isLoading: $isLoading, errorMessage: $errorMessage, pdfPath: $pdfPath)';
  }

  /// Check if the current state has an error
  bool get hasError => errorMessage.isNotEmpty;

  /// Check if the PDF file is available for opening or sharing
  bool get isPdfAvailable => pdfPath.isNotEmpty;
}
