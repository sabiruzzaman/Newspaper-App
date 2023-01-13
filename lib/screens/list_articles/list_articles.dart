import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newspaper_app/constants/colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/news/news_bloc.dart';
import '../../bloc/news/news_event.dart';
import '../../bloc/news/news_state.dart';
import '../../widgets/news_list_widgets.dart';
import 'category_button.dart';
import '../../model/article_model.dart';
import '../../repository/news_repository.dart';

class ListArticles extends StatefulWidget {
  const ListArticles({Key? key}) : super(key: key);

  @override
  State<ListArticles> createState() => _ListArticlesState();
}

class _ListArticlesState extends State<ListArticles> {
  String currentHeading = "Top Headlines";
  int selectedButtonID = 1;
  String selectedCategory = "topheadlines";
  List<bool> buttonStatus = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final NewsRepository repository = NewsRepository();
  String selectedCountryCode = "us";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => context.read<AuthBloc>().add(SignOutRequested()),
              child: const Icon(Icons.logout),
            ),
          )
        ],
        title: const Text("Newspaper App"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.only(
                  bottom: width * 0.02,
                  top: width * 0.02,
                  left: width * 0.015,
                  right: width * 0.015),
              scrollDirection: Axis.horizontal,
              children: [
                CategoryButton(
                  category: "topheadlines",
                  country: selectedCountryCode,
                  buttonID: 0,
                  isSelected: buttonStatus[0],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "business",
                  country: selectedCountryCode,
                  buttonID: 1,
                  isSelected: buttonStatus[1],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "entertainment",
                  country: selectedCountryCode,
                  buttonID: 2,
                  isSelected: buttonStatus[2],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "general",
                  country: selectedCountryCode,
                  buttonID: 3,
                  isSelected: buttonStatus[3],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "health",
                  country: selectedCountryCode,
                  buttonID: 4,
                  isSelected: buttonStatus[4],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "science",
                  country: selectedCountryCode,
                  buttonID: 5,
                  isSelected: buttonStatus[5],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "sports",
                  country: selectedCountryCode,
                  buttonID: 6,
                  isSelected: buttonStatus[6],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "technology",
                  country: selectedCountryCode,
                  buttonID: 7,
                  isSelected: buttonStatus[7],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 14,
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitialState) {
                  context
                      .read<NewsBloc>()
                      .add(GetArticlesEvent(categoryName: 'topheadlines'));
                } else if (state is NewsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: blue,
                    ),
                  );
                } else if (state is NewsSuccessState) {
                  return RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<NewsBloc>(context).add(
                          GetArticlesEvent(
                              categoryName: selectedCategory,
                              countryName: selectedCountryCode),
                        );
                      },
                      child: buildArticles(context, state.articles));
                } else if (state is NewsErrorState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<NewsBloc>(context).add(
                        GetArticlesEvent(
                            categoryName: selectedCategory,
                            countryName: selectedCountryCode),
                      );
                    },
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.error_outline),
                        Text("Connection Error!"),
                      ],
                    )),
                  );
                }
                return const Center(child: Text('Something Else Happened!'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArticles(BuildContext context, List<Article>? articles) {
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
              padding: EdgeInsets.only(
                  left: width * 0.025, right: width * 0.025, top: width * 0.01),
              itemCount: articles!.length,
              itemBuilder: ((context, index) {
                return NewsListWidgets(
                  heigth: heigth * 0.451,
                  width: width,
                  padding: width * 0.03,
                  title: articles[index].title,
                  description: articles[index].description,
                  author: articles[index].author,
                  content: articles[index].content,
                  publishedAt: articles[index].publishedAt,
                  url: articles[index].url,
                  urlToImage: articles[index].urlToImage,
                );
              })),
        ),
      ],
    );
  }

  void putOffOtherButtons(List<bool> buttonStatus) {
    for (int i = 0; i < buttonStatus.length; i++) {
      if (i != selectedButtonID) {
        buttonStatus[i] = false;
      }
    }
    buttonStatus[selectedButtonID] = true;
    if (selectedCategory[1] == 'o') {
      currentHeading = 'Top Headlines';
    } else {
      selectedCategory = currentHeading =
          selectedCategory[0].toUpperCase() + selectedCategory.substring(1);
    }
  }
}
