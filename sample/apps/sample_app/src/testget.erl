-module(testget).
-compile([export_all, nowarn_export_all]).
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/wf.hrl").

main() ->
  
  A = wf:qp(<<"a">>),
  
  B = case A of
    undefined ->
      10;
    _ ->
      10 + erlang:binary_to_integer(A)
  end,
  
  Result = [<<"We have ">>, erlang:integer_to_binary(B)],
  
  HTML = #dtl{file = "test_page2", app=sample_app,bindings=[ 
       {test_text, Result} ]},
  
  #dtl{file="template",app=sample_app,bindings=[
       {html, wf:render(HTML)} ]}.

event(init) ->
  [];

event(_) -> [].
