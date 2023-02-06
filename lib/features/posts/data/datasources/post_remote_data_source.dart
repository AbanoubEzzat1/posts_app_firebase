// ignore_for_file: avoid_function_literals_in_foreach_calls

// import 'dart:convert';
// import 'package:http/http.dart';
//import '../../../../core/error/exception.dart';
// import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app_fire/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> deletePost(String postId);
  Future<Unit> updatePost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  List<PostModel> postModelList = [];
  @override
  Future<List<PostModel>> getAllPosts() async {
    await FirebaseFirestore.instance.collection("posts").get().then((value) {
      postModelList = []; // Cose of repeating List
      value.docs.forEach((element) {
        postModelList.add(PostModel.fromJson(element.data()));
      });
    });
    return postModelList;
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    postModel = PostModel(
        id: postModel.id, title: postModel.title, body: postModel.body);
    await FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toJson())
        .then((value) {
      value.update(postModel.toJson()
        ..addAll({
          "id": value.id,
          "title": postModel.title,
          "body": postModel.body,
        }));
    });
    return Future.value(unit);
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    postModel = PostModel(
        id: postModel.id, title: postModel.title, body: postModel.body);
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postModel.id)
        .update(postModel.toJson());
    return Future.value(unit);
  }

  @override
  Future<Unit> deletePost(String postId) async {
    await FirebaseFirestore.instance.collection("posts").doc(postId).delete();
    return Future.value(unit);
  }
}



// const BASE_URL = "https://jsonplaceholder.typicode.com";

// class PostRemoteDataSourceImpl extends PostRemoteDataSource {
//   final http.Client client;

//   PostRemoteDataSourceImpl({required this.client});
//   @override
//   Future<List<PostModel>> getAllPosts() async {
//     final response = await client.get(
//       Uri.parse(BASE_URL + "/posts/"),
//       headers: {"Content-Type": "application/json"},
//     );
//     if (response.statusCode == 200) {
//       final List decodedJson = json.decode(response.body) as List;
//       final List<PostModel> postModels = decodedJson
//           .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
//           .toList();

//       return postModels;
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<Unit> addPost(PostModel postModel) async {
//     final body = {
//       "title": postModel.title,
//       "body": postModel.body,
//     };
//     final response =
//         await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);
//     if (response.statusCode == 201) {
//       return Future.value(unit);
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<Unit> deletePost(int postId) async {
//     final response = await client.delete(
//       Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
//       headers: {"Content-Type": "application/json"},
//     );

//     if (response.statusCode == 200) {
//       return Future.value(unit);
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<Unit> updatePost(PostModel postModel) async {
//     final postId = postModel.id.toString();
//     final body = {
//       "title": postModel.title,
//       "body": postModel.body,
//     };

//     final response = await client.patch(
//       Uri.parse(BASE_URL + "/posts/$postId"),
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       return Future.value(unit);
//     } else {
//       throw ServerException();
//     }
//   }
// }
