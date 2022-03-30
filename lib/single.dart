import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SingleBook extends StatelessWidget {
  // In the constructor, require a Todo.
  SingleBook(
      {Key? key,
      required this.title,
      required this.description,
      required this.filePath,
      required this.createdAt,
      required this.views})
      : super(key: key);

  // Declare a field that holds the Todo.
  final String title;
  final String description;
  final String filePath;
  final String createdAt;
  final String views;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        filePath,
        key: _pdfViewerKey,
      ),
    );
  }
}
