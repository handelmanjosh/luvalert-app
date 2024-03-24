

import 'package:webview_flutter/webview_flutter.dart';

class JavaScript {
  static const String getUsernameScript = """
      (function() {
        let links = document.querySelectorAll('a img[alt*="profile picture"]');
        let x = [];
        for (let img of links) {
          let aTag = img.closest('a');
          if (aTag) {
            x.push(aTag.href)
          } 
        }
        return x[0] ? x[0] : "";
      })()
  """;
  static String createGetFollowersScript(String username) {
    return """
    (async () => {
      let followings = [];
      try {
        Toaster.postMessage("Process started");
        const userQueryRes = await fetch(
          `https://www.instagram.com/web/search/topsearch/?query=$username`
        );
        const userQueryJson = await userQueryRes.json();
        const userId = userQueryJson.users[0].user.pk;

        let after = null;
        let has_next = true;

        while (has_next) {
          await fetch(
            `https://www.instagram.com/graphql/query/?query_hash=d04b0a864b4b54837c0d870b0e77e076&variables=` +
              encodeURIComponent(
                JSON.stringify({
                  id: userId,
                  include_reel: true,
                  fetch_mutual: true,
                  first: 50,
                  after: after,
                })
              )
          )
            .then((res) => res.json())
            .then((res) => {
              has_next = res.data.user.edge_follow.page_info.has_next_page;
              after = res.data.user.edge_follow.page_info.end_cursor;
              followings = followings.concat(
                res.data.user.edge_follow.edges.map(({ node }) => {
                  return {
                    username: node.username,
                    full_name: node.full_name,
                  };
                })
              );
            });
            Toaster.postMessage("followings: " + followings.length);
        }

        Toaster.postMessage(JSON.stringify(followings));
        Toaster.postMessage("Done");
      } catch (e) {
        Toaster.postMessage("Error: " + JSON.stringify(e));
      }
    })()
  """;
  }
  static Future<void> getFollowers(WebViewController controller) async {

  }
  static String parseUsername(String username) {
    String trimmedUsername = username.endsWith("/") ? username.substring(0, username.length - 1) : username;
    return trimmedUsername.split("/").last;
  }
  static Future<String> getMyUsername(WebViewController controller) async {
    String username = "";
    while (username == "") {
      Object n = await controller.runJavaScriptReturningResult(getUsernameScript);
      String name = n.toString();
      username = parseUsername(name);
    }
    return username;
  }
}