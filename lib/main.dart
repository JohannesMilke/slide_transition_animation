import 'package:flutter/material.dart';
import 'package:slide_transition_animation/utils.dart';
import 'package:slide_transition_animation/widget/slidable_widget.dart';

import 'data.dart';
import 'model/chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'SlideTransition Animation';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.pink),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Chat> items = List.of(Data.chats);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(12),
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final item = items[index];

            return SlidableWidget(
              child: buildListTile(item),
              background: buildBackground(),
              onSlided: () {
                setState(() {
                  item.isFavourite = !item.isFavourite;
                });

                Utils.showSnackBar(context,
                    'You have ${item.isFavourite ? 'LIKED' : 'UNLIKED'} your chat partner.');
              },
            );
          },
        ),
      );

  Widget buildBackground() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.black.withOpacity(0.1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.favorite_border,
          size: 32,
          color: Colors.white,
        ),
      );

  Widget buildListTile(Chat item) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          leading: Stack(
            overflow: Overflow.visible,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(item.urlAvatar),
              ),
              if (item.isFavourite)
                Positioned(
                  child: buildHeart(),
                  left: -4,
                  top: -6,
                ),
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                item.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          onTap: () {},
        ),
      );

  Widget buildHeart() => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.red),
        ),
        padding: EdgeInsets.all(2),
        child: Icon(Icons.favorite, color: Colors.red, size: 16),
      );
}
