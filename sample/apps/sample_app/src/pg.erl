-module(pg).
-compile([export_all, nowarn_export_all]).

mypg() ->
  %{ok, C} = epgsql:connect("localhost", "user", "pass", [{database, "databasename"}, {port, 6432}, {timeout, 2000}]),
  %En = epgsql:squery(C, "SET CLIENT_ENCODING TO 'UTF8'"),
  Conn = epgsql:connect("localhost", "user", "pass", [{database, "databasename"}, {port, 6432}, {timeout, 3000}]),
  case Conn of
    {ok, C} ->
      C;
    {error, M} ->
      io:format("~p~n", [M]),
      {error, M}
      %error
  end.


select(Mpid,Q,A) ->
  %Mpid = pg:mypg(),
  case epgsql:equery(Mpid, Q, A) of
    {ok,_,R} ->
      %epgsql:close(Mpid),
      R;
    {error,E} ->
      %epgsql:close(Mpid),
      io:format("~p~n", [E]),
      {error,E}
  end.


in_up_del(Mpid,Q,A) ->
  %Mpid = pg:mypg(),
  case epgsql:equery(Mpid, Q, A) of
    {ok,R} ->
      %epgsql:close(Mpid),
      R;
    {error,E} ->
      %epgsql:close(Mpid),
      io:format("~p~n", [E]),
      {error,E}
  end.


returning(Mpid,Q,A) ->
  %Mpid = pg:mypg(),
  case epgsql:equery(Mpid, Q, A) of
    {ok,1,_,R} ->
      %epgsql:close(Mpid),
      R;
    {error,E} ->
      %epgsql:close(Mpid),
      io:format("~p~n", [E]),
      {error,E}
  end.


