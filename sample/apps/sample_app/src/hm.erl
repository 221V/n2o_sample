-module(hm).
-compile([export_all, nowarn_export_all]).

%help module

% post_value(Req, Key) % Req, Binary
% format_result(Data)
% format_date({Year,Month,Day},{Hour,Minit,Second})
% 


random_bytes(Length) ->
  crypto:strong_rand_bytes(Length).


random_unsigned_int(A, B) ->
  Size = erlang:byte_size(binary:encode_unsigned(B)),
  Rand_value = crypto:bytes_to_integer(?MODULE:random_bytes(Size)),
  Result = A + (Rand_value rem (B - A + 1)),
  if Result > B ->
      ?MODULE:random_unsigned_int(A, B);
    true -> 
      Result
  end.


random_latin_int_string(Length) ->
  random_latin_int_string(Length, <<"">>).
random_latin_int_string(Length, Result) ->
  Str = <<"0123456789abcdefghijklmnopqrstuvwxyz">>,
  if erlang:byte_size(Result) < Length ->
      Rand_place = ?MODULE:random_unsigned_int(0,35),
      Result1 = binary:part(Str,{Rand_place,1}),
      Result2 = <<Result/binary, Result1/binary>>,
      ?MODULE:random_latin_int_string(Length, Result2);
    true ->
      Result
  end.


post_value(Req, Key) ->
  {ok, PostStr, _} = wf:request_body(Req),
  PostList = cow_qs:parse_qs(PostStr),
  post_value2( [ Value || {_Key1, Value} <- PostList, _Key1 =:= Key ] ).

% helper
post_value2([]) -> undefined;
post_value2([Val|_]) -> Val;
post_value2(_) -> undefined.


format_result(Data) ->
  ?MODULE:format_result2(Data,[]).

% helper
format_result2([], Acc) -> Acc;
format_result2([{Id, Title, Text, Status, Inserted_at, Updated_at}|T], Acc) ->
  V = [<<"<p>id:">>, erlang:integer_to_binary(Id), <<" title:">>, Title, <<" text:">>, Text, <<" status:">>, erlang:integer_to_binary(Status), <<" inserted_at:">>, ?MODULE:format_date(Inserted_at), <<" updated_at:">>, ?MODULE:format_date(Updated_at), <<"</p>">>],
  ?MODULE:format_result2(T,[V|Acc]).


%format_date({2017,6,29},{18,54,12.0})
format_date({{Year,Month,Day},{Hour,Minit,Second}}) ->
  Month2 = if Month < 10 ->
      [<<"0">>, erlang:integer_to_binary(Month)];
    Month >= 10 ->
      erlang:integer_to_binary(Month)
  end,
  
  Day2 = if Day < 10 ->
      [<<"0">>, erlang:integer_to_binary(Day)];
    Day >= 10 ->
      erlang:integer_to_binary(Day)
  end,
  
  Hour2 = if Hour < 10 ->
      [<<"0">>, erlang:integer_to_binary(Hour)];
    Hour >= 10 ->
      erlang:integer_to_binary(Hour)
  end,
  
  Minit2 = if Minit < 10 ->
      [<<"0">>, erlang:integer_to_binary(Minit)];
    Minit >= 10 ->
      erlang:integer_to_binary(Minit)
  end,
  
  Second2 = erlang:binary_to_integer(erlang:float_to_binary(Second, [{decimals, 0}])),
  Second3 = if Second2 < 10 ->
      [<<"0">>, erlang:integer_to_binary(Second2)];
    Second2 >= 10 ->
    erlang:integer_to_binary(Second2)
  end,
  
  [erlang:integer_to_binary(Year), <<"/">>, Month2, <<"/">>, Day2, <<"-">>, Hour2, <<":">>, Minit2, <<":">>, Second3].


