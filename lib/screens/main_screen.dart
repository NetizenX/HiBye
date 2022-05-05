import 'package:flutter/material.dart';
import 'package:hibye/constants.dart';
import 'package:hibye/widgets/menu_item_tile.dart';
import 'package:provider/provider.dart';
import 'package:hibye/model/data.dart';
import 'package:hibye/model/menu_item.dart';
import 'package:hibye/widgets/order_tray.dart';
import 'package:hibye/widgets/logout_button.dart';
import 'package:hibye/model/user.dart';

class MainScreen extends StatelessWidget {
  Future<List<Widget>> menuTiles(BuildContext context) async {
    List<Widget> result = [];
    List<MenuItem> menuItemList = await Provider.of<Data>(context).getMenu();
    for (MenuItem menuItem in menuItemList) {
      result.add(
        MenuItemTile(
          menuItem: menuItem,
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hi${Provider.of<User>(context).getFirstName()}',
          style: kSectionTitleSyle,
        ),
        actions: [
          TextButton(
            child: Text(
              'Test',
              style: kMenuItemFontStyle,
            ),
            onPressed: () async {
              Provider.of<Data>(context, listen: false).orderTest();
            },
          ),
          LogoutButton(),
        ],
      ),
      body: Container(
        color: kAppBackgroundColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header(),
              Container(
                margin: EdgeInsets.only(
                  left: 20.0,
                  bottom: 10.0,
                ),
                // TODO: Implement menu / sub-menu breadcrumb navigation
                child: GestureDetector(
                  onTap: () => Provider.of<Data>(context, listen: false)
                      .changeCurrentMenu('main'),
                  child: Icon(
                    Icons.home,
                    size: 30.0,
                    color: kAppTextColor,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Widget>>(
                    future: menuTiles(context),
                    builder: (context, AsyncSnapshot<List<Widget>> menuList) {
                      return GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        // itemCount: Provider.of<Data>(context).menuLength(),
                        children: menuList.data!,
                      );
                    }),
              ),
              OrderTray(),
            ],
          ),
        ),
      ),
    );
  }
}
