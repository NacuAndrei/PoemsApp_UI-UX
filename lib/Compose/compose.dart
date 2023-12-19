import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poetry_app/Compose/preview.dart';

class Compose extends StatefulWidget {
  const Compose({ Key? key }) : super(key: key);

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {

  String? title;
  File? imageFile;
  String? poem;

  // Key used to identify the form. Used for validation
  final _formKey = GlobalKey<FormState>();

  // ImagePicker
  final picker = ImagePicker();
  chooseImage(ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if(pickedFile!=null) {
        imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compose')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [

            // Title
            const Padding(
              padding: EdgeInsets.all(5),
              child:
              Text(
                'Title',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              onChanged: (text){
                title = text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter a title...',
                hintStyle: TextStyle(color: Color.fromARGB(179, 129, 129, 129)),
                border: OutlineInputBorder(),

              ),
            ),
            const SizedBox(height: 15, width: null),

            // Image
            const Padding(
              padding: EdgeInsets.all(5),
              child:
              Text(
                'Image(optional)',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            imageFile != null ? // Check if an image was picked
            // if true: display that image
            Padding(
                padding: const EdgeInsets.all(5),
                child:
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Image.file(imageFile!),
                )
            ):
            // if false: don't show anything
            Container(),

            // Select an image
            ElevatedButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),

              onPressed: () {
                chooseImage(ImageSource.gallery);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Icon(
                    Icons.image_outlined,
                    size: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Select an image',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15, width: null),

            // Poem
            const Padding(
              padding: EdgeInsets.all(5),
              child:
              Text(
                'Poem',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              onChanged: (text){
                poem = text;
              },
              validator: (value) {
                if (value == null || value.length < 20) {
                  return 'Poem must have at least 20 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                ),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20, width: null),

            // Buttons
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child:
              Row(
                children: [

                  // Clear form button
                  SizedBox(
                      width: 130,
                      child:
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),

                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => const Compose(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );

                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.refresh,
                              size: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Clear',
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      )
                  ),

                  const Spacer(),

                  //Preview button
                  SizedBox(
                      width: 130,
                      child:
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),

                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => Preview(title: title, imageFile: imageFile, poem: poem,))
                            );
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Preview',
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ],
                        ),
                      )
                  ),


                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}