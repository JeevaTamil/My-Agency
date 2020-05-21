import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/screens/suppliers/suppliers_search.dart';

class PurchaseEntryAdd extends StatefulWidget {
  @override
  _PurchaseEntryAddState createState() => _PurchaseEntryAddState();
}

class _PurchaseEntryAddState extends State<PurchaseEntryAdd> {
  dynamic _selectedSupplier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Purchase Entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(children: <Widget>[
              suppliers(context),
              transport(context),
              //supplierBox(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget transport(BuildContext context) {
    return Stack(children: [
      Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xff020403),
          )),
      Container(
        decoration: BoxDecoration(
            color: Color(0xff002147),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              lrTransportTextField(context),
              lrDate(context),
              lrNumberTextField(context),
              lrFrightTextField(context),
              lrBookingStationTextField(context),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget lrTransportTextField(BuildContext context) {
    return TextField(
      controller: _lrBookingStationController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.airport_shuttle),
        labelText: "Transport",
      ),
    );
  }

  TextEditingController _lrBookingStationController = TextEditingController();
  Widget lrBookingStationTextField(BuildContext context) {
    return TextField(
      controller: _lrBookingStationController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.location_city),
        labelText: "Booking Station",
      ),
    );
  }

  TextEditingController _lrFrightController = TextEditingController();
  Widget lrFrightTextField(BuildContext context) {
    return TextField(
      controller: _lrFrightController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_balance_wallet),
        labelText: "LR Fright",
      ),
    );
  }

  TextEditingController _lrNumberController = TextEditingController();
  Widget lrNumberTextField(BuildContext context) {
    return TextField(
      controller: _lrNumberController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.confirmation_number),
        labelText: "LR Number",
      ),
    );
  }

  DateTime lrselectedDate = DateTime.now();
  String lrselectedDateString = '';
  lrDateField(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: lrselectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != lrselectedDate) {
      setState(() {
        lrselectedDate = picked;
        print(lrselectedDate);
      });
    }
  }

  Widget lrDate(BuildContext context) {
    return (TextFormField(
      onTap: () {
        lrDateField(context);
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: "LR Date",
        prefixIcon: Icon(Icons.calendar_today),
        hintText: lrselectedDate.day.toString() +
            "/" +
            lrselectedDate.month.toString() +
            "/" +
            lrselectedDate.year.toString(),
      ),
    ));
  }

  Widget suppliers(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color(0xff020403),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            supplierstextFormField(context),
            billNumberTextField(context),
            billDate(context),
            goodsValueTextField(context),
            discountPercentTextField(context),
            taxField(context),
            totalValueTextField(context),
          ],
        ),
      ),
    );
  }

  TextEditingController _billNumberController = TextEditingController();
  TextFormField billNumberTextField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _billNumberController,
      decoration: InputDecoration(
          labelText: "Bill No", prefixIcon: Icon(Icons.confirmation_number)),
    );
  }

  TextEditingController _goodsValue = TextEditingController();
  TextFormField goodsValueTextField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _goodsValue,
      decoration: InputDecoration(
          labelText: "Goods Value", prefixIcon: Icon(Icons.attach_money)),
    );
  }

  TextEditingController _totalValue = TextEditingController();
  TextFormField totalValueTextField(BuildContext context) {
    return TextFormField(
      //TODO: total field calculations
      onTap: () {
        setState(() {
          _totalValue.text = "12345";
        });
      },
      readOnly: true,
      keyboardType: TextInputType.number,
      controller: _goodsValue,
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelText: "Total Value",
          prefixIcon: Icon(Icons.attach_money),
          hintText: _totalValue.text),
    );
  }

  TextEditingController _discountPercent = TextEditingController();
  TextEditingController _discountvalue = TextEditingController();
  Widget discountPercentTextField(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _discountPercent,
            decoration: InputDecoration(
                labelText: "Discount Percent",
                prefixIcon: Icon(Icons.attach_money)),
          ),
        ),
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _discountvalue,
            decoration: InputDecoration(
                labelText: "Discount Value",
                prefixIcon: Icon(Icons.attach_money)),
          ),
        ),
      ],
    );
  }

  DateTime selectedDate = DateTime.now();
  String selectedDateString = '';
  billDateField(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
  }

  Widget billDate(BuildContext context) {
    return (TextFormField(
      onTap: () {
        billDateField(context);
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: " Bill Date",
        prefixIcon: Icon(Icons.calendar_today),
        hintText: selectedDate.day.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.year.toString(),
      ),
    ));
  }

  Widget taxField(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.account_balance,
            color: Theme.of(context).selectedRowColor,
          ),
          //Text("Tax"),
          CupertinoSegmentedControl(
            padding: EdgeInsets.all(15),
            unselectedColor: Theme.of(context).secondaryHeaderColor,
            //pressedColor: Colors.
            borderColor: Theme.of(context).accentColor,
            selectedColor: Theme.of(context).primaryColor,
            children: {
              0: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "C GST / S GST",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )),
              1: Text(
                "I GST",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            },
            onValueChanged: (value) {
              print(value);
            },
          ),
        ],
      ),
    );
  }

  TextEditingController _supplier = TextEditingController();
  TextFormField supplierstextFormField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _supplier,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Supplier Name",
        prefixIcon: Icon(Icons.contacts),
        hintText: _selectedSupplier == null ? '' : _selectedSupplier['name'],
      ),
      onTap: () {
        _navigateToSupplierSearch(context);
      },
    );
  }

  _navigateToSupplierSearch(BuildContext context) {
    Navigator.push(context, _createRoute()).then((value) {
      _selectedSupplier = value;
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SuppliersSearch(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
