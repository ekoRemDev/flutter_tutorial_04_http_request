import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// TODO 00 - Fetch data from the internet
// TODO 01 - Add the http package
    // TODO 01.1 Add package into pubspec.yaml file
    /*
    dependencies:
  http: <latest_version>

Import the http package.

import 'package:http/http.dart' as http;

     */

// TODO 02 - Make a network request
// TODO 03 - Convert the response into a custom Dart object
// TODO 04 - Fetch the data
// TODO 05 - Display the data




// TODO 02.1 fetch a sample post from the JSONPlaceholder using the http.get() method.
/*
The http.get() method returns a Future that contains a Response.

    * Future is a core Dart class for working with async operations. A Future object represents a potential value or error that will be available at some time in the future.
    * The http.Response class contains the data received from a successful http call.

 */
Future<Post> fetchPost() async {
    // TODO 03.2
    /*
    Now, use the following steps to update the fetchPost() function to return a Future<Post>:

    Convert the response body into a JSON Map with the dart:convert package.
    If the server returns an “OK” response with a status code of 200, convert the JSON Map into a Post using the fromJson() factory method.
    If the server returns an unexpected response, throw an error.

     */
    final response =  await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        return Post.fromJson(json.decode(response.body));
    } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
    }
}

// TODO 03.1 Create a Post class
class Post {
    final int userId;
    final int id;
    final String title;
    final String body;

    Post({this.userId, this.id, this.title, this.body});

    factory Post.fromJson(Map<String, dynamic> json) {
        return Post(
            userId: json['userId'],
            id: json['id'],
            title: json['title'],
            body: json['body'],
        );
    }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
    MyApp({Key key}) : super(key: key);

    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Future<Post> post;

    // TODO 04.1 Fetch data
    /*
    Call the fetch method in either the initState() or didChangeDependencies() methods.

    *The initState() method is called exactly once and then never again.
        If you want to have the option of reloading the API in response to an InheritedWidget
        changing, put the call into the didChangeDependencies() method. See State for more details.

     */
    @override
    void initState() {
        super.initState();
        post = fetchPost();
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Fetch Data Example',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: Scaffold(
                appBar: AppBar(
                    title: Text('Fetch Data Example'),
                ),
                body: Center(
                    child: FutureBuilder<Post>(
                        future: post,
                        builder: (context, snapshot) {
                            if (snapshot.hasData) {
                                return Text(snapshot.data.title);
                            } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                            }

                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                        },
                    ),
                ),
            ),
        );
    }
}

/*

To to display the data on screen, use the FutureBuilder widget.
The FutureBuilder widget comes with Flutter and makes it easy to work with async data sources.

You must provide two parameters:
    * The Future you want to work with. In this case, the future returned from the fetchPost() function.
    * A builder function that tells Flutter what to render, depending on the state of the Future: loading, success, or error.

 */