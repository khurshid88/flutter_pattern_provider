import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../model/post_model.dart';
import '../services/http_service.dart';
import '../viewmodel/home_viewmodel.dart';
import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel>(
          builder: (ctx, model, index) => Stack(
            children: [
              ListView.builder(
                itemCount: viewModel.items.length,
                itemBuilder: (ctx, index) {
                  Post post = viewModel.items[index];
                  return itemOfPost(viewModel, post);
                },
              ),
              viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
