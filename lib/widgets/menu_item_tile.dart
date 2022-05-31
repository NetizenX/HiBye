import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../model/item_on_menu.dart';
import '../model/data.dart';
import '../currency.dart';
import '../screen_size.dart';

class MenuItemTile extends StatelessWidget {
  ItemOnMenu menuItem;

  MenuItemTile({required ItemOnMenu this.menuItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (menuItem.isCategory) {
          Provider.of<Data>(context, listen: false)
              .changeCurrentMenu(menuItem.category);
        } else {
          Provider.of<Data>(context, listen: false).addToOrder(menuItem);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              width:
                  screenWidth(context) * .2, // Worked except word wrap @ 0.25
              image: AssetImage(menuItem.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              menuItem.name,
              style: kMenuItemFontStyle,
            ),
          ),
          menuItem.isCategory
              ? Text('')
              : Text(
                  currencyString(menuItem.price),
                  style: kMenuPriceFontStyle,
                ),
        ],
      ),
    );
  }
}
