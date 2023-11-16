import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final int? age;
  final int? dob;
  final List<String>? favMathematicians;
  final List<String>? favBooks;
  final List<String>? favProblems;
  final List<String>? mistakeCollections;
  final List<String>? preferredSubjects;
  final List<String>? posts;
  final String? gender;
  final String? motto;
  final String? pronouns;
  final String? selfIntro;

  Users({
    this.age,
    this.dob,
    this.favMathematicians,
    this.favBooks,
    this.favProblems,
    this.mistakeCollections,
    this.preferredSubjects,
    this.posts,
    this.gender,
    this.motto,
    this.pronouns,
    this.selfIntro
  });

  factory Users.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Users(
        age: data?["Age"] ?? 16,
        dob: data?["DOB"] ?? 2006,
        favMathematicians: data?['favMathematicians'] is Iterable ? List.from(data?['favMathematicians']) : null,
        favBooks: data?['favMathematicians'] is Iterable ? List.from(data?['favMathematicians']) : null,
        favProblems: data?['favProblems'] is Iterable ? List.from(data?['favProblems']) : null,
        mistakeCollections: data?['mistakeCollections'] is Iterable ? List.from(data?['mistakeCollections']) : null,
        preferredSubjects: data?['preferredSubjects'] is Iterable ? List.from(data?['preferredSubjects']) : null,
        posts: data?['posts'] is Iterable ? List.from(data?['posts']) : null,
        gender: data?["gender"] ?? "Preferred Not to Display",
        motto: data?["motto"] ?? "Nothing to Display",
        pronouns: data?["pronouns"] ?? "Preferred Not to Display",
        selfIntro: data?["selfIntro"] ?? "Nothing to Display",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (age != null) "age": age,
      if (dob != null) "dob": dob,
      if (favMathematicians != null) "favMathematicians": favMathematicians,
      if (favBooks != null) "favBooks": favBooks,
      if (favProblems != null) "favProblems": favProblems,
      if (mistakeCollections != null) "mistakeCollections": mistakeCollections,
      if (preferredSubjects != null) "preferredSubjects": preferredSubjects,
      if (posts != null) "posts": posts,
      if (gender != null) "gender": gender,
      if (motto != null) "motto": motto,
      if (pronouns != null) "pronouns": pronouns,
      if (selfIntro != null) "regions": selfIntro,
    };
  }
}
