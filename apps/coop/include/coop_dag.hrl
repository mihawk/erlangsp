
%% Extra single data flow methods to add:
%%   TODO: Add 'shuffle' to randomly sample without duplicates
%%   TODO: Add 'consume' to use round_robin but expire at end of task
%%          consume requires {Init_Count, Threshold_Count, Replenish_Count}

-type single_data_flow_method() :: random | round_robin.

%% Extra multiple data flow methods to add:
%%    TODO: Add 'multichoice' for selecting subset of nodes

-type multiple_data_flow_method() :: broadcast.

-type data_flow_method() :: single_data_flow_method() | multiple_data_flow_method().

-type task_function() :: {module(), atom()}.
-type downstream_workers() :: queue().

-type coop_head() :: {coop_head, pid(), pid()}.
-type coop_node() :: {coop_node, pid(), pid()}.

%% Coop internal tokens are uppercase prefixed with '$$_'.
%% Applications should avoid using this prefix for atoms.
-define(DAG_TOKEN,  '$$_DAG').
-define(DATA_TOKEN, '$$_DATA').
-define(CTL_TOKEN,  '$$_CTL').
-define(ROOT_TOKEN, '$$_ROOT').

%% TODO: Convert these to a function call instead of a macro.
-define(SEND_CTL_MSG(__Coop_Node, __Ctl_Msg),
        {coop_node, __Ctl_Pid, __Task_Pid} = __Coop_Node,
        __Ctl_Pid ! {?DAG_TOKEN, ?CTL_TOKEN, __Ctl_Msg}).

-define(SEND_CTL_MSG(__Coop_Node, __Ctl_Msg, __Flag, __Caller),
        {coop_node, __Ctl_Pid, __Task_Pid} = __Coop_Node,
        __Ctl_Pid ! {?DAG_TOKEN, ?CTL_TOKEN, __Ctl_Msg, __Flag, __Caller}).

