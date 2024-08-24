import 'package:bloc_api/screens/data/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_api/screens/bloc/product_bloc.dart';
import 'package:bloc_api/screens/bloc/product_event.dart';
import 'package:bloc_api/screens/bloc/product_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products List"),
        centerTitle: true,
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductErrorLoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (BuildContext context, ProductState state) {
          if (state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedState) {
            return ListView.builder(
              itemCount: state.listProduct.length,
              itemBuilder: (BuildContext context, int index) {
                final product = state.listProduct[index];
                return ProductCard(product: product);
              },
            );
          } else if (state is ProductEmptyState) {
            return Center(child: Text('No products available'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProductBloc>().add(GetProductEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          product.thumbnail != null
              ? Image.network(
            product.thumbnail!,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          )
              : Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'No Image Available',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.title ?? 'No Title',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Text(
                  product.description ?? 'No Description',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  'Price: \$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8),
                Text(
                  'Category: ${product.category ?? 'Unknown'}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  context.read<FavoritesBloc>().add(AddToFavorites(product));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
