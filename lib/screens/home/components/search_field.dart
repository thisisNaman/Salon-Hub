import 'package:flutter/material.dart';
import 'package:salon_hub/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  SearchField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            suffixIcon: controller.text.isNotEmpty
                ? GestureDetector(
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product or category",
            prefixIcon: const Icon(Icons.search)),
      ),
    );
  }
}
