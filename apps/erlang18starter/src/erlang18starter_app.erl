%%%-------------------------------------------------------------------
%% @doc erlang18starter public API
%% @end
%%%-------------------------------------------------------------------

-module(erlang18starter_app).

-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/", hello_handler, []}]}
    ]),
    {ok, _} = cowboy:start_http(my_http_listener, 100, 
        [{port, os:getenv("PORT")}], [{env, [{dispatch, Dispatch}]}]
    ),
    erlang18starter_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================