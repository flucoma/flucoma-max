/**
	@file
	simpletext - show use of text reading and editing

	@ingroup	examples
*/

#include "c74_max.h"
#include <string>
#include <fstream>

using namespace c74::max;

struct t_simpletext {
	t_object	ob;
	t_object*	editor;
	std::string	text;
};


static t_class* this_class = nullptr;


void* simpletext_new(t_symbol* name, long argc, t_atom* argv) {
	return object_alloc(this_class);
}


void simpletext_free(t_simpletext* self) {
	;
}


void simpletext_dblclick(t_simpletext* self) {
	if (self->editor)
		object_attr_setchar(self->editor, gensym("visible"), 1);
	else {
		self->editor = (t_object*)object_new(CLASS_NOBOX, gensym("jed"), self, 0);
		object_method_direct(void, (t_object*, const char*, t_symbol*),
							 self->editor, gensym("settext"), self->text.c_str(), gensym("utf-8"));
		object_attr_setchar(self->editor, gensym("scratch"), 1);
		object_attr_setsym(self->editor, gensym("title"), gensym("simpletext"));
	}
}


void simpletext_doread(t_simpletext* self, t_symbol* s, long argc, t_atom* argv) {
	char		filename[MAX_FILENAME_CHARS];
	char		fullpath[MAX_PATH_CHARS];
	short		path;
	t_fourcc	type = 'TEXT';
	long		err;

	if (s == gensym("")) {
		filename[0] = 0;
		if (open_dialog(filename, &path, &type, &type, 1))
			return; // cancelled
	} 
	else {
		strncpy(filename, s->s_name, MAX_FILENAME_CHARS);
		if (locatefile_extended(filename, &path, &type, &type, 1)) {
			object_error((t_object*)self, "can't find file %s", filename);
			return; // error
		}
	}
	
	err = path_toabsolutesystempath(path, filename, fullpath);
	if (!err) {
		std::ifstream filestream(fullpath);
		self->text.assign((std::istreambuf_iterator<char>(filestream)), std::istreambuf_iterator<char>());
	}
	else
		object_error((t_object*)self, "can't get full path for file %s", filename);
}


void simpletext_read(t_object* self, t_symbol* s) {
	defer(self, (method)simpletext_doread, s, 0, NULL);
}


void simpletext_edclose(t_simpletext* self, char** text, long size) {
	self->text.assign(*text, size);
	self->editor = nullptr;
}


void simpletext_assist(t_simpletext* self, void* unused, t_assist_function io, long index, char* string_dest) {
	if (io == ASSIST_INLET)
		strncpy(string_dest, "Message In", ASSIST_STRING_MAXSIZE);
}


void ext_main(void* r) {
	this_class = class_new("simpletext", (method)simpletext_new, (method)simpletext_free, sizeof(t_simpletext), 0L, A_GIMME, 0);
	
	class_addmethod(this_class, (method)simpletext_read,		"read",		A_DEFSYM, 0);
	class_addmethod(this_class, (method)simpletext_dblclick,	"dblclick",	A_CANT, 0);
	class_addmethod(this_class, (method)simpletext_edclose,		"edclose",	A_CANT, 0);
	
	class_register(CLASS_BOX, this_class);
}
