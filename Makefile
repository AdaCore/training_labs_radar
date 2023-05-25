.PHONY: ALWAYS

all: html_doc
	# nothing

html_doc: ALWAYS
	make -C doc html

generate: ALWAYS
	adacut -m question src/020_declarations/template/declarations_main.adb > src/020_declarations/src/declarations_main.adb
	adacut -m answer src/020_declarations/template/declarations_main.adb > src/020_declarations/answers/declarations_main.adb
	adacut -m question src/030_basic_types/template/basic_types_main.adb > src/030_basic_types/src/basic_types_main.adb
	adacut -m answer src/030_basic_types/template/basic_types_main.adb > src/030_basic_types/answers/basic_types_main.adb
	adacut -m question src/040_statements/template/statements_main.adb > src/040_statements/src/statements_main.adb
	adacut -m answer src/040_statements/template/statements_main.adb > src/040_statements/answers/statements_main.adb
