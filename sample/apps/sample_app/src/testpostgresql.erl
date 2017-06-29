-module(testpostgresql).
-compile([export_all, nowarn_export_all]).
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/wf.hrl").

main() ->
  
  Mpid = pg:mypg(),
  R = pq:select_all(Mpid),
  
  R2 = case R of
    [] ->
      <<"<p>not found</p>">>;
    [{_, _, _, _, _, _}|_] ->
      hm:format_result(R);
    _ ->
      <<"<p>database conn error</p>">>
  end,
  epgsql:close(Mpid),
  
  Result = [<<"We have:<br>">>, R2],
  
  #dtl{file="template2",app=sample_app,bindings=[
       {html, Result} ]}.

event(init) ->
  [];

event(_) -> [].
