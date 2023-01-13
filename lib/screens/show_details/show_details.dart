import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowDetailPage extends StatefulWidget {
  final double heigth;
  final double width;
  final double padding;

  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const ShowDetailPage(
      {Key? key,
      required this.heigth,
      required this.width,
      required this.padding,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content})
      : super(key: key);

  @override
  State<ShowDetailPage> createState() => ShowtDetailStatePage();
}

class ShowtDetailStatePage extends State<ShowDetailPage> {



  @override
  Widget build(BuildContext context) {


    DateTime dateObj = DateTime.parse(widget.publishedAt);
    String articleDate = formatDate(dateObj, [M, ' ', d]);



    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: widget.width * 0.04),
              child: GestureDetector(
                onTap: () => Share.share(widget.url, subject: widget.title),
                child: const Icon(Icons.share),
              ),
            )
          ],
          title: SizedBox(child: Text(widget.title)),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                 CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) =>
                        Image.asset('assets/images/placeholder.png'),
                    imageUrl: widget.urlToImage,
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/placeholder.png'),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(widget.heigth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child:   Text(
                            "Article by : ${widget.author}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(150, 150, 150, 1),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            articleDate ?? " ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(150, 150, 150, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.description,
                      maxLines: 50,
                      style: TextStyle(
                        fontSize: 19
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      widget.content,
                      maxLines: 50,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.width * 0.3),
                child: ElevatedButton(
                  onPressed: () => _launchURL(widget.url),
                  child: const Text('Go To The Source'),
                ),
              ),
            ],
          ),
        ));
  }
}

_launchURL(url) async {
  var _url = Uri.parse(url);
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}
