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
        return ProductList(productsList: state.products);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Hey User,",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return ProductItem(product: productsList[index]);
            },
          ),
        ),
      ],
    );
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
            style: const TextStyle(
                color: Color.fromARGB(255, 30, 176, 61), fontSize: 16),
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
