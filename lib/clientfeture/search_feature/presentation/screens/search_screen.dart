import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repostry/search_repository.dart';
import '../cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(SearchRepository('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com')),
      child: Scaffold(
        appBar: AppBar(title: Text('Search Jobs')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      context.read<SearchCubit>().searchJobs(_controller.text);
                    },
                  ),
                ),
                onSubmitted: (value) {
                  context.read<SearchCubit>().searchJobs(value);
                },
              ),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SearchLoaded) {
                      if (state.results.isEmpty) {
                        return Center(child: Text('No results found'));
                      }
                      return ListView.builder(
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          final job = state.results[index];
                          return ListTile(
                            title: Text(job.title),
                            subtitle: Text(job.description),
                            leading: job.id != null
                                ? Image.network(
                                    job.description,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error);
                                    },
                                  )
                                : Icon(Icons.image_not_supported),
                          );
                        },
                      );
                    } else if (state is SearchError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text('Enter a search term'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read<SearchCubit>().clearSearchResults();
    _controller.dispose();
    super.dispose();
  }
}