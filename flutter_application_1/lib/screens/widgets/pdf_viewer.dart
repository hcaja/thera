import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPDF extends StatelessWidget {
  const ViewPDF({super.key, required this.pdfLink});
  final String pdfLink;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfLink.split('/').last),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        pdfLink,
        key: pdfViewerKey,
      ),
    );
  }
}
