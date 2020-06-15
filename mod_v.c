/*
 *
 * Copyright (C) 2020. Seven Du <dujinfang@gmail.com> ALL RIGHTS RESERVED
 *
 * mod_v.c -- V mod
 *
 */

#include <switch.h>

#include "code_v.c"

/* Prototypes */
SWITCH_MODULE_SHUTDOWN_FUNCTION(mod_v_shutdown);
SWITCH_MODULE_LOAD_FUNCTION(mod_v_load);

/* SWITCH_MODULE_DEFINITION(name, load, shutdown, runtime)
 * Defines a switch_loadable_module_function_table_t and a static const char[] modname
 */
SWITCH_MODULE_DEFINITION(mod_v, mod_v_load, mod_v_shutdown, NULL);

/* Macro expands to: switch_status_t mod_v_load(switch_loadable_module_interface_t **module_interface, switch_memory_pool_t *pool) */
SWITCH_MODULE_LOAD_FUNCTION(mod_v_load)
{
	_vinit(); // v init

	*module_interface = switch_loadable_module_create_module_interface(pool, modname);

	switch_log_printf(SWITCH_CHANNEL_LOG, SWITCH_LOG_ERROR, "mod_v load\n");

	int c = freeswitch__sum(1, 2);

	switch_log_printf(SWITCH_CHANNEL_LOG, SWITCH_LOG_ERROR, "sum = %d\n", c);

	mod_v__load(module_interface, pool);

	return SWITCH_STATUS_SUCCESS;
}

/*
  Called when the system shuts down
  Macro expands to: switch_status_t mod_v_shutdown() */
SWITCH_MODULE_SHUTDOWN_FUNCTION(mod_v_shutdown)
{
	return SWITCH_STATUS_SUCCESS;
}

/* For Emacs:
 * Local Variables:
 * mode:c
 * indent-tabs-mode:t
 * tab-width:4
 * c-basic-offset:4
 * End:
 * For VIM:
 * vim:set softtabstop=4 shiftwidth=4 tabstop=4 noet
 */
