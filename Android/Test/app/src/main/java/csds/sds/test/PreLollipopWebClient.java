package csds.sds.test;

import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import java.io.IOException;

/**
 * Created by tonyhaddad on 22/09/2016.
 */

public class PreLollipopWebClient extends WebViewClient {
    @Deprecated
    @Override
    public WebResourceResponse shouldInterceptRequest(WebView view, String url) {

        WebResourceResponse resourceResponse = super.shouldInterceptRequest(view, url);
        System.out.println("URL" + url);
        if (url.contains("googlelogo_color_160x56dp")) {
            try {
                resourceResponse = new WebResourceResponse("text/javascript",
                        "utf-8", view.getContext().getAssets().open("images/branding/googlelogo/2x/googlelogo_color_160x56dp.png"));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return resourceResponse;
    }
}
