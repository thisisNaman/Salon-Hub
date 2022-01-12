import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/models/product.dart';
import 'package:salon_hub/screens/details/details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:salon_hub/screens/home/components/search_field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert' as convert;
import '../../size_config.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  static String routeName = "/productScreen";

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> futureTools;
  late Future<List<Product>> futureSkinProducts;

  PanelController _panelController = PanelController();
  String query = '';
  TextEditingController controller = TextEditingController();
  String skinProductsUrl =
      'https://script.googleusercontent.com/macros/echo?user_content_key=CaXIIUbFY7SfdLnVZ5OKNybJQ5kOxw5MRbLwldSQHcFRdhKp3Qmlwrziypd0Tdk_D_aDCsB0HAPOr_YZd5qX3BB5t0doJB6Fm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnN-YcBRED6waZynZPHaqU3mGEzRkjdzhrukYJoOLghm8PQtQAhJWH1fEDmZVs2ppNfuAFaAplf4rPf7jH2mY9R64omobYZfI4A&lib=M4elQ9gFf_LU9I1Zjf_JLDNmPTUpaVvRV';
  String toolsUrl =
      'https://script.google.com/macros/s/AKfycbw-idkLlPqBOIagrHbaJ3q3iUABWTBCiNIAXr9vuxdIv5hN9ujKfNXvMl_CWtGEAfXNxA/exec';

  bool _showBar = true;
  ScrollController _scrollController = ScrollController();
  bool _isScrollingDown = false;
  bool _show = true;
  List<String> skinCategory = ["all", "wella", "vedicline", "cacau", "raaga"];
  List<String> toolsCategory = ["all", "ikonic", "wahl"];
  Map<String, int> skC = {"wella": 1, "vedicline": 0, "cacau": 0, "raaga": 0};
  Map<String, int> tC = {
    "ikonic": 1,
    "wahl": 0,
  };
  int _skinValue = 0;
  int _toolValue = 0;
  String page = '1';
  @override
  void initState() {
    super.initState();
    futureTools = _getTools(toolsUrl, '', 0);
    futureSkinProducts = _getTools(skinProductsUrl, '', 0);
    myScroll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  void showBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBar() {
    setState(() {
      _show = false;
    });
  }

  void myScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          _showBar = false;
          hideBar();
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _showBar = true;
          showBar();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String ctg = ModalRoute.of(context)!.settings.arguments.toString();
    page = ctg;
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              _showBar
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SearchField(onChanged: (val) {
                        setState(() {
                          futureTools = _getTools(toolsUrl, val, 0);
                          futureSkinProducts =
                              _getTools(skinProductsUrl, val, 0);
                        });
                      }),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(17)),
                  child: Scrollbar(
                      isAlwaysShown: false,
                      radius: const Radius.circular(10.0),
                      child: FutureBuilder(
                          future: ctg == '1' ? futureSkinProducts : futureTools,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, DetailsScreen.routeName,
                                            arguments: ProductDetailsArguments(
                                                product: Product(
                                                    id: snapshot
                                                        .data![index].id,
                                                    category: snapshot
                                                        .data![index].category,
                                                    name: snapshot
                                                        .data![index].name,
                                                    price: snapshot
                                                        .data![index].price,
                                                    image_src: snapshot
                                                        .data![index].image_src,
                                                    description: snapshot
                                                        .data![index]
                                                        .description)));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(
                                                    10.0)),
                                        margin: EdgeInsets.symmetric(
                                            vertical:
                                                getProportionateScreenWidth(7)),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FutureBuilder(
                                              future: _getImage(
                                                  context,
                                                  snapshot
                                                      .data![index].image_src),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return Container(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            80),
                                                    height:
                                                        getProportionateScreenWidth(
                                                            80),
                                                    child: snapshot.data
                                                        as Widget?,
                                                  );
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator(
                                                    color: Color(0xffDD914F),
                                                  );
                                                }

                                                return Container();
                                              },
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      getProportionateScreenWidth(
                                                          20)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            185,
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name,
                                                      style: const TextStyle(
                                                        color: kPrimaryColor,
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Rs. ${snapshot.data![index].price}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            }
                            return Container();
                          })),
                ),
              ),
            ],
          ),
          SlidingUpPanel(
              controller: _panelController,
              minHeight: _showBar ? MediaQuery.of(context).size.height / 8 : 0,
              color: Colors.transparent,
              backdropEnabled: true,
              borderRadius: BorderRadius.circular(20.0),
              maxHeight: MediaQuery.of(context).size.height / 2,
              collapsed: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0)),
                ),
                child: Center(
                  child: DefaultButton(
                    press: () {
                      _panelController.open();
                      setState(() {});
                    },
                    text: 'Filter',
                  ),
                ),
              ),
              panel: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child: ctg == '1'
                    ? ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, index) {
                          return RadioListTile(
                              title: Text(
                                skinCategory[index],
                                style: const TextStyle(color: kPrimaryColor),
                              ),
                              tileColor: kPrimaryColor,
                              activeColor: kPrimaryColor,
                              selectedTileColor: kPrimaryColor,
                              value: index,
                              groupValue: _skinValue,
                              onChanged: (int? val) {
                                setState(() {
                                  _skinValue = val!;
                                  futureSkinProducts = _getTools(
                                      skinProductsUrl, '', _skinValue);
                                });
                              });
                        },
                      )
                    : Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                        ),
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, index) {
                            return RadioListTile(
                                title: Text(
                                  toolsCategory[index],
                                  style: const TextStyle(color: kPrimaryColor),
                                ),
                                tileColor: kPrimaryColor,
                                activeColor: kPrimaryColor,
                                selectedTileColor: kPrimaryColor,
                                value: index,
                                groupValue: _toolValue,
                                onChanged: (int? val) {
                                  setState(() {
                                    _toolValue = val!;
                                    futureTools =
                                        _getTools(toolsUrl, '', _toolValue);
                                  });
                                });
                          },
                        ),
                      ),
              ))
        ],
      )),
    );
  }

  Future<Widget?> _getImage(BuildContext context, String imageName) async {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        imageName,
        fit: BoxFit.fill,
      ),
    );
  }

  Future<List<Product>> _getTools(String url, String query, int ind) async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List prdts = convert.jsonDecode(response.body);

      return prdts.map((json) => Product.fromJson(json)).where((product) {
        final pdName = product.name.toLowerCase();
        final ctg = product.category.toLowerCase();
        final searchLower = query.toLowerCase();
        if (page == '1' && ind == 0) {
          return pdName.contains(searchLower) || ctg.contains(searchLower);
        } else if (page == '1' && ind != 0) {
          return pdName.contains(searchLower) &&
              ctg.contains(skinCategory[ind]);
        } else if (page == '2' && ind == 0) {
          return pdName.contains(searchLower) || ctg.contains(searchLower);
        } else {
          return pdName.contains(searchLower) &&
              ctg.contains(toolsCategory[ind]);
        }
      }).toList();
    } else {
      throw Exception();
    }
  }
}
