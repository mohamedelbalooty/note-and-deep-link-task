import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_task/src/view/app_components.dart';
import 'package:note_task/src/view/note_details_view/note_details_view.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../utils/helper/firebase_helper.dart';
import 'note_deep_link_service_repository.dart';

class NoteDeepLinkServiceImplementation extends NoteDeepLinkServiceRepository{
  @override
  void initializeDynamicLink({BuildContext? context}) {
    FirebaseHelper.firebaseDynamicLinks.onLink(
      onSuccess: (PendingDynamicLinkData? linkData) async {
        final Uri? deepLink = linkData!.link;
        if (deepLink != null) {
          ///HANDLE ON HERE
          _handleDeepLink(deepLink, context!);
        }
      },
      onError: (OnLinkErrorException error) async {
        print(error.toString());
      },
    );
  }

  @override
  Future<void> generateDynamicLink({required String note, required String id}) async{
    const String baseUrl = 'https://mohamedelbalooty.page.link';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: baseUrl,
      link: Uri.parse('$baseUrl/$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.mohamedElbalooty.note_task',
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        description: note,
      ),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    String? shareUrl = shortDynamicLink.shortUrl.toString();
    await Share.share(shareUrl);
  }

  void _handleDeepLink(Uri url, BuildContext context) {
    List<String> separatedLink = [];
    separatedLink.addAll(url.path.split('/'));
    onNavigate(context, page: NoteDetailsView(id: separatedLink[1]));
  }

}