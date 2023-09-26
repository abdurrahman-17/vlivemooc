package com.enrichtv.android.player.ui.player.cast;

import android.content.Context;
import android.view.Menu;
import android.view.MenuItem;

import androidx.annotation.NonNull;
import androidx.core.view.MenuItemCompat;
import androidx.mediarouter.app.MediaRouteButton;
import androidx.mediarouter.app.MediaRouteDialogFactory;

import com.google.android.gms.cast.framework.CastContext;
import com.google.android.gms.cast.internal.Logger;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ShowFirstParty;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

public final class CastButtonFactory {
    private static final Logger zzy = new Logger("CastButtonFactory");
    private static final List<WeakReference<MenuItem>> zzkc = new ArrayList();
    private static final List<WeakReference<MediaRouteButton>> zzkd = new ArrayList();

    private CastButtonFactory() {
    }

    public static MenuItem setUpMediaRouteButton(Context var0, Menu var1, int var2) {
        return zza(var0, var1, var2, (MediaRouteDialogFactory) null);
    }

    @ShowFirstParty
    private static MenuItem zza(Context var0, Menu var1, int var2, MediaRouteDialogFactory var3) {
        Preconditions.checkMainThread("Must be called from the main thread.");
        Preconditions.checkNotNull(var1);
        MenuItem var4;
        if ((var4 = var1.findItem(var2)) == null) {
            throw new IllegalArgumentException(String.format(Locale.ROOT, "menu doesn't contain a menu item whose ID is %d.", var2));
        } else {
            try {
                zza(var0, (MenuItem) var4, (MediaRouteDialogFactory) null);
                zzkc.add(new WeakReference(var4));
                return var4;
            } catch (IllegalArgumentException var5) {
                throw new IllegalArgumentException(String.format(Locale.ROOT, "menu item with ID %d doesn't have a MediaRouteActionProvider.", var2));
            }
        }
    }

    public static void setUpMediaRouteButton(Context var0, MediaRouteButton var1) {
        Preconditions.checkMainThread("Must be called from the main thread.");
        if (var1 != null) {
            zza(var0, (MediaRouteButton) var1, (MediaRouteDialogFactory) null);
            zzkd.add(new WeakReference(var1));
        }

    }

    public static void zza(Context var0) {
        Iterator var1 = zzkc.iterator();

        WeakReference var2;
        while (var1.hasNext()) {
            var2 = (WeakReference) var1.next();

            try {
                if (var2.get() != null) {
                    zza(var0, (MenuItem) ((MenuItem) var2.get()), (MediaRouteDialogFactory) null);
                }
            } catch (IllegalArgumentException var4) {
                zzy.w("Unexpected exception when refreshing MediaRouteSelectors for Cast buttons", new Object[]{var4});
            }
        }

        var1 = zzkd.iterator();

        while (var1.hasNext()) {
            if ((var2 = (WeakReference) var1.next()).get() != null) {
                zza(var0, (MediaRouteButton) ((MediaRouteButton) var2.get()), (MediaRouteDialogFactory) null);
            }
        }

    }

    private static void zza(Context var0, @NonNull MenuItem var1, MediaRouteDialogFactory var2) throws IllegalArgumentException {
        try {
            Preconditions.checkMainThread("Must be called from the main thread.");
            MediaRouteActionProvider var3;
            if ((var3 = (MediaRouteActionProvider) MenuItemCompat.getActionProvider(var1)) == null) {
                throw new IllegalArgumentException();
            } else {
                CastContext var4;
                if ((var4 = CastContext.getSharedInstance(var0)) != null) {
                    var3.setRouteSelector(Objects.requireNonNull(var4.getMergedSelector()));
                }

                Object var10000 = null;
            }
        } catch (Exception e) {
            //do nothing
        }
    }

    private static void zza(Context var0, @NonNull MediaRouteButton var1, MediaRouteDialogFactory var2) {
        try {
            Preconditions.checkMainThread("Must be called from the main thread.");
            CastContext var3;
            if ((var3 = CastContext.getSharedInstance(var0)) != null) {
                var1.setRouteSelector(Objects.requireNonNull(var3.getMergedSelector()));
            }

            Object var10000 = null;
        } catch (Exception e) {
            //do nothing
        }
    }
}
