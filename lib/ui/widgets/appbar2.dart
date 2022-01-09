import 'dart:async';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/ui/pages/home/pages/page2/bloc/page2_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class CustomAppBar2 extends StatefulWidget {
  @override
  State<CustomAppBar2> createState() => _CustomAppBar2State();
}

class _CustomAppBar2State extends State<CustomAppBar2> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  final String _productID = 'CREATE_PROJECT';

  bool _available = true;

  List<ProductDetails> _products = [];

  List<PurchaseDetails> _purchases = [];

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  late Page2Bloc _bloc;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      setState(() {
        _purchases.addAll(purchaseDetailsList);
        _listenToPurchaseUpdated(purchaseDetailsList);
      });
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      _subscription.cancel();
    });

    _initialize();

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _initialize() async {
    _available = await _inAppPurchase.isAvailable();

    List<ProductDetails> products = await _getProducts(
      productIds: Set<String>.from(
        [_productID],
      ),
    );

    setState(() {
      _products = products;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          //  _showPendingUI();
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (!valid) {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
          break;
        case PurchaseStatus.error:
          print(purchaseDetails.error);
          // _handleError(purchaseDetails.error!);
          break;
        default:
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  Future<List<ProductDetails>> _getProducts({required Set<String> productIds}) async {
    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(productIds);

    return response.productDetails;
  }

  void subscribe({required ProductDetails product}) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<Page2Bloc>(context);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            icon: Icon(Icons.group_add_rounded),
            onPressed: () {
              buildShowBottomSheet(context);
            },
          ),
        ),
      ],
      title: Text(AppLocalizations.of(context)!.org),
      centerTitle: true,
      pinned: false,
      floating: false,
      snap: false,
      expandedHeight: 130,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.96,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 243, 243, 1),
                borderRadius: BorderRadius.circular(40)),
            child: TextField(
              maxLines: 1,
              enableSuggestions: false,
              onChanged: (String input) {
                if (input.length > 2) {
                  _bloc.add(SearchEvent(inputText: _controller.text));
                  print(_bloc.state);
                }
              },
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                hintText: AppLocalizations.of(context)!.search,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
  PersistentBottomSheetController buildShowBottomSheet(BuildContext context) =>
    showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => GestureDetector(
        onTap: () {
          print("çalışrtı");
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AutoSizeText(
                      "Tamamen yeni bir organizasyon açmak için tek seferlik 30 tl ücret alınmaktadır. Yinede devam etmek istiyor musunuz?"),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          subscribe(product: _products[0]);
                          Navigator.pushNamed(context, "tocreategrouppage");
                        },
                        child: Container(
                          height: 36,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.turkce, //TODO localizationdaki continue ile değişcek
                            style: TextStyle(fontSize: 23),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 36,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: TextStyle(fontSize: 23),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}


