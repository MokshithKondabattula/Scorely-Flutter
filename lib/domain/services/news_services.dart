import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:scorely/dataLayer/models/news_items.dart';

class NewsService {
  static Future<List<NewsItem>> fetchNewsItems() async {
    final response = await http.get(
      Uri.parse(
        "https://api.allorigins.win/raw?url=https://www.espncricinfo.com/rss/content/story/feeds/0.xml",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load news');
    }

    final document = xml.XmlDocument.parse(response.body);
    final items = document.findAllElements('item');

    return items.map((node) {
      return NewsItem(
        title: node.getElement('title')?.innerText ?? '',
        link: node.getElement('link')?.innerText ?? '',
        description: node.getElement('description')?.innerText ?? '',
        pubDate: node.getElement('pubDate')?.innerText ?? '',
      );
    }).toList();
  }
}
