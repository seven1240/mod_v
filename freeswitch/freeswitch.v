module freeswitch

#flag -I/usr/local/freeswitch/include/freeswitch -L/usr/local/freeswitch/lib -lfreeswitch
#include "switch.h"

pub fn C.switch_core_set_globals()
pub fn C.switch_core_init_and_modload()
pub fn C.switch_core_runtime_loop()
fn C.switch_loadable_module_create_module_interface()

struct C.switch_loadable_module_interface_t

pub fn sum(a int, b int) int
{
	return a + b
}

pub fn create_module_interface(pool voidptr, name string) voidptr
{
	return C.switch_loadable_module_create_module_interface(pool, name.str)
}

struct C.switch_loadable_module_function_table_t {}

[typedef]
struct C.switch_stream_handle_t {
	read_function &C.switch_stream_handle_read_function_t
	write_function &C.switch_stream_handle_write_function_t
}

pub fn stream_write_function(stream &C.switch_stream_handle_t, s string)
{
	println(s)
//	tmp := stream.write_function
//	tmp(stream, s.str)
}

[typedef]
struct C.switch_api_interface_t {
mut:
	interface_name byteptr
	desc byteptr
	function voidptr
	syntax byteptr
	rwlock voidptr
	refs int
	reflock voidptr
	parent voidptr
	next voidptr
}

struct C.switch_application_interface_t {
mut:
	interface_name byteptr
	application_function voidptr
	long_desc byteptr
	short_desc byteptr
	syntax byteptr
	flags int
	rwlock voidptr
	refs int
	reflock voidptr
	parent voidptr
	next voidptr
}

fn C.switch_loadable_module_create_interface()

pub fn add_api(module_interface voidptr, pool voidptr, func voidptr) {
	mut api_int := &C.switch_api_interface_t(C.switch_loadable_module_create_interface(module_interface, C.SWITCH_API_INTERFACE))
	api_int.interface_name = "v".str
	api_int.desc = "v".str
	api_int.function = func
	api_int.syntax = "".str
}

pub fn add_app(module_interface voidptr, pool voidptr, func voidptr) {
	mut app_int := &C.switch_application_interface_t(C.switch_loadable_module_create_interface(module_interface, C.SWITCH_APPLICATION_INTERFACE))
	app_int.interface_name = "v".str
	app_int.application_function = func
	app_int.long_desc = "v".str
	app_int.short_desc = "v".str
	app_int.syntax = "".str
}

[typedef]
struct C.switch_frame_t {
	codec voidptr
	source byteptr
	packet voidptr
	packetlen int
	extra_data voidptr
	data voidptr
	datalen int
	buflen int
	samples int
	channels int
	payload byte
	timestamp int
	seq i16
	ssrc int
	m byte
	flags int
	user_data voidptr
	pmap voidptr
	img voidptr
	geometry C.switch_frame_geometry
}

fn C.switch_core_session_read_frame()

pub fn switch_core_session_read_frame(session voidptr) int {
	read_frame := &C.switch_frame_t{}

	C.switch_core_session_read_frame(session, &read_frame, C.SWITCH_IO_FLAG_SINGLE_READ, 0)

	len := read_frame.datalen
	println(len.str())
	return 1
}
