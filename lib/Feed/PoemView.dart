import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Models/PublishedPoemModel.dart';
import 'package:intl/intl.dart';
import '../Auth/Services/AuthService.dart';
import '../Data/Services/DataService.dart';

class PoemView extends StatefulWidget {
  final PoemModel poem;
  late final bool isDraft;
  PoemView({super.key, required this.poem}) {
    isDraft = poem is! PublishedPoemModel;
  }

  @override
  State<PoemView> createState() => _PoemViewState();
}

class _PoemViewState extends State<PoemView> {
  bool isFavourited = false;

  @override
  void initState() {
    if (!widget.isDraft) {
      () async {
        String? userId = GetIt.instance<AuthService>().getUserId();
        if (userId == null || widget.poem.id == null) {
          throw Exception("User or poem id is null in initState");
        }
        bool _isFavourited = await GetIt.instance<DataService>()
            .isPoemFavourited(userId, widget.poem.id as String);
        setState(() {
          isFavourited = _isFavourited;
        });
      }();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _getPublishButton(),
          _getFavouriteButton(),
          _getDeleteButton(context)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _getTitleWidget(),
              _getAuthorWidget(),
              _getImageWidget(),
              _getContentWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitleWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: Text(
          widget.poem.title,
          textScaleFactor: 1.65,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getAuthorWidget() {
    return widget.isDraft
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("by"),
                    const SizedBox(width: 5.0),
                    Text(
                      (widget.poem as PublishedPoemModel).user.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("at"),
                    const SizedBox(width: 5.0),
                    Text(
                      DateFormat('dd/MM/yyyy hh:mm').format(
                          (widget.poem as PublishedPoemModel)
                              .publishedDate
                              .toDate()),
                    ),
                  ],
                )
              ],
            ),
          );
  }

  Widget _getContentWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: Text(
            widget.poem.content,
          ),
        ));
  }

  Widget _getImageWidget() {
    return widget.poem.photoURL != null
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(widget.poem.photoURL as String),
            ),
          )
        : Container();
  }

  Widget _getPublishButton() {
    if (widget.isDraft && !widget.poem.isPublished) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10.0)),
          onPressed: () => _showPublishDialog(context),
          child: const Text("Publish"),
        ),
      );
    } else {
      return Container();
    }
  }

  void _showPublishDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        bool processingPublish = false;
        return StatefulBuilder(
          builder: (context, setState) {
            if (processingPublish) {
              return const SimpleDialog(
                children: [Center(child: CircularProgressIndicator())],
              );
            }

            return AlertDialog(
              title: const Text("Are you sure you want to publish the poem?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () async {
                      var user = GetIt.instance
                          .get<AuthService>()
                          .getCurrentUserData();
                      if (user != null) {
                        setState(() => processingPublish = true);
                        GetIt.instance
                            .get<DataService>()
                            .publishPoem(widget.poem, user);
                        setState(() => processingPublish = false);
                      }

                      if (mounted) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Poem published!'),
                          ),
                        );
                      }
                    },
                    child: const Text("Publish"))
              ],
            );
          },
        );
      },
    );
  }

  Widget _getFavouriteButton() {
    if (widget.isDraft) {
      return Container();
    }
    return IconButton(
      icon: Icon(isFavourited ? Icons.bookmark : Icons.bookmark_outline),
      tooltip: isFavourited ? "Remove from favourites" : "Add to favourites",
      onPressed: () async {
        String? userId = GetIt.instance<AuthService>().getUserId();
        if (userId == null || widget.poem.id == null) {
          throw Exception("User or poem id is null");
        }
        if (isFavourited) {
          await GetIt.instance<DataService>()
              .removePoemFromFavourites(userId, widget.poem.id as String);
        } else {
          await GetIt.instance<DataService>()
              .addPoemToFavourites(userId, widget.poem.id as String);
        }

        setState(() {
          isFavourited = !isFavourited;
        });
      },
    );
  }

  Widget _getDeleteButton(BuildContext context) {
    final String userId = GetIt.instance<AuthService>().getUserId() ?? "";
    final bool userIsAuthor = widget.isDraft ||
        (widget.poem as PublishedPoemModel).user.userId == userId;

    // if current user is not the author, dont display button
    if (!userIsAuthor) {
      return Container();
    }

    // TO DO: remove this after we can delete public poems from firestore
    if (!widget.isDraft || widget.poem.isPublished) {
      return Container();
    }

    // its either user's draft or published poem
    return ElevatedButton(
      onPressed: () {
        _showDeleteDialog(context);
      },
      child: const Text("Delete"),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final String userId = GetIt.instance<AuthService>().getUserId() ?? "";

    showDialog(
      context: context,
      builder: (context) {
        bool processingDelete = false;
        return StatefulBuilder(
          builder: (context, setState) {
            if (processingDelete) {
              return const SimpleDialog(
                children: [Center(child: CircularProgressIndicator())],
              );
            }

            return AlertDialog(
              title: const Text("Are you sure you want to delete the poem?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () async {
                      // disable button until poem is deleted
                      setState(() => processingDelete = true);

                      // delete unpublished draft
                      if (widget.isDraft && widget.poem.isPublished == false) {
                        await GetIt.instance<DataService>()
                            .deleteDraft(userId, widget.poem.id as String);
                      }
                      // delete published poem/draft
                      if (!widget.isDraft || widget.poem.isPublished) {
                        // disable button until poem is deleted
                        await GetIt.instance<DataService>()
                            .deleteDraft(userId, widget.poem.id as String);
                      }

                      setState(() => processingDelete = false);

                      if (mounted) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Poem deleted!'),
                          ),
                        );
                      }
                    },
                    child: const Text("Delete"))
              ],
            );
          },
        );
      },
    );
  }
}
