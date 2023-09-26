package com.enrichtv.android.player.ui.player.cast;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.view.ActionProvider;
import androidx.mediarouter.app.MediaRouteButton;
import androidx.mediarouter.app.MediaRouteChooserDialog;
import androidx.mediarouter.app.MediaRouteControllerDialog;
import androidx.mediarouter.app.MediaRouteDialogFactory;
import androidx.mediarouter.media.MediaRouteSelector;
import androidx.mediarouter.media.MediaRouter;
import androidx.mediarouter.media.MediaRouterParams;

import java.lang.ref.WeakReference;

public class MediaRouteActionProvider extends ActionProvider {
    private static final String TAG = "MRActionProvider";

    private final MediaRouter mRouter;
    private final MediaRouterCallback mCallback;

    private MediaRouteSelector mSelector = MediaRouteSelector.EMPTY;
    private MediaRouteDialogFactory mDialogFactory = MediaRouteDialogFactory.getDefault();
    private MediaRouteButton mButton;
    private boolean mAlwaysVisible;

    /**
     * Creates the action provider.
     *
     * @param context The context.
     */
    public MediaRouteActionProvider(Context context) {
        super(context);

        mRouter = MediaRouter.getInstance(context);
        mCallback = new MediaRouterCallback(this);
    }

    /**
     * Gets the media route selector for filtering the routes that the user can
     * select using the media route chooser dialog.
     *
     * @return The selector, never null.
     */
    @NonNull
    public MediaRouteSelector getRouteSelector() {
        return mSelector;
    }

    /**
     * Sets the media route selector for filtering the routes that the user can
     * select using the media route chooser dialog.
     *
     * @param selector The selector, must not be null.
     */
    public void setRouteSelector(@NonNull MediaRouteSelector selector) {
        if (selector == null) {
            throw new IllegalArgumentException("selector must not be null");
        }

        if (!mSelector.equals(selector)) {
            // FIXME: We currently have no way of knowing whether the action provider
            // is still needed by the UI.  Unfortunately this means the action provider
            // may leak callbacks until garbage collection occurs.  This may result in
            // media route providers doing more work than necessary in the short term
            // while trying to discover routes that are no longer of interest to the
            // application.  To solve this problem, the action provider will need some
            // indication from the framework that it is being destroyed.
            if (!mSelector.isEmpty()) {
                mRouter.removeCallback(mCallback);
            }
            if (!selector.isEmpty()) {
                mRouter.addCallback(selector, mCallback);
            }
            mSelector = selector;
            refreshRoute();

            if (mButton != null) {
                mButton.setRouteSelector(selector);
            }
        }
    }

    /**
     * Enables dynamic group feature.
     * With this enabled, a different set of {@link MediaRouteChooserDialog} and
     * {@link MediaRouteControllerDialog} is shown when the button is clicked.
     * If a {@link androidx.mediarouter.media.MediaRouteProvider media route provider}
     * supports dynamic group, the users can use that feature with the dialogs.
     *
     * @see MediaRouteButton#enableDynamicGroup()
     * @see androidx.mediarouter.media.MediaRouteProvider.DynamicGroupRouteController
     *
     * @deprecated Use {@link
     * MediaRouterParams.Builder#setDialogType(int)} with
     * {@link MediaRouterParams#DIALOG_TYPE_DYNAMIC_GROUP} instead.
     */
    @Deprecated
    public void enableDynamicGroup() {
        MediaRouterParams oldParams = mRouter.getRouterParams();
        MediaRouterParams.Builder newParamsBuilder = oldParams == null
                ? new MediaRouterParams.Builder() : new MediaRouterParams.Builder(oldParams);
        newParamsBuilder.setDialogType(MediaRouterParams.DIALOG_TYPE_DYNAMIC_GROUP);
        mRouter.setRouterParams(newParamsBuilder.build());
    }

