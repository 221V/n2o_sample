-module(pq).
-compile([export_all, nowarn_export_all]).

%postgresql queries module

% select_all(Mpid)
% select_one(Mpid, Id)
% 

select_all(Mpid) ->
  pg:select(Mpid, "SELECT id, title, text, status, inserted_at, updated_at FROM test_table ORDER BY id DESC", []).


select_(Mpid, Id) ->
  pg:select(Mpid, "SELECT id, title, text, status, inserted_at, updated_at FROM test_table WHERE id = $1 LIMIT 1", [Id]).


