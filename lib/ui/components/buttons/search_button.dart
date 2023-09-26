import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/provider/search_provider.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import '../../constants/colors.dart';

class SearchButton extends StatefulWidget {
  final bool isSearchPage;

  const SearchButton({super.key, required this.isSearchPage});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  bool isExpanded = false;
  final double collapsedWidth = 40;
  final double searchWidth = 200;
  bool renderCancel = false;
  late double width;
  late TextEditingController searchController;
  Timer? _timer;
  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    SearchProvider searchProvider =Provider.of<SearchProvider>(context, listen: false);
    String query = searchProvider.query;
    if (widget.isSearchPage) {
      isExpanded = true;
      width = collapsedWidth + searchWidth;
      searchController = TextEditingController(text: query);
    } else {
      searchProvider.setSearch("");
      width = collapsedWidth;
      searchController = TextEditingController();
    }
    searchController.addListener(timeListener);
  }

  onExpand() {
    setState(() {
      isExpanded = true;
    });
  }

  onCollapse() {
    setState(() {
      isExpanded = false;
      width = collapsedWidth;
    });
  }

  navigateToSearchPage(BuildContext context) {
    context.go(AppRouter.search);
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded == false
        ? InkWell(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              navigateToSearchPage(context);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              height: 40,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: const Icon(
                Icons.search,
                size: 20,
              ),
            ),
          )
        : Expanded(
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                onExpand();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                padding: const EdgeInsets.only(left: 10),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    isExpanded
                        ? Expanded(
                            child: SizedBox(
                                // width: searchWidth,
                                child: Focus(
                              onFocusChange: (hasFocus) {
                                /*if (!hasFocus) {
                                  onCollapse();
                                }*/
                              },
                              child: TextField(
                                autofocus: true,
                                style: const TextStyle(color: Colors.white),
                                controller: searchController,
                                cursorColor: AppColors.primaryColor,
                                keyboardType: TextInputType.text,
                                focusNode: _focusNode,
                                onSubmitted: (value) {
                                  _focusNode.requestFocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  suffixIcon: renderCancel
                                      ? IconButton(
                                          onPressed: () {
                                            searchController.text = '';
                                          },
                                          icon: const Icon(Icons.cancel))
                                      : null,
                                  suffixIconColor: Colors.white,
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Search",
                                  fillColor: Colors.white,
                                ),
                              ),
                            )),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          );
  }

String previousText="";
  timeListener() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer(const Duration(seconds: 1), () {
      textListener();
      // Your desired action here.
    });

  }

  textListener(){
    if (searchController.text.isEmpty) {
      setState(() {
        renderCancel = false;
      });
    } else {
      setState(() {
        renderCancel = true;
      });
    }
    Provider.of<SearchProvider>(context, listen: false)
        .setSearch(searchController.text);

    if(previousText!=searchController.text){
      navigateToSearchPage(context);
    }
  }

  @override
  void dispose() {
    searchController.removeListener(timeListener);
    searchController.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    super.dispose();
  }
}

/*
 SizedBox(
                          width: 250,
                          child: Transform.scale(
                            scale: .8,
                            child: const SearchTextField(),
                          ),
                        ),
                        */
