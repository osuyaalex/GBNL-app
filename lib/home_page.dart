import 'package:flutter/material.dart';
import 'package:gbnl_app/services/backend_db.dart';
import 'package:gbnl_app/tools/sizes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _firstName;
  String? _lastName;
  String _placeholder = "https://static.vecteezy.com/system/resources/thumbnails/032/980/211/small_2x/new-item-rubber-grunge-stamp-seal-vector.jpg";

  Future _getName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Provider.of<BackendDb>(context, listen: false).getMarketNews();
    setState(() {
      _firstName = prefs.getString('firstName');
      _lastName = prefs.getString('lastName');
    });
  }
  _launchUrl(String url) async {
    //if (await launcher.canLaunchUrl(Uri.parse(url))) {
      await launcher.launchUrl(
        Uri.parse(url),
      );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getName();
  }
  @override
  Widget build(BuildContext context) {
    String formatUnixTimestamp(int timestamp) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      String formattedDate = DateFormat('d MMMM y').format(date);
      return formattedDate;
    }
    String cutUnwantedPart(String name) {
      if (name.length > 36) {
        return name.trim().replaceRange(36, null, '...');
      }
      return name;
    }
    return Consumer<BackendDb>(
        builder: (context, backenddb, child){
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: 100.pW,
                  height: 100.pH,
                  color: Colors.black,
                ),
                Positioned(
                    top: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 25.pH,
                        padding: EdgeInsets.only(left: 15, top: 8.pH),
                        color: Color(0xff05021B),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hey ${_firstName??'--'}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28
                              ),
                            ),
                            4.gap,
                            backenddb.error != null?
                            Text(backenddb.error!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,

                              ),
                            ):Container(),
                          ],
                        )
                    )
                ),
                backenddb.marketNewsList != null?
                Positioned(
                  top: 16.pH,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        height: 84.pH,
                        width: 100.pW,
                        child: ListView.builder(
                          itemCount: backenddb.marketNewsList!.length,
                            itemBuilder: (context, index){
                            var marketNews = backenddb.marketNewsList![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 23.0),
                              child: GestureDetector(
                                onTap: (){
                                  _launchUrl(marketNews.url!);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(marketNews.image?.trim().isNotEmpty ?? false
                                  ? marketNews.image!
                                  : _placeholder,
                                      height: 28.pW,width: 28.pW,fit: BoxFit.fill,),
                                    1.gap,
                                    Expanded(
                                      child: Column(
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0,bottom: 10, right: 25),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(marketNews.source!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                    fontSize: 12.5,
                                                    fontWeight: FontWeight.w300
                                                  ),
                                                ),
                                                Text(formatUnixTimestamp(marketNews.datetime!),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                    fontSize: 12.5,
                                                    fontWeight: FontWeight.w300
                                                ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 18.0),
                                            child: Text(cutUnwantedPart(marketNews.headline!),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                fontSize: 19
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                            }
                        ),
                      ),
                    )
                ):Container()

              ],
            ),
          );
        }
    );
  }
}
