-module(erweb_app).
-export([start/1, stop/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(Port) ->
  misultin:start_link([{port, Port}, {loop, fun(Req) -> handle_http(Req) end}]).

stop() ->
  misultin:stop().

handle_http(Req) ->
  handle(Req:get(method), Req:resource([lowercase, urldecode]), Req).

handle('GET', [], Req) ->
  Req:ok([{"Content-Type", "text/plain"}], "Main home page.");

handle('GET', ["users"], Req) ->
  Req:ok([{"Content-Type", "text/plain"}], "Main users root.");

handle('GET', ["users", UserName], Req) ->
  Req:ok([{"Content-Type", "text/plain"}], "This is ~s's page.", [UserName]);

handle('GET', ["users", UserName, "messages"], Req) ->
  Req:ok([{"Content-Type", "text/plain"}], "this is ~s's messages page.", [UserName]);

handle(_, _, Req) ->
  Req:respond(404, [{"Content-Typpe", "text/plain"}], "Page not found.").
