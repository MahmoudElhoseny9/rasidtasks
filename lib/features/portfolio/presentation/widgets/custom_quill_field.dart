import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:rasidtasks/core/constants/defaults.dart';

class CustomQuillField extends StatelessWidget {
  const CustomQuillField({
    super.key,
    required QuillController controller,
  }) : _controller = controller;

  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Column(
          children: [
            QuillSimpleToolbar(
              controller: _controller,
              configurations: QuillSimpleToolbarConfigurations(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
                ),
                showFontFamily: false,
                showFontSize: false,
                showDirection: false,
                showBackgroundColorButton: false,
                showHeaderStyle: false,
                showJustifyAlignment: false,
                showSearchButton: false,
                showSubscript: false,
                showDividers: false,
                showCodeBlock: false,
                showInlineCode: false,
                showLeftAlignment: false,
                showListCheck: false,
                showQuote: false,
                showUndo: false,
                showSuperscript: false,
                showStrikeThrough: false,
                showIndent: false,
                showRedo: false,
                showLineHeightButton: false,
                showSmallButton: false,
                showRightAlignment: false,
                showCenterAlignment: false,
                showClearFormat: false,
                showClipboardCopy: false,
                showClipboardCut: false,
                showClipboardPaste: false,
                multiRowsDisplay: false,
                toolbarSize: 35,
              ),
            ),
            QuillEditor.basic(
              configurations: const QuillEditorConfigurations(
                enableInteractiveSelection: true,
                padding: EdgeInsets.all(AppDefaults.padding16),
              ),
              controller: _controller,
            )
          ],
        ),
      ),
    );
  }
}
