import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

import '../model/post_model.dart';
import '../views/item_of_post.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('SetState'),
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
                  }),
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
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () async {
          bool? isUpdate = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreatePage(isUpdate: false)));
          if (isUpdate != null) {
            viewModel.apiPostList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
