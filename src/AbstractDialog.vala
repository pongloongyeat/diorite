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
                                 string _image_icon_name="dialog-information",
                                 Gtk.ButtonsType _buttons=Gtk.ButtonsType.CLOSE) {
        base.with_image_from_icon_name (_primary_text, _secondary_text, _image_icon_name, _buttons);
    }

    construct {
        response.connect ((response) => {
            if (response == Gtk.ResponseType.CLOSE) {
                dialog_close ();
                destroy ();
            }
        });
    }
}
