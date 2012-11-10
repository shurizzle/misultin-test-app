-module(erweb_app).
-export([start/0, start/1, stop/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start() -> start(8000).

start(Port) ->
  misultin:start_link([{port, Port}, {loop, fun(Req) -> handle_http(Req) end}]).

stop() ->
  misultin:stop().

handle_http(Req) ->
  handle(Req:get(method), Req:resource([lowercase, urldecode]), Req).

handle('GET', [], Req) ->
  {ok, Res} = index_dtl:render(),
  Req:ok([{"Content-Type", "text/html"}], Res);

handle('GET', ["users"], Req) ->
  {ok, Res} = users_dtl:render(),
  Req:ok([{"Content-Type", "text/html"}], Res);

handle('GET', ["users", UserName], Req) ->
  {ok, Res} = users_user_dtl:render([{"User", UserName}]),
  Req:ok([{"Content-Type", "text/html"}], Res);

handle('GET', ["users", UserName, "messages"], Req) ->
  {ok, Res} = users_user_messages_dtl:render([{"User", UserName}]),
  Req:ok([{"Content-Type", "text/html"}], Res);

handle(_, _, Req) ->
  Req:respond(404, [{"Content-Typpe", "text/plain"}], "Page not found.").
