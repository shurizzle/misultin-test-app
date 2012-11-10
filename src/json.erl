-module(json).
-export([mime_type/0, encode/1, decode/1]).

mime_type() ->
  rfc4627:mime_type().

encode(Term) ->
  rfc4627:encode(Term).

decode(Term) ->
  rfc4627:decode(Term).
