import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';

class Poem extends StatelessWidget {
  final PoemModel poem;
  const Poem({super.key, required this.poem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 24),
          _getTitleWidget(),
          const SizedBox(height: 16),
          _getAuthorWidget(),
          const SizedBox(height: 16),
          _getImageWidget(),
          const SizedBox(height: 16),
          Center(
              child: Text(
            poem.content,
          )),
        ],
      ),
    );
  }

  Widget _getTitleWidget() {
    return Center(
      child: Text(
        poem.title,
        textScaleFactor: 1.65,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _getAuthorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("by"),
        SizedBox(width: 5.0),
        Text(
          "Mihai Eminescu",
          style: TextStyle(fontWeight: FontWeight.bold),
          textScaleFactor: 1.2,
        ),
      ],
    );
  }

  Widget _getImageWidget() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.network(
          "https://www.photobox.co.uk/blog/wp-content/uploads/2017/05/grandangle_05_1920px.jpg"),
    );
  }
}
