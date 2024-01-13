import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Compose/compose.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Services/DataService.dart';

class Preview extends StatelessWidget {
  final String? title;
  final File? imageFile;
  final String? poem;

  final String author =
      GetIt.instance<AuthService>().getUserDisplayName() ?? "Unknown";

  final String userId = GetIt.instance<AuthService>().getUserId() ?? "";

  Preview({
    Key? key,
    required this.title,
    required this.imageFile,
    required this.poem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15, width: null),

            // Image
            imageFile != null
                ? // Check if an image was picked
                // if true: display that image
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Image.file(imageFile!),
                        )))
                :
                // if false: don't show anything
                Container(),
            const SizedBox(height: 15, width: null),

            // Poem
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
              child: Text(
                poem!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            // Author
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child: Text(
                "- $author",
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
            ),

            //Submit button
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                onPressed: () {
                  // Add poem to database
                  GetIt.instance<DataService>().addPoemDraft(
                      userId,
                      PoemModel(
                          title: title ?? "Untitled", content: poem ?? ""),
                      imageFile);

                  // Clear poem and return to compose page
                  Navigator.pop(context, true);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
