Red/System [
	Title:	"GTK3 imports"
	Author: "Qingtian Xie"
	File: 	%gtk.reds
	Tabs: 	4
	Rights: "Copyright (C) 2016 Qingtian Xie. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

#define RED_GTK_APP_ID	"org.red-lang.www"

#define gobj_signal_connect(instance signal handler data) [
	g_signal_connect_data instance signal as-integer handler data null 0
]

#define G_ASCII_DTOSTR_BUF_SIZE	39

RECT_STRUCT: alias struct! [
	left		[integer!]
	top			[integer!]
	right		[integer!]
	bottom		[integer!]
]

tagPOINT: alias struct! [
	x		[integer!]
	y		[integer!]	
]

tagSIZE: alias struct! [
	width	[integer!]
	height	[integer!]
]

GdkEventKey!: alias struct! [
  type          [integer!]
  window        [int-ptr!]
  send_event    [byte!]
  time          [integer!]
  state         [integer!]
  keyval        [integer!]
  length        [integer!]
  string        [c-string!]
  keycode       [integer!]      ;-- keycode & group & is_modifier
  ;guint16 hardware_keycode;
  ;guint8 group;
  ;guint is_modifier : 1;
]
#enum GtkFileChooserAction! [
  GTK_FILE_CHOOSER_ACTION_OPEN
  GTK_FILE_CHOOSER_ACTION_SAVE
  GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER
  GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER
]

#either OS = 'Windows [
	;#define LIBGOBJECT-file "libgobject-2.0-0.dll"
	;#define LIBGLIB-file	"libglib-2.0-0.dll"
	;#define LIBGIO-file		"libgio-2.0-0.dll"
	;#define LIBGDK-file		"libgdk-3-0.dll"
	#define LIBGTK-file		"libgtk-3-0.dll"
	;#define LIBCAIRO-file	"libcairo-2.dll"
][
	;#define LIBGOBJECT-file "libgobject-2.0.so.0"
	;#define LIBGLIB-file	"libglib-2.0.so.0"
	;#define LIBGIO-file		"libgio-2.0.so.0"
	;#define LIBGDK-file		"libgdk-3.so.0"
	#define LIBGTK-file		"libgtk-3.so.0"
	;#define LIBCAIRO-file	"libcairo.so"
]

