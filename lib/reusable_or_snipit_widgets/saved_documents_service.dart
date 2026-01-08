import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedDocument {
  final String id;
  final String title;
  final String filePath;
  final String originalUrl;
  final DateTime savedDate;
  final String? description;

  SavedDocument({
    required this.id,
    required this.title,
    required this.filePath,
    required this.originalUrl,
    required this.savedDate,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'filePath': filePath,
      'originalUrl': originalUrl,
      'savedDate': savedDate.toIso8601String(),
      'description': description,
    };
  }

  factory SavedDocument.fromJson(Map<String, dynamic> json) {
    return SavedDocument(
      id: json['id'] as String,
      title: json['title'] as String,
      filePath: json['filePath'] as String,
      originalUrl: json['originalUrl'] as String,
      savedDate: DateTime.parse(json['savedDate'] as String),
      description: json['description'] as String?,
    );
  }
}

class SavedDocumentsService {
  static const String _savedDocumentsKey = 'saved_documents';
  static const String _savedDocumentsDir = 'saved_documents';

  // Get saved documents directory in app storage
  static Future<Directory> _getSavedDocumentsDirectory() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final savedDir = Directory('${appDocDir.path}/$_savedDocumentsDir');
    if (!await savedDir.exists()) {
      await savedDir.create(recursive: true);
    }
    return savedDir;
  }

  // Save a document to app storage and add to saved documents list
  static Future<bool> saveDocument({
    required String title,
    required String originalUrl,
    required File sourceFile,
    String? description,
  }) async {
    try {
      final savedDir = await _getSavedDocumentsDirectory();
      
      // Generate unique ID and filename
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final sanitizedName = title
          .replaceAll(RegExp(r"[^\w\s-]"), "")
          .replaceAll(RegExp(r"\s+"), "_");
      final fileName = '${id}_$sanitizedName.pdf';
      final savedFilePath = '${savedDir.path}/$fileName';

      // Copy file to saved documents directory
      final savedFile = await sourceFile.copy(savedFilePath);
      
      // Create SavedDocument object
      final savedDoc = SavedDocument(
        id: id,
        title: title,
        filePath: savedFile.path,
        originalUrl: originalUrl,
        savedDate: DateTime.now(),
        description: description,
      );

      // Get existing saved documents
      final prefs = await SharedPreferences.getInstance();
      final savedDocsJson = prefs.getStringList(_savedDocumentsKey) ?? [];
      final savedDocs = savedDocsJson
          .map((json) => SavedDocument.fromJson(
              jsonDecode(json) as Map<String, dynamic>))
          .toList();

      // Check if document with same URL already exists
      if (savedDocs.any((doc) => doc.originalUrl == originalUrl)) {
        return false; // Document already saved
      }

      // Add new document
      savedDocs.add(savedDoc);

      // Save back to SharedPreferences
      final updatedJson = savedDocs
          .map((doc) => jsonEncode(doc.toJson()))
          .toList();
      await prefs.setStringList(_savedDocumentsKey, updatedJson);

      return true;
    } catch (e) {
      print('Error saving document: $e');
      return false;
    }
  }

  // Get all saved documents
  static Future<List<SavedDocument>> getSavedDocuments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedDocsJson = prefs.getStringList(_savedDocumentsKey) ?? [];
      
      final savedDocs = savedDocsJson
          .map((json) => SavedDocument.fromJson(
              jsonDecode(json) as Map<String, dynamic>))
          .toList();

      // Filter out documents whose files no longer exist
      final validDocs = <SavedDocument>[];
      for (final doc in savedDocs) {
        final file = File(doc.filePath);
        if (await file.exists()) {
          validDocs.add(doc);
        } else {
          // Remove from list if file doesn't exist
          await deleteDocument(doc.id);
        }
      }

      // Sort by saved date (newest first)
      validDocs.sort((a, b) => b.savedDate.compareTo(a.savedDate));

      return validDocs;
    } catch (e) {
      print('Error getting saved documents: $e');
      return [];
    }
  }

  // Delete a saved document
  static Future<bool> deleteDocument(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedDocsJson = prefs.getStringList(_savedDocumentsKey) ?? [];
      
      final savedDocs = savedDocsJson
          .map((json) => SavedDocument.fromJson(
              jsonDecode(json) as Map<String, dynamic>))
          .toList();

      // Find and remove the document
      final docToDelete = savedDocs.firstWhere(
        (doc) => doc.id == id,
        orElse: () => savedDocs.first, // Fallback (shouldn't happen)
      );

      // Delete the file
      try {
        final file = File(docToDelete.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('Error deleting file: $e');
      }

      // Remove from list
      savedDocs.removeWhere((doc) => doc.id == id);

      // Save back to SharedPreferences
      final updatedJson = savedDocs
          .map((doc) => jsonEncode(doc.toJson()))
          .toList();
      await prefs.setStringList(_savedDocumentsKey, updatedJson);

      return true;
    } catch (e) {
      print('Error deleting document: $e');
      return false;
    }
  }

  // Check if a document is already saved
  static Future<bool> isDocumentSaved(String originalUrl) async {
    try {
      final savedDocs = await getSavedDocuments();
      return savedDocs.any((doc) => doc.originalUrl == originalUrl);
    } catch (e) {
      return false;
    }
  }

  // Get document by ID
  static Future<SavedDocument?> getDocumentById(String id) async {
    try {
      final savedDocs = await getSavedDocuments();
      try {
        return savedDocs.firstWhere((doc) => doc.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
