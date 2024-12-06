part of 'portfolio_cubit.dart';

class PortfolioState {
  final bool
      isLoading; // Indicates if the PDF generation or other actions are in progress
  final String errorMessage; // Holds any error messages
  final List<Portfolio> portfolios; // The file path of the generated PDF

  PortfolioState({
    required this.isLoading,
    required this.errorMessage,
    required this.portfolios,
  });

  /// A copyWith method for immutability and easy state updates
  PortfolioState copyWith({
    List<Portfolio>? portfolios,
    bool? isLoading,
    String? errorMessage,
    List<Portfolio>? pdfPath,
  }) {
    return PortfolioState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      portfolios: pdfPath ?? this.portfolios,
    );
  }

  /// Override the toString method for easier debugging and logging
  @override
  String toString() {
    return 'PortfolioState(isLoading: $isLoading, errorMessage: $errorMessage, pdfPath: $portfolios)';
  }

  /// Check if the current state has an error
  bool get hasError => errorMessage.isNotEmpty;

  /// Check if the PDF file is available for opening or sharing
  bool get isPdfAvailable => portfolios.isNotEmpty;
}
