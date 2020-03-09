class BookSearchResult {
  String url, title;
  String imageUrl;
  BookSearchInfo info;

  BookSearchResult(this.url, this.title, this.imageUrl, this.info);
}

class BookSearchInfo {
  String title;
  int followers, pages, chapters, views;
  double rating;
  DateTime lastUpdate;
  String description;
  String imageUrl;

  BookSearchInfo(this.followers, this.pages, this.chapters,
      this.views, this.rating, this.lastUpdate, this.description);
}