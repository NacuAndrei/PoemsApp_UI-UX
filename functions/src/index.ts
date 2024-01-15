import * as functions from "firebase-functions";

import {
  initializeApp,
} from "firebase-admin/app";

import {
  getFirestore,
} from "firebase-admin/firestore";
import {log} from "firebase-functions/logger";

initializeApp();

const db = getFirestore();

const userIdsRef = db.collection("Poems").listDocuments();

// Function that starts a cascade delete when a public poem is deleted
exports.deletePublicPoem = functions.firestore
    .document("PublicPoems/{poemId}")
    .onDelete(async (snap, context) => {
      const poemId = context.params.poemId;

      const userIds = (await userIdsRef).map((user) => user.id);

      for (const userId of userIds) {
        try {
          db.collection("Poems").doc(userId)
              .collection("Favourites").doc(poemId)
              .delete();
        } catch (error) {
          log(error);
        }
      }
    });
