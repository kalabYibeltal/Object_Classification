import 'package:flutter/material.dart';
import 'package:untitled1/camera_page.dart';
import 'package:camera/camera.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "5 kilo Garden", "location": "south side of 5 kilo"},
    {"id": 2, "name": "Unity park", "location":"South of 4 kilo palace"},
    {"id": 3, "name": "4 kilo Green Area", "location": "West block of main campus"},
    {"id": 4, "name": "Friendship Park", "location": "East of 4 kilo palace"},
    {"id": 5, "name": "6 kilo museum", "location": "North of the main dormitory"},
    {"id": 5, "name": "6 kilo cafeteria", "location": "North of the Kennedy library"},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {

    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
      setState(() {
        _foundUsers = results;
      });
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
          setState(() {
            _foundUsers = results;
          });
      // we use the toLowerCase() method to make it case-insensitive
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text('Available locations'),
        centerTitle: true,
        backgroundColor: Colors.grey[800]
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                print(value);
                return _runFilter(value);
              },
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.grey[600],
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    onTap: () async {
                      await availableCameras().then(
                            (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(cameras: value,),
                          ),
                        ),
                      );
                    },
                    title: Text(_foundUsers[index]['name'],
                        style:TextStyle(
                        color:Colors.white,
                        fontSize: 21,
                        )
                    ),
                    subtitle: Text(
                        '${_foundUsers[index]["location"].toString()}',style:TextStyle(
                        fontSize: 15,
                        color:Colors.white
                    )),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
//
// class ChooseLocation extends StatefulWidget {
//   @override
//   _ChooseLocationState createState() => _ChooseLocationState();
// }
//
// class _ChooseLocationState extends State<ChooseLocation> {
//
//   List locations = [ "5 kilo Garden", "Unity park", "4 kilo Green Area","Friendship Park", "6 kilo museum"];
//
//   @override
//   Widget build(BuildContext context) {
//       return Scaffold(
//         backgroundColor: Colors.grey[400],
//         appBar: AppBar(
//           backgroundColor: Colors.grey[800],
//           title: Text('Choose a Location'),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: ListView.builder(
//           itemCount: locations.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
//               child: Card(
//                 child: ListTile(
//                   onTap: () async {
//                     await availableCameras().then(
//                           (value) => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CameraPage(cameras: value,),
//                         ),
//                       ),
//                     );
//                   },
//                   title: Text(locations[index]),
//                 ),
//               ),
//             );
//           }
//         ),
//       );
//
//   }
// }
