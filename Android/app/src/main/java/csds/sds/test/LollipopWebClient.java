package csds.sds.test;

import android.annotation.TargetApi;
import android.os.Build;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import java.io.IOException;

/**
 * Created by tonyhaddad on 22/09/2016.
 */

public class LollipopWebClient extends WebViewClient {


    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    @Override
    public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
        WebResourceResponse resourceResponse = super.shouldInterceptRequest(view, request);
        String extension=request.getUrl().toString().substring(request.getUrl().toString().lastIndexOf("."));
        if (Utils.extensions.contains(extension)) {
            System.out.println("URL" + request.getUrl().getPath());
            String memeType = null;
            if (extension.contains("svg"))
                memeType = "image/svg+xml";
            if (Utils.isAssetExists(request.getUrl().getPath().substring(1), view.getContext())) {
                try {
                    resourceResponse = new WebResourceResponse(memeType,
                            "utf-8", view.getContext().getAssets().open(request.getUrl().getPath().substring(1)));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return resourceResponse;
    }


}
