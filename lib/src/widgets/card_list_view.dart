import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';

class CardListView extends StatefulWidget {
  @required
  final List<Task> cardList;

  const CardListView({Key key, this.cardList}) : super(key: key);

  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    int cardIndex = 0;
    AnimationController animationController;
    ColorTween colorTween;
    CurvedAnimation curvedAnimation;
    Color currentColor = widget.cardList[cardIndex].color;
    ScrollController scrollController = new ScrollController();

    return Scaffold(
        //backgroundColor: widget.cardList[cardIndex].color,
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('PINE', style: TextStyle(fontSize: 24.0)),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.help),
            ),
          ],
          elevation: 0.0,
        ),
        drawer: Drawer(),
        body: Container(
            child: Column(
          children: <Widget>[
            header(),
            Expanded(
                flex: 10,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.cardList.length + 2,
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                        child: cardDetails(position),
                        onHorizontalDragEnd: (details) {
                          animationController = AnimationController(
                              vsync: this,
                              duration: Duration(milliseconds: 500));
                          curvedAnimation = CurvedAnimation(
                              parent: animationController,
                              curve: Curves.fastOutSlowIn);
                          animationController.addListener(() {
                            setState(() {
                              currentColor =
                                  colorTween.evaluate(curvedAnimation);
                            });
                          });

                          setState(() {
                            if (details.velocity.pixelsPerSecond.dx > 0) {
                              if (cardIndex > 0) {
                                cardIndex--;
                                colorTween = ColorTween(
                                    begin: currentColor,
                                    end: widget.cardList[cardIndex].color);
                              }
                            } else {
                              if (cardIndex < widget.cardList.length) {
                                cardIndex++;
                                colorTween = ColorTween(
                                    begin: currentColor,
                                    end: widget.cardList[cardIndex].color);
                              }
                            }
                            print("CARD INDEX: " + cardIndex.toString());
                            scrollController.animateTo((cardIndex) * 256.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          });

                          colorTween.animate(curvedAnimation);

                          animationController.forward();
                        });
                  },
                ))
          ],
        )));
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                  child: Text(
                    "Hello, Nathan.",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
                Text(
                  "Insert quote of the day here.",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  "You have " +
                      widget.cardList.length.toString() +
                      " tasks to do today.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget cardDetails(int position) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            width: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.details,
                        color: widget.cardList[position].color,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(widget.cardList[position].description),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          widget.cardList[position].title,
                          style: TextStyle(
                              fontSize: 28.0,
                              color: widget.cardList[position].color),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ));
  }
}