#import [
	LIBGTK-file cdecl [
	;; LIBGOBJECT-file cdecl [
		g_object_set_qdata: "g_object_set_qdata" [
			object		[int-ptr!]
			quark		[integer!]
			data		[int-ptr!]
		]
		g_object_get_qdata: "g_object_get_qdata" [
			object		[int-ptr!]
			quark		[integer!]
			return:		[int-ptr!]
		]
		g_signal_connect_data: "g_signal_connect_data" [
			instance	[int-ptr!]
			signal		[c-string!]
			handler		[integer!]
			data		[int-ptr!]
			notify		[int-ptr!]
			flags		[integer!]
			return:		[integer!]
		]
		g_object_unref: "g_object_unref" [
			object		[int-ptr!]
		]
	;; ]
	;; LIBGDK-file cdecl [
		gdk_screen_width: "gdk_screen_width" [
			return:		[integer!]
		]
		gdk_screen_height: "gdk_screen_height" [
			return:		[integer!]
		]
		gdk_screen_get_default: "gdk_screen_get_default" [
			return:		[handle!]
		]
	;; ]
	;; LIBGLIB-file cdecl [
		g_quark_from_string: "g_quark_from_string" [
			string		[c-string!]
			return:		[integer!]
		]
		g_main_context_default: "g_main_context_default" [
			return:		[integer!]
		]
		g_main_context_acquire: "g_main_context_acquire" [
			context		[integer!]
			return:		[logic!]
		]
		g_main_context_release: "g_main_context_release" [
			context		[integer!]
		]
		g_main_context_iteration: "g_main_context_iteration" [
			context		[integer!]
			block?		[logic!]
			return:		[logic!]
		]
		g_list_length: "g_list_length" [
			list		[int-ptr!]
			return:		[integer!]
		]
		g_ascii_dtostr: "g_ascii_dtostr" [
			buffer		[c-string!]
			buf_len		[integer!]
			d			[float!]
			return:		[c-string!]
		]
		g_strdup_printf: "g_strdup_printf" [
			[variadic]
			return:		[c-string!]
		]
		g_free: "g_free" [
			pointer		[handle!]
		]
	;; ]
	;; LIBGIO-file cdecl [
		g_application_register: "g_application_register" [
			application [handle!]
			cancellable [int-ptr!]
			error		[int-ptr!]
			return:		[logic!]
		]
		g_settings_sync: "g_settings_sync" []
	;; ]
	;; LIBGTK-file cdecl [
		gtk_application_new: "gtk_application_new" [
			app-id		[c-string!]
			flags		[integer!]
			return:		[handle!]
		]
		gtk_application_get_windows: "gtk_application_get_windows" [
			app			[handle!]
			return:		[int-ptr!]
		]
		g_application_activate: "g_application_activate" [
			app			[handle!]
		]
		gtk_application_get_active_window: "gtk_application_get_active_window" [
			app			[handle!]
			return:		[handle!]
		]
		gtk_application_window_new: "gtk_application_window_new" [
			app			[handle!]
			return:		[handle!]
		]
		gtk_application_add_window: "gtk_application_add_window" [
			app			[handle!]
			window		[handle!]
		]
		gtk_application_remove_window: "gtk_application_remove_window" [
			app			[handle!]
			window		[handle!]
		]
		gtk_file_chooser_dialog_new: "gtk_file_chooser_dialog_new" [
			[variadic]
			return:		[handle!]
		]
		gtk_dialog_run: "gtk_dialog_run" [
			widget 		[handle!]
			return:		[integer!]
		]
		gtk_file_chooser_get_filename: "gtk_file_chooser_get_filename" [
			widget 		[handle!]
			return:		[c-string!]
		]
		; gtk_file_chooser_native_new: "gtk_file_chooser_native_new" [
		; 	[variadic]
		; 	return:		[handle!]
		; ]
		; gtk_native_dialog_run: "gtk_native_dialog_run" [
		; 	widget 		[handle!]
		; 	return:		[integer!]
		; ]
		gtk_window_new: "gtk_window_new" [
			type		[integer!]
			return:		[handle!]
		]
		gtk_window_set_title: "gtk_window_set_title" [
			window		[handle!]
			title		[c-string!]
		]
		gtk_window_set_default_size: "gtk_window_set_default_size" [
			window		[handle!]
			width		[integer!]
			height		[integer!]
		]
		gtk_window_move: "gtk_window_move" [
			window		[handle!]
			x			[integer!]
			y			[integer!]
		]
		gtk_window_present: "gtk_window_present" [
			window		[handle!]
		]
		gtk_window_is_active: "gtk_window_is_active" [
			window		[handle!]
			return:		[logic!]
		]
		gtk_window_set_modal: "gtk_window_set_modal" [
			window		[handle!]
			setting		[logic!]
		]
		gtk_window_set_transient_for: "gtk_window_set_transient_for" [
			window		[handle!]
			parent		[handle!]
		]
		gtk_window_iconify: "gtk_window_iconify" [
			window		[handle!]
		]
		gtk_window_close: "gtk_window_close" [
			window		[handle!]
		]
		gtk_window_set_destroy_with_parent: "gtk_window_set_destroy_with_parent" [
			window		[handle!]
			setting		[logic!]
		]
		gtk_widget_queue_draw: "gtk_widget_queue_draw" [
			widget		[handle!]
		]
		gtk_widget_show_all: "gtk_widget_show_all" [
			widget		[handle!]
		]
		gtk_widget_hide: "gtk_widget_hide" [
			widget		[handle!]
		]
		gtk_widget_grab_focus: "gtk_widget_grab_focus" [
			widget		[handle!]
		]
		gtk_widget_set_size_request: "gtk_widget_set_size_request" [
			widget		[handle!]
			width		[integer!]
			height		[integer!]
		]
		gtk_widget_set_can_focus: "gtk_widget_set_can_focus" [
			widget		[handle!]
			focus		[logic!]
		]
		gtk_widget_set_focus_on_click: "gtk_widget_set_focus_on_click" [
			widget		[handle!]
			focus		[logic!]
		]
		gtk_widget_destroy: "gtk_widget_destroy" [
			widget 	[handle!]
		]
		gtk_container_add: "gtk_container_add" [
			container	[handle!]
			widget		[handle!]
		]
		gtk_container_get_children: "gtk_container_get_children" [
			container	[handle!]
			return:		[int-ptr!]
		]
		gtk_frame_new: "gtk_frame_new" [
			label		[c-string!]
			return: 	[handle!]
		]
		gtk_frame_set_label_align: "gtk_frame_set_label_align" [
			frame		[handle!]
			xalign		[float!]
			yalign		[float!]
		]
		gtk_frame_set_shadow_type: "gtk_frame_set_shadow_type" [
			frame		[handle!]
			shadow		[integer!]
		]
		gtk_fixed_new: "gtk_fixed_new" [
			return:		[handle!]
		]
		gtk_fixed_put: "gtk_fixed_put" [
			fixed		[handle!]
			widget		[handle!]
			x			[integer!]
			y			[integer!]
		]
		gtk_bin_get_child: "gtk_bin_get_child" [
			bin			[handle!]
			return:		[handle!]
		]
		gtk_list_box_new: "gtk_list_box_new" [
			return:		[handle!]
		]
		gtk_list_box_select_row: "gtk_list_box_select_row" [
			listbox		[handle!]
			row			[handle!]
		]
		gtk_list_box_get_selected_row: "gtk_list_box_get_selected_row" [
			listbox		[handle!]
			return:		[handle!]
		]
		gtk_list_box_get_row_at_index: "gtk_list_box_get_row_at_index" [
			listbox		[handle!]
			index		[integer!]
			return:		[handle!]
		]
		gtk_list_box_row_get_index: "gtk_list_box_row_get_index" [
			row			[handle!]
			return:		[integer!]
		]
		gtk_scrolled_window_new: "gtk_scrolled_window_new" [
			hadj		[handle!]
			vadj		[handle!]
			return:		[handle!]
		]
		gtk_button_new_with_label: "gtk_button_new_with_label" [
			label		[c-string!]
			return:		[handle!]
		]
		gtk_check_button_new_with_label: "gtk_check_button_new_with_label" [
			label		[c-string!]
			return:		[handle!]
		]
		gtk_radio_button_new_with_label: "gtk_radio_button_new_with_label" [
			group		[handle!]
			label		[c-string!]
			return:		[handle!]
		]
		gtk_radio_button_new_with_label_from_widget: "gtk_radio_button_new_with_label_from_widget" [
			group		[handle!]
			label		[c-string!]
			return:		[handle!]
		]
		gtk_toggle_button_get_active: "gtk_toggle_button_get_active" [
			button		[handle!]
			return:		[logic!]
		]
		gtk_toggle_button_get_inconsistent: "gtk_toggle_button_get_inconsistent" [
			button		[handle!]
			return:		[logic!]
		]
		gtk_toggle_button_set_inconsistent: "gtk_toggle_button_get_inconsistent" [
			button		[handle!]
			inconsist?	[logic!]
		]
		gtk_toggle_button_set_active: "gtk_toggle_button_set_active" [
			button		[handle!]
			active?		[logic!]
		]
		gtk_drawing_area_new: "gtk_drawing_area_new" [
			return:		[handle!]
		]
		gtk_label_new: "gtk_label_new" [
			label		[c-string!]
			return:		[handle!]
		]
		gtk_label_get_text: "gtk_label_get_text" [
			label		[handle!]
			return:		[c-string!]
		]
		gtk_entry_new: "gtk_entry_new" [
			return:		[handle!]
		]
		gtk_entry_get_buffer: "gtk_entry_get_buffer" [
			entry		[handle!]
			return:		[handle!]
		]
		gtk_entry_buffer_set_text: "gtk_entry_buffer_set_text" [
			buffer		[handle!]
			text		[c-string!]
			len			[integer!]
		]
		gtk_scale_new_with_range: "gtk_scale_new_with_range" [
			vertical?	[logic!]
			min			[float!]
			max			[float!]
			step		[float!]
			return:		[handle!]
		]
		gtk_scale_set_draw_value: "gtk_scale_set_draw_value" [
			scale		[handle!]
			draw?		[logic!]
		]
		gtk_scale_set_has_origin: "gtk_scale_set_has_origin" [
			scale		[handle!]
			origin?		[logic!]
		]
		gtk_range_set_value: "gtk_range_set_value" [
			range		[handle!]
			value		[float!]
		]
		gtk_range_get_value: "gtk_range_get_value" [
			range		[handle!]
			return:		[float!]
		]
		gtk_progress_bar_new: "gtk_progress_bar_new" [
			return:		[handle!]
		]
		gtk_text_view_new: "gtk_text_view_new" [
			return:		[handle!]
		]
		gtk_text_view_get_buffer: "gtk_text_view_get_buffer" [
			view		[handle!]
			return:		[handle!]
		]
		gtk_text_buffer_set_text: "gtk_text_buffer_set_text" [
			buffer		[handle!]
			text		[c-string!]
			len			[integer!]
		]
		gtk_combo_box_text_new: "gtk_combo_box_text_new" [
			return:		[handle!]
		]
		gtk_combo_box_text_new_with_entry: "gtk_combo_box_text_new_with_entry"  [
			return:		[handle!]
		]
		gtk_combo_box_text_append_text: "gtk_combo_box_text_append_text" [
			combo		[handle!]
			item 		[c-string!]
		]
		gtk_combo_box_text_remove_all: "gtk_combo_box_text_remove_all" [
			combo		[handle!]
		]
		gtk_combo_box_get_active: "gtk_combo_box_get_active" [
			combo		[handle!]
			return: 	[integer!]
		]
		gtk_combo_box_set_active: "gtk_combo_box_set_active" [
			combo		[handle!]
			item		[integer!]
		]
		gtk_combo_box_text_get_active_text: "gtk_combo_box_text_get_active_text"  [
			combo		[handle!]
			return:		[c-string!]
		]
		gtk_notebook_new: "gtk_notebook_new" [
			return:		[handle!]
		]
		gtk_notebook_append_page: "gtk_notebook_append_page" [
			nb			[handle!]
			pane		[handle!]
			label		[handle!]
			return: 	[integer!]
		]
		gtk_notebook_get_current_page: "gtk_notebook_get_current_page" [
			nb			[handle!]
			return: 	[integer!]
		]

		gtk_notebook_get_nth_page: "gtk_notebook_get_nth_page" [
			nb			[handle!]
			index	 	[integer!]
			return: 	[handle!]
		]
		gtk_notebook_get_tab_label_text: "gtk_notebook_get_tab_label_text" [
			nb			[handle!]
			page		[handle!]
			return:		[c-string!]
		]
		gtk_notebook_get_n_pages: "gtk_notebook_get_n_pages" [
			nb			[handle!]
			return: 	[integer!]	
		]
		gtk_css_provider_new: "gtk_css_provider_new" [
			return:		[handle!]
		]
		gtk_css_provider_load_from_data: "gtk_css_provider_load_from_data" [
			provider	[handle!]
			data		[c-string!]
			length		[integer!]
			error		[handle!]
		]
		gtk_style_context_add_provider: "gtk_style_context_add_provider" [
			context		[handle!]
			provider	[handle!]
			priority	[integer!]
		]
		gtk_style_context_add_provider_for_screen: "gtk_style_context_add_provider_for_screen" [
			screen		[handle!]
			provider	[handle!]
			priority	[integer!]
		]
		gtk_style_context_add_class: "gtk_style_context_add_class" [
			context		[handle!]
			class		[c-string!]
		]
		gtk_widget_get_style_context: "gtk_widget_get_style_context" [
			widget		[handle!]
			return:		[handle!]
		]
	;; LIBCAIRO-file cdecl [
		cairo_line_to: "cairo_line_to" [
			cr			[handle!]
			x			[float!]
			y			[float!]
		]
		cairo_curve_to: "cairo_curve_to" [
			cr			[handle!]
			x1			[float!]
			y1			[float!]
			x2			[float!]
			y2			[float!]
			x3			[float!]
			y3			[float!]
		]
		cairo_move_to: "cairo_move_to" [
			cr			[handle!]
			x			[float!]
			y			[float!]
		]
		cairo_arc: "cairo_arc" [
			cr			[handle!]
			xc			[float!]
			yc			[float!]
			radius		[float!]
			angle1		[float!]
			angle2		[float!]
		]
		cairo_rectangle: "cairo_rectangle" [
			cr			[handle!]
			x			[float!]
			y			[float!]
			w			[float!]
			h			[float!]
		]
		cairo_new_sub_path: "cairo_new_sub_path" [
			cr			[handle!]
		]
		cairo_close_path: "cairo_close_path" [
			cr			[handle!]
		]
		cairo_stroke: "cairo_stroke" [
			cr			[handle!]
		]
		cairo_fill: "cairo_fill" [
			cr			[handle!]
		]
		cairo_fill_preserve: "cairo_fill_preserve" [
			cr			[handle!]
		]
		cairo_paint: "cairo_paint" [
			cr			[handle!]
		]
		cairo_save: "cairo_save" [
			cr			[handle!]
		]
		cairo_restore: "cairo_restore" [
			cr			[handle!]
		]
		cairo_set_source_rgba: "cairo_set_source_rgba" [
			cr			[handle!]
			red			[float!]
			green		[float!]
			blue		[float!]
			alpha		[float!]
		]
		cairo_set_line_width: "cairo_set_line_width" [
			cr			[handle!]
			width		[float!]
		]
		cairo_set_source: "cairo_set_source" [
			cr			[handle!]
			source		[handle!]
		]
		cairo_set_source_surface: "cairo_set_source_surface" [
			cr			[handle!]
			surface		[handle!]
			x			[float!]
			y			[float!]
		]
		cairo_get_source: "cairo_get_source" [
			cr			[handle!]
			return:		[handle!]
		]
		cairo_set_antialias: "cairo_set_antialias" [
			cr			[handle!]
			antialias	[integer!]
		]
		cairo_surface_destroy: "cairo_surface_destroy" [
			surface		[handle!]
		]
		cairo_pattern_create_linear: "cairo_pattern_create_linear" [
			x0			[float!]
			y0			[float!]
			x1			[float!]
			y1			[float!]
			return:		[handle!]
		]
		cairo_pattern_create_radial: "cairo_pattern_create_radial" [
			cx0			[float!]
			cy0			[float!]
			radius0		[float!]
			cx1			[float!]
			cy1			[float!]
			radius1		[float!]
			return:		[handle!]
		]
		cairo_pattern_add_color_stop_rgba: "cairo_pattern_add_color_stop_rgba" [
			pattern		[handle!]
			offset		[float!]
			red			[float!]
			green		[float!]
			blue		[float!]
			alpha		[float!]
		]
		cairo_pattern_destroy: "cairo_pattern_destroy" [
			pattern		[handle!]
		]
	]
]
