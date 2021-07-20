Nonterminals orders order_indiv fleet_or_army order hold_order invade_order convoy_order support_order territory_wo_lineno.
Terminals '-' separator hold support convoy army fleet territory.
Rootsymbol orders.

orders -> order_indiv orders: ['$1' | '$2'].
orders -> '$empty' : [].
order_indiv -> fleet_or_army order separator : fleet_or_army_lineno_to_top({'$1', '$2'}).
order_indiv -> fleet_or_army order : fleet_or_army_lineno_to_top({'$1', '$2'}).

order -> hold_order : '$1'.
order -> invade_order : '$1'.
order -> convoy_order : '$1'.
order -> support_order : '$1'.

hold_order -> territory_wo_lineno : {hold, '$1'}.
hold_order -> territory_wo_lineno hold : {hold, '$1'}.

invade_order -> territory_wo_lineno '-' territory_wo_lineno : {invade, '$1', '$3'}.

convoy_order -> territory_wo_lineno convoy invade_order : {convoy, '$1', '$3'}.

support_order -> territory_wo_lineno support hold_order : {support, '$1', '$3'}.
support_order -> territory_wo_lineno support invade_order : {support, '$1', '$3'}.


territory_wo_lineno -> territory : remove_lineno('$1').

fleet_or_army -> fleet : '$1'.
fleet_or_army -> army  : '$1'.

Erlang code.

remove_lineno({Token, _LineNo, Chars}) -> {Token, Chars};
remove_lineno({Token, _Lineno}) -> {Token}.

fleet_or_army_lineno_to_top({{ArmyOrFleet, LineNo}, Order}) -> {ArmyOrFleet, Order, LineNo}.
