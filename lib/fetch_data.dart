import 'package:ecommerce_api/models/product_model.dart';
import 'package:ecommerce_api/repository/fetch_product_repo.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late Future<List<Products>> futureProducts;
  @override
  void initState() {
    super.initState();
    futureProducts = ProductRepo().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 79, 36, 158),
          title: const Text('ProductsApi'),
          actions: [
            IconButton(
              onPressed: () {
                ProductRepo().addProduct(
                  title: "fake products",
                  description:
                      "this is the world most product you can never see anywhre",
                  price: 3500,
                  category: "fake products",
                  image:
                      "https://th.bing.com/th/id/R.235e22f5497c954f9a79eccfce1edfa4?rik=spZYHnLCarSX4g&riu=http%3a%2f%2fimg.desmotivaciones.es%2f201202%2f0adibas.jpg&ehk=cF4XzX95tZChdz83fvBmM2fiYxkueR3Ao8bBjhSFgIc%3d&risl=&pid=ImgRaw&r=0",
                  rating: {
                    "rate": 3.6,
                    "count": 150,
                  },
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder<List<Products>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var productData = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 50,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 2,
                  mainAxisExtent: 300,
                ),
                itemCount: productData!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Container(
                          child: Center(
                            child: Image.network(
                              productData[index].image!,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productData[index].title!,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    productData[index].rating!.rate.toString(),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      ProductRepo().updateProduct(
                                        id: productData[index].id.toString(),
                                        title: productData[index].title,
                                        price: productData[index].price,
                                      );
                                    },
                                    child: const Text('Update'),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        ProductRepo().deleteProduct(
                                          id: productData[index].id.toString(),
                                        );
                                      },
                                      child: Text('Delete'))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  // return
                  //  ListTile(
                  //   title: Image.network(productData[index].image!),
                  //   subtitle: Text(productData[index].title!),
                  //   // leading: Text(productData[index].category!.name),
                  // );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
