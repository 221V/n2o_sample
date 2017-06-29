{application,syn,
             [{description,"A global Process Registry and Process Group manager."},
              {vsn,"1.1.0"},
              {registered,[syn_consistency,syn_registry,syn_groups]},
              {applications,[kernel,stdlib,mnesia]},
              {mod,{syn_app,[]}},
              {env,[]},
              {modules,[syn,syn_app,syn_backbone,syn_consistency,syn_groups,
                        syn_registry,syn_sup,syn_utils]}]}.
