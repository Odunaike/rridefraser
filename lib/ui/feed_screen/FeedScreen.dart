import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rridefraser/domain/product.dart';
import 'package:rridefraser/ui/login_screen/LoginBloc.dart';
import 'package:shimmer/shimmer.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginCompletedState) {
        return const Center(child: ShimmerList());
      } else if (state is LoginRetrieveState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductList(productsList: state.products),
        );
      } else if (state is LoginFailedState) {
        //Navigator.pop(context);
        return Center(
          child: Text(state.errorMessage),
        );
      } else {
        return const Text("data");
      }
    }));
  }
}

class ProductList extends StatelessWidget {
  final List<Product> productsList;
  const ProductList({required this.productsList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product topProduct = productsList[0];
    List<Product> subListProducts = productsList.sublist(1);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 50,
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "Hey User,",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      ProductItem(product: topProduct),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Trending",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subListProducts.length,
            itemBuilder: (context, index) {
              return ProductItemRow(product: subListProducts[index]);
            },
          ),
        ),
      ),
    ]);
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(product.imageUrls[0],
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 250),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "\$${product.price}",
            style: const TextStyle(color: Color(0xFF5DB075), fontSize: 16),
          )
        ],
      ),
    );
  }
}

class ProductItemRow extends StatelessWidget {
  final Product product;
  const ProductItemRow({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 124,
      height: 215,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(product.imageUrls[0],
                fit: BoxFit.cover, width: 110, height: 110),
          ),
          SizedBox(
            height: 34,
            width: 110,
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 17,
            width: 48,
            child: Text(
              "\$${product.price}",
              style: const TextStyle(
                  color: Color(0xFF5DB075),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 100.0),
      child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 203, 202, 202),
          highlightColor: const Color.fromARGB(255, 235, 234, 234),
          child: ListView.builder(
            itemCount: 5, // Adjust the count based on your needs
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 233, 231, 231),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 233, 231, 231),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 400,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 233, 231, 231),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 50,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 233, 231, 231),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ]);
            },
          )),
    );
  }
}
