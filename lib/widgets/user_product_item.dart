import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(
        title,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            imageUrl), //backgroundImage takes ImageProvider as input.
        /* We even have other built in providers like AssetImage, which depends on from where you are 
        getting your image */
      ),
      trailing: Container(
        //Trailing doesn't provide any restrictions and Row takes as much space as
        width:
            100, // possible this leads to rendering issues, therefore we wrapped the row in a container
        child: Row(
          // and provided fixed width
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text('Deleting Failed', textAlign: TextAlign.center,),
                  ));
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
