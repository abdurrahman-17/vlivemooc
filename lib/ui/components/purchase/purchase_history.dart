import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vlivemooc/core/player/availability_service.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/purchase/purchase_model/purchase_model.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  bool isLoading = true;
  PurchaseModel? purchaseModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String purchaseList = await AvailabilityService().getPurchaseList();
    setState(() {
      isLoading = false;
    });
    if (purchaseList.isNotEmpty) {
      PurchaseModel model = PurchaseModel.fromMap(jsonDecode(purchaseList));
      setState(() {
        purchaseModel = model;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: isLoading
            ? const Center(
                child: LoadingAnimation(),
              )
            : purchaseModel == null
                ? const Center(
                    child: Text("No purchase history available"),
                  )
                : InteractiveViewer(
                    constrained: false,
                    child: DataTable(columns: const [
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: Constants.fontSizeDefault,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Order No',
                          style: TextStyle(
                              fontSize: Constants.fontSizeDefault,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Type',
                          style: TextStyle(
                              fontSize: Constants.fontSizeDefault,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Price',
                          style: TextStyle(
                              fontSize: Constants.fontSizeDefault,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ], rows: [
                      ...purchaseModel!.data!.map((purchase) {
                        DateTime created = DateTime.parse(purchase.created!);
                        String createdDate =
                            DateFormat('dd/MM/yy').format(created);
                        return DataRow(cells: [
                          DataCell(
                            Text(
                              createdDate,
                              style: const TextStyle(
                                fontSize: Constants.fontSizeDefault,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              purchase.invoiceid!,
                              style: const TextStyle(
                                fontSize: Constants.fontSizeDefault,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              purchase.purchasetype!,
                              style: const TextStyle(
                                fontSize: Constants.fontSizeDefault,
                              ),
                            ),

                          ),
                          DataCell(
                            Text(
                              "${purchase.amount!.toStringAsFixed(2)} ${purchase.currency ?? ''}",
                              style: const TextStyle(
                                fontSize: Constants.fontSizeDefault,
                              ),
                            ),
                          ),
                        ]);
                      })
                    ]),
                  ));
  }
}
