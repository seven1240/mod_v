all:
	v -g -shared -o mod_v_ .

install:
	cp mod_v_.so /usr/local/freeswitch/mod/

# the C way

.PHONY code_v.c: freeswitch/freeswitch.v mod_v.v main.v
	v -show_c_cmd -o code_v.c .

c: code_v.c
	gcc -I/usr/local/freeswitch/include/freeswitch -L/usr/local/freeswitch/lib -shared -o mod_v.so -lfreeswitch mod_v.c

install-c:
	cp mod_v.so /usr/local/freeswitch/mod/
