package csds.sds.test;

import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

/**
 * Created by tonyhaddad on 22/09/2016.
 */

public class PreLollipopWebClient extends WebViewClient {
    String domain;

    public PreLollipopWebClient(String domain) {
        this.domain = domain;
    }

    @Deprecated
    @Override
    public WebResourceResponse shouldInterceptRequest(WebView view, String url) {

        WebResourceResponse resourceResponse = super.shouldInterceptRequest(view, url);
        String extension = url.toString().substring(url.toString().lastIndexOf("."));
        String path="";
        try {
            URI uri = new URI(url);
           path= uri.getPath();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        if (Utils.extensions.contains(extension)) {
            String memeType = null;
            if (extension.contains("svg"))
                memeType = "image/svg+xml";
            if (!path.equals("") && Utils.isAssetExists(path.substring(1),view.getContext())) {
                try {
                    resourceResponse = new WebResourceResponse(memeType,
                            "utf-8", view.getContext().getAssets().open(path.substring(1)));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return resourceResponse;
    }
}
