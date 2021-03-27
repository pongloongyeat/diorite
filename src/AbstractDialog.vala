/*
 * Copyright 2021 Pong Loong Yeat (https://github.com/pongloongyeat/diorite)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 */

public class Diorite.AbstractDialog : Granite.MessageDialog {
    public signal void dialog_close ();

    public AbstractDialog (string _primary_text,
                           string _secondary_text,
                           string? _image_icon_name="",
                           string? ok_text="",
                           bool suggested=false,
                           bool destructive=false,
                           Gtk.ButtonsType _buttons=Gtk.ButtonsType.CLOSE) {

        // Apply defaults
        if (_image_icon_name == null || _image_icon_name == "") {
            _image_icon_name = "dialog-information";
        }

        /* Generally speaking, if there is a request to show
        text in a suggested action, then it should no longer
        default to a simple dialog with a "Close" action
        and should instead show the suggested action and a
        cancel button. */
        if (ok_text != null && ok_text != "") {
            _buttons = Gtk.ButtonsType.CANCEL;
        }

        base.with_image_from_icon_name (_primary_text, _secondary_text, _image_icon_name, _buttons);

        /* Need to do this after construct */
        if (ok_text != null && ok_text != "") {
            var suggested_button = new Gtk.Button.with_label (ok_text);

            // Ignore if both are set to true
            if (!(suggested && destructive)) {
                if (suggested) {
                    suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
                }

                if (destructive) {
                    suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
                }
            }

            add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);
        }
    }

    construct {
        response.connect ((response) => {
            if (response == Gtk.ResponseType.ACCEPT) {
                // Return a value
            }
            dialog_close ();
            destroy ();
        });
    }
}
