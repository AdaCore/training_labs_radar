.PHONY: ALWAYS

all:
	# nothing

generate: ALWAYS
	adacut -m question src/020_declarations/template/lab_declaration_main.adb > src/020_declarations/src/lab_declaration_main.adb
	adacut -m answer src/020_declarations/template/lab_declaration_main.adb > src/020_declarations/answers/lab_declaration_main.adb
	adacut -m question src/030_basic_types/template/lab_basic_types_main.adb > src/030_basic_types/src/lab_basic_types_main.adb
	adacut -m answer src/030_basic_types/template/lab_basic_types_main.adb > src/030_basic_types/answers/lab_basic_types_main.adb
	adacut -m question src/040_statements/template/lab_statements_main.adb > src/040_statements/src/lab_statements_main.adb
	adacut -m answer src/040_statements/template/lab_statements_main.adb > src/040_statements/answers/lab_statements_main.adb