    /**
     * Sets whether {@link MediaRouteButton} is visible when no routes are available.
     * When true, the button is visible even when there are no routes to connect.
     * The default is false.
     *
     * @param alwaysVisible true to show MediaRouteButton even when no routes are available.
     *
     * @see MediaRouteButton#setAlwaysVisible(boolean)
     */
    public void setAlwaysVisible(boolean alwaysVisible) {
        if (mAlwaysVisible != alwaysVisible) {
            mAlwaysVisible = alwaysVisible;
            refreshVisibility();
            if (mButton != null) {
                mButton.setAlwaysVisible(mAlwaysVisible);
            }
        }
    }

    /**
     * Gets the media route dialog factory to use when showing the route chooser
     * or controller dialog.
     *
     * @return The dialog factory, never null.
     */
    @NonNull
    public MediaRouteDialogFactory getDialogFactory() {
        return mDialogFactory;
    }

    /**
     * Sets the media route dialog factory to use when showing the route chooser
     * or controller dialog.
     *
     * @param factory The dialog factory, must not be null.
     */
    public void setDialogFactory(@NonNull MediaRouteDialogFactory factory) {
        if (factory == null) {
            throw new IllegalArgumentException("factory must not be null");
        }

        if (mDialogFactory != factory) {
            mDialogFactory = factory;

            if (mButton != null) {
                mButton.setDialogFactory(factory);
            }
        }
    }

    /**
     * Gets the associated media route button, or null if it has not yet been created.
     */
    @Nullable
    public MediaRouteButton getMediaRouteButton() {
        return mButton;
    }

    /**
     * Called when the media route button is being created.
     * <p>
     * Subclasses may override this method to customize the button.
     * </p>
     */
    public MediaRouteButton onCreateMediaRouteButton() {
        return new MediaRouteButton(getContext());
    }

    @Override
    @SuppressWarnings("deprecation")
    public View onCreateActionView() {
        if (mButton != null) {
            Log.e(TAG, "onCreateActionView: this ActionProvider is already associated " +
                    "with a menu item. Don't reuse MediaRouteActionProvider instances! " +
                    "Abandoning the old menu item...");
        }

        mButton = onCreateMediaRouteButton();
        //mButton.setCheatSheetEnabled(true);
        mButton.setRouteSelector(mSelector);
        mButton.setAlwaysVisible(true);
        mButton.setDialogFactory(mDialogFactory);
        mButton.setLayoutParams(new ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.MATCH_PARENT));
        return mButton;
    }

    @Override
    public boolean onPerformDefaultAction() {
        if (mButton != null) {
            return mButton.showDialog();
        }
        return false;
    }

    @Override
    public boolean overridesItemVisibility() {
        return true;
    }

    @Override
    public boolean isVisible() {
        return true;
    }

    void refreshRoute() {
        refreshVisibility();
    }

    private static final class MediaRouterCallback extends MediaRouter.Callback {
        private final WeakReference<MediaRouteActionProvider> mProviderWeak;

        public MediaRouterCallback(MediaRouteActionProvider provider) {
            mProviderWeak = new WeakReference<MediaRouteActionProvider>(provider);
        }

        @Override
        public void onRouteAdded(MediaRouter router, MediaRouter.RouteInfo info) {
            refreshRoute(router);
        }

        @Override
        public void onRouteRemoved(MediaRouter router, MediaRouter.RouteInfo info) {
            refreshRoute(router);
        }

        @Override
        public void onRouteChanged(MediaRouter router, MediaRouter.RouteInfo info) {
            refreshRoute(router);
        }

        @Override
        public void onProviderAdded(MediaRouter router, MediaRouter.ProviderInfo provider) {
            refreshRoute(router);
        }

        @Override
        public void onProviderRemoved(MediaRouter router, MediaRouter.ProviderInfo provider) {
            refreshRoute(router);
        }

        @Override
        public void onProviderChanged(MediaRouter router, MediaRouter.ProviderInfo provider) {
            refreshRoute(router);
        }

        private void refreshRoute(MediaRouter router) {
            MediaRouteActionProvider provider = mProviderWeak.get();
            if (provider != null) {
                provider.refreshRoute();
            } else {
                router.removeCallback(this);
            }
        }
    }
}
