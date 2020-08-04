import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavourites;

  ProductsGrid(this.showFavourites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavourites ? productsData.favItems: productsData.items;
    return GridView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        /* We can use ChangeNotifierProvider.value class here without leading up to many bugs in this case,
        because we're passing a value, to the value parameter, an already instantiated class. If the class 
        wasn't instantiated then ChangeNotifierProvider class would have been recommended. */
        /* When we don't have to take any input from the context, it is preferrable to use 
        ChangeNotifierProvider.value rather than ChangeNotifierProvider as it can handle the problem we 
        will have with Lists and Grid builders when we use ChangeNotifierProvider. */
        child: ProductItem(
            // id: products[i].id,
            // title: products[i].title,
            // imageUrl: products[i].imageUrl,
            /*Also remember that providers don't work well with lists or grid builders because as soon as the
          item is gone out of the page, it would result in bugs and errors */
            ),
      ),
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
