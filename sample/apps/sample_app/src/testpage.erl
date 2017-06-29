-module(testpage).
-compile([export_all, nowarn_export_all]).
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/wf.hrl").

main() ->
  #dtl{file="test_page",app=sample_app,bindings=[]}.

event(init) ->
  [];

event(_) -> [].
