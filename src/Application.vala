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

public class Diorite.Application : Gtk.Application {
    public const OptionEntry[] CLI_OPTIONS = {
        { "primary-text", '\0', OptionFlags.NONE, OptionArg.STRING, out primary_text, "Required: Primary text in dialog", null },
        { "secondary-text", '\0', OptionFlags.NONE, OptionArg.STRING, out secondary_text, "Required: Secondary text in dialog", null },
        { "image-icon-name", '\0', OptionFlags.NONE, OptionArg.STRING, out image_icon_name, "Image icon name for dialog.", null },
        { null }
    };

    public static string primary_text;
    public static string secondary_text;
    public static string image_icon_name;

    construct {
        application_id = "com.github.pongloongyeat.diorite";
        flags = ApplicationFlags.FLAGS_NONE;
        add_main_option_entries (CLI_OPTIONS);
    }

    protected override void activate () {
        if (image_icon_name == null) {
            image_icon_name = "dialog-information";
        }

        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });

        var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (primary_text, secondary_text, image_icon_name, Gtk.ButtonsType.CLOSE);

        message_dialog.response.connect ((response) => {
            if (response == Gtk.ResponseType.CLOSE) {
                message_dialog.destroy ();
                release ();
            }
        });
        message_dialog.show_all ();

        // Since there's no window, GTK will exit so it needs to be held and released on exit.
        hold ();
    }

    public static int main (string[] args) {
        try {
			var opt_context = new OptionContext ();
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (CLI_OPTIONS, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			printerr (_("error: %s\n"), e.message);
			printerr (_("Run '%s --help' to see a full list of available command line options.\n"), args[0]);
			return 1;
		}

        if (primary_text == null) {
            printerr (_("error: No value for argument primary-text\n"));
            return -1;
        }

        if (secondary_text == null) {
            printerr (_("error: No value for argument secondary-text\n"));
            return -1;
        }

        return new Application ().run (args);
    }
}
