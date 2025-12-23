#include "gtk_utils.h"

GtkWidget* create_button_from_icon(const guint8* icon_data, int width, int height, int padding) {
    GdkPixbuf *pixbuf = gdk_pixbuf_new_from_inline(-1, icon_data, FALSE, NULL);
    GdkPixbuf *scaled_pixbuf = gdk_pixbuf_scale_simple(pixbuf, width, height, GDK_INTERP_BILINEAR);
    GtkWidget *image = gtk_image_new_from_pixbuf(scaled_pixbuf);
    GtkWidget *button = gtk_button_new();
    gtk_button_set_image(GTK_BUTTON(button), image);
    gtk_container_set_border_width(GTK_CONTAINER(button), padding);
    g_object_unref(pixbuf);
    g_object_unref(scaled_pixbuf);
    return button;
}