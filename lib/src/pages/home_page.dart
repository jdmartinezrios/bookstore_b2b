import 'package:bookstore/src/blocs/books_bloc.dart';
import 'package:bookstore/src/blocs/books_event.dart';
import 'package:bookstore/src/blocs/books_state.dart';
import 'package:bookstore/src/widgets/books_widget.dart';
import 'package:bookstore/src/widgets/bottom_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  BooksBloc _booksBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    _booksBloc = BlocProvider.of<BooksBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                child: BlocBuilder<BooksBloc, BooksState>(
                  builder: (context, state) {
                    if (state is BooksUninitialized) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          strokeWidth: 1.5,
                        ),
                      );
                    }
                    if (state is BooksError) {
                      return Center(
                        child: Text('failed to fetch books'),
                      );
                    }
                    if (state is BooksLoaded) {
                      if (state.books.isEmpty) {
                        return Center(
                          child: Text('no books'),
                        );
                      }

                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 100.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.books.length
                              ? BottomLoader()
                              : BooksWidget(books: state.books[index]);
                        },
                        controller: _scrollController,
                        itemCount: state.hasReachedMax
                            ? state.books.length
                            : state.books.length + 1,
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32.0, left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 8.0,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _booksBloc.add(Filter(value));
                        } else {
                          _booksBloc.add(ResetFetchData());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _booksBloc.add(Fetch());
    }
  }
}
