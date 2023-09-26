import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/provider/search_provider.dart';

import '../../constants/colors.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    String search = Provider.of<SearchProvider>(context, listen: false).query;
    searchController = TextEditingController(text: search);
    searchController.addListener(() {
        Provider.of<SearchProvider>(context, listen: false)
            .setSearch(searchController.text);

    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      cursorColor: AppColors.primaryColor,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.go,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.primaryColor,
        ),
        // prefixIconColor: MaterialStateColor.resolveWith((states) =>
        //     states.contains(MaterialState.focused)
        //         ? AppColors.primaryColor
        //         : Colors.white),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 0),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 0),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        hintStyle: const TextStyle(color: Colors.black),
        hintText: "Search",
        fillColor: Colors.transparent,
      ),
    );
  }
}
