import 'package:flutter/material.dart';

class ProfileDashBoard extends StatefulWidget {
  @override
  _ProfileDashBoardState createState() => _ProfileDashBoardState();
}

class _ProfileDashBoardState extends State<ProfileDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Spacer(),
          Text(
            "My Profile",
            style:
                Theme.of(context).textTheme.headline.apply(color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "assets/logo.png",
                            height: 35,
                            width: 35,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "Mr. Obong",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .apply(color: Colors.blue, fontWeightDelta: 2),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "3191",
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .apply(color: Colors.blue, fontWeightDelta: 2),
                          ),
                          TextSpan(
                            text: "meals bought.",
                            style: Theme.of(context).textTheme.body2.apply(
                                  color: Colors.blue,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    color: Colors.redAccent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Next meal: ",
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .apply(color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "28",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .apply(color: Colors.white),
                        ),
                        Text(
                          "Nov",
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .apply(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "My Reservations",
            style:
                Theme.of(context).textTheme.headline.apply(color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              "assets/fs3.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("eba",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Text(
                                    "28th Nov.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .apply(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}