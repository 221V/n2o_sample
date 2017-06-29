-module(testpage2).
-compile([export_all, nowarn_export_all]).
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/wf.hrl").

main() ->
  HTML = #dtl{file = "test_page2", app=sample_app,bindings=[ 
      {test_text,<<"777">>} ]},
  
  #dtl{file="template",app=sample_app,bindings=[
       {html, wf:render(HTML)} ]}.

event(init) ->
  [];

event(_) -> [].
