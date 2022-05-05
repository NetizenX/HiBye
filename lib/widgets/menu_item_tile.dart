import 'package:flutter/material.dart';
import 'package:hibye/constants.dart';
import 'package:provider/provider.dart';
import 'package:hibye/model/menu_item.dart';
import 'package:hibye/model/data.dart';
import 'package:hibye/currency.dart';
import 'package:hibye/screen_size.dart';

class MenuItemTile extends StatelessWidget {
  MenuItem menuItem;

  MenuItemTile({required MenuItem this.menuItem});

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
              width: screenWidth(context) * .25,
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
