import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poetry_app/Compose/compose.dart';


class Preview extends StatelessWidget {
  final String? title;
  final File? imageFile;
  final String? poem;

  // TODO: get current username
  final String author = "Author Name";

  const Preview({ Key? key, required this.title, required this.imageFile, required this.poem, }) : super(key: key);

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
            imageFile != null ? // Check if an image was picked
            // if true: display that image
            Padding(
                padding: const EdgeInsets.all(5),
                child:
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: Image.file(imageFile!),
                    )
                )
            ):
            // if false: don't show anything
            Container(),
            const SizedBox(height: 15, width: null),

            // Poem
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
              child:
              Text(
                poem!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            // Author
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child:
              Text(
                "-$author",
                style: const TextStyle(
                    fontSize: 20,

                    fontStyle: FontStyle.italic
                ),
              ),
            ),

            //Submit button
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child:
              ElevatedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                onPressed: () {

                  // TODO: add poem to database

                  // Clear poem and return to compose page
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => Compose(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: const Text('Submit',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}