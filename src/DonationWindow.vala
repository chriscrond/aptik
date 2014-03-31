/*
 * DonationWindow.vala
 * 
 * Copyright 2012 Tony George <teejee2008@gmail.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */
 
using Gtk;

using TeeJee.Logging;
using TeeJee.FileSystem;
using TeeJee.DiskPartition;
using TeeJee.JSON;
using TeeJee.ProcessManagement;
using TeeJee.GtkHelper;
using TeeJee.Multimedia;
using TeeJee.System;
using TeeJee.Misc;

public class DonationWindow : Dialog {
	public DonationWindow(bool on_exit) {
		title = "Donate";
        window_position = WindowPosition.CENTER_ON_PARENT;
		set_destroy_with_parent (true);
		set_modal (true);
        skip_taskbar_hint = false;
        set_default_size (400, 20);	
		
		//set app icon
		try{
			this.icon = new Gdk.Pixbuf.from_file ("""/usr/share/pixmaps/conky-manager.png""");
		}
        catch(Error e){
	        log_error (e.message);
	    }

		//vbox_main
	    Box vbox_main = get_content_area();
		vbox_main.margin = 6;
		vbox_main.homogeneous = false;
		
		get_action_area().visible = false;
		
		//lbl_message
		Label lbl_message = new Gtk.Label("");
		//string msg = _("Did you find this software useful?\n\nYou can buy me a coffee or make a donation via PayPal to show your support. Or just drop me an email and say Hi.\n\nThis application is free and will continue to remain that way. Your contributions will help in developing it further and making it more awesome!\n\nFeel free to drop me a mail if you find any issues or if you have suggestions for improvement.\n\nRegards,\nTony George\nteejeetech@gmail.com");
		string msg = _("Did you find this software useful?\nPlease consider making a donation to show your support.\n\nThis application is free and will continue to remain that way. Your contributions will help in keeping this project alive and developing it further.\n\nFeel free to mail me if you find any issues or if you need any changes in this application. I can be reached at teejeetech@gmail.com.\n\nRegards,\nTony George");
		lbl_message.label = msg;
		lbl_message.wrap = true;
		vbox_main.pack_start(lbl_message,true,true,0);
		
		//vbox_actions
        Box vbox_actions = new Box (Orientation.VERTICAL, 6);
		vbox_actions.margin_left = 80;
		vbox_actions.margin_right = 80;
		vbox_actions.margin_top = 20;
		vbox_main.pack_start(vbox_actions,false,false,0);

		//btn_donate
		Button btn_donate = new Button.with_label("   " + _("Donate via PayPal") + "   ");
		vbox_actions.add(btn_donate);
		btn_donate.clicked.connect(()=>{
			xdg_open("https://www.paypal.com/cgi-bin/webscr?business=teejee2009@gmail.com&cmd=_xclick&currency_code=USD&amount=10&item_name=Conky%20Manager%20Donation");
		});

		//btn_send_email
		Button btn_send_email = new Button.with_label("   " + _("Send Email") + "   ");
		vbox_actions.add(btn_send_email);
		btn_send_email.clicked.connect(()=>{
			xdg_open("mailto:" + AppAuthorEmail);
		});
		
		//btn_visit
		Button btn_visit = new Button.with_label("   " + _("Visit Website") + "   ");
		vbox_actions.add(btn_visit);
		btn_visit.clicked.connect(()=>{
			xdg_open("http://www.teejeetech.in");
		});
		
		if (on_exit){
			//btn_exit_no_show
			Button btn_exit_no_show = new Button.with_label("   " + _("Don't Show This Again") + "   ");
			vbox_actions.add(btn_exit_no_show);
			
			btn_exit_no_show.clicked.connect(() => {
				App.donation_disable = true;
				this.destroy();
			});
		}
		else{
			//btn_exit
			Button btn_exit = new Button.with_label("   " + _("OK") + "   ");
			vbox_actions.add(btn_exit);
			
			btn_exit.clicked.connect(() => {
				this.destroy();
			});
		}
	}

}
