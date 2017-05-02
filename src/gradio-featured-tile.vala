/* This file is part of Gradio.
 *
 * Gradio is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Gradio is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Gradio.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

namespace Gradio{

	[GtkTemplate (ui = "/de/haecker-felix/gradio/ui/featured-tile.ui")]
	public class FeaturedTile : Gtk.Button{

		[GtkChild] private Label StationTitle;
		[GtkChild] private Label StationDescription;
		[GtkChild] private Image StationLogo;

		public FeaturedTile(RadioStation station){
			StationTitle.set_text(station.title);

			StationLogo.set_from_pixbuf(Util.optiscale(station.pixbuf, 192));
			station.notify["icon"].connect(() => {
				StationLogo.set_from_pixbuf(Util.optiscale(station.pixbuf, 192));
			});

			// Description
			station.get_description.begin((obj,res) => {
				string desc = station.get_description.end(res);
				StationDescription.set_text(desc);
				StationDescription.set_visible(true);
			});

			this.clicked.connect(() => {
				Gradio.App.window.show_station_details(station);
			});
		}
	}
}
