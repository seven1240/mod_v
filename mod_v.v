module mod_v

import freeswitch

struct FreeswitchFunctionTable {
	switch_api_version int
	load voidptr
	shutdown voidptr
	runtime voidptr
	flags int
}

pub fn mod_v_loadx(module_interface mut &voidptr, pool voidptr) {

	*module_interface = freeswitch.create_module_interface(pool, "mod_v")
}

const (
	module_interface = FreeswitchFunctionTable{5, load, C.NULL, C.NULL, 0}
)

fn api_function(cmd byteptr, session voidptr, stream voidptr) int
{
	println("api")
	println(cmd)
	freeswitch.stream_write_function(stream, "+OK api in V")

	return 0
}

fn app_function(session voidptr, data byteptr)
{
	println("app in V")

	mut i := 0
	for i < 100 {
		status := freeswitch.switch_core_session_read_frame(session)
		println(i)
		i++
	}
}

pub fn load(module_interface mut &voidptr, pool voidptr) int {
	*module_interface = freeswitch.create_module_interface(pool, "mod_v_")

	freeswitch.add_api(*module_interface, pool, api_function)
	freeswitch.add_app(*module_interface, pool, app_function)

	return 0
}
