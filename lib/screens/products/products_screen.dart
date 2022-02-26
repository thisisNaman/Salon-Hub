import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/models/product.dart';
import 'package:salon_hub/screens/details/details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:salon_hub/components/search_field.dart';
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
      'https://script.google.com/macros/s/AKfycbw6eP9yYcST_6X1eDhx-hxZu4Ix3YjG0Za28NYTF-WCXWCg4Ns2myDEHhQpJnzvZzJg/exec';
  String toolsUrl =
      'https://script.google.com/macros/s/AKfycbw-idkLlPqBOIagrHbaJ3q3iUABWTBCiNIAXr9vuxdIv5hN9ujKfNXvMl_CWtGEAfXNxA/exec';

  bool _showBar = true;
  ScrollController _scrollController = ScrollController();
  bool _isScrollingDown = false;
  bool _show = true;
  List<String> skinCategory = ["all", "wella", "vedicline", "cacau", "raaga"];
  List<String> toolsCategory = ["all", "ikonic", "wahl"];

  int _skinValue = 0;
  int _toolValue = 0;
  String page = '1';
  @override
  void initState() {
    super.initState();
    futureTools = _getTools(toolsUrl, '');
    futureSkinProducts = _getTools(skinProductsUrl, '');
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
                          futureTools = _getTools(toolsUrl, val);
                          futureSkinProducts = _getTools(skinProductsUrl, val);
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
                          future:
                              ctg[0] == '1' ? futureSkinProducts : futureTools,
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
                                                    color: kPrimaryColor,
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
                                                        color: Colors.white,
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '\u{20B9} ${snapshot.data![index].price}'
                                                        .replaceAllMapped(
                                                            reg, mathFunc),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: kPrimaryColor,
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

  Future<List<Product>> _getTools(String url, String query) async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List prdts = convert.jsonDecode(response.body);

      return prdts.map((json) => Product.fromJson(json)).where((product) {
        final pdName = product.name.toLowerCase();
        final ctg = product.category.toLowerCase();
        final searchLower = query.toLowerCase();

        if (page == '11') {
          return pdName.contains(searchLower) && ctg.contains('wella');
        } else if (page == '12') {
          return pdName.contains(searchLower) && ctg.contains('vedicline');
        } else if (page == '13') {
          return pdName.contains(searchLower) && ctg.contains('cacau');
        } else if (page == '14') {
          return pdName.contains(searchLower) && ctg.contains('raaga');
        } else if (page == '21') {
          return pdName.contains(searchLower) && ctg.contains('ikonic');
        } else {
          return pdName.contains(searchLower) && ctg.contains('wahl');
        }
      }).toList();
    } else {
      throw Exception();
    }
  }
}
