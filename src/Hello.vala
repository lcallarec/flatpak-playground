namespace Hello {

	using Gtk;

	public class Main : Object {

		public static int main(string[] args) {
			Gtk.init (ref args);

			var window = new Window ();
			window.title = "Hello";
			window.border_width = 0;
			window.window_position = WindowPosition.CENTER;
			window.set_default_size (350, 70);
			window.destroy.connect (Gtk.main_quit);


			var button = new Button.with_label("{0_0}");

			button.clicked.connect (() => {
				button.label = "Sandboxed Gtk+ version is : %u.%u.%u".printf(Gtk.get_major_version(), Gtk.get_minor_version(), Gtk.get_micro_version());
			});

			window.add(button);
			window.show_all();

			Gtk.main();

			return 0;
		}

	}
}
