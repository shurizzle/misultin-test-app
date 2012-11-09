REBAR_CONFIG:=$(PWD)/rebar.config
INCLUDE_DIR:=include
SRC_DIR:=src

all: compile

deps:
	@./rebar get-deps

compile: deps
	@./rebar compile

clean:
	@./rebar clean
	-@rm -rf erl_crash.dump deps

test: compile
	@./rebar ct
