import pystache

file = open('input_template.xml.ms', 'r').read()
template = pystache.parse(file)

parameters = {"kappas" : [{"kappa" : 0.12104}
                          , {"kappa" : 0.12062}]
              , "kappas2" : [{"kappa2" : 0.12104}
                          , {"kappa2" : 0.12062}]
              , "src_smr" : 30
              , "sink_smearing" : [{"sink_type" : "POINT_SINK"}
                                   , {"sink_type" : "SHELL_SINK"
                                      , "smearing" : {"smintpar" : 30}
                                   }
                                   , {"sink_type" : "SHELL_SINK"
                                      , "smearing" : {"smintpar" : 60}
                                   }]
              , "momenta" : [{"fh-params" : [ {"q" : ["4","4","0"]},
                                              {"q" : ["-4","-4","0"]}]
                              , "mom2max" : "8"
                              , "unperturbed" : "True"}
                             , {"fh-params" : [{"q" : ["4","2","0"]},
                                               {"q" : ["-4","-2","0"]}]
                                , "mom2max" : "5"}
                             , {"fh-params" : [{"q" : ["2","2","2"]},
                                               {"q" : ["-2","-2","-2"]}]
                                , "mom2max" : "3"}
                             , {"fh-params" : [{"q" : ["2","0","0"]},
                                               {"q" : ["-2","0","0"]}]
                                , "mom2max" : "1"}]
              , "operators" : [{"op" : [{"opval" : "2", "lam_real" : "0.0001", "lam_imag" : "0"},
                                        {"opval" : "8", "lam_real" : "0", "lam_imag" : "0"}]
                                }
                               , {"op" : [{"opval" : "2", "lam_real" : "0", "lam_imag" : "0"},
                                          {"opval" : "8", "lam_real" : "0.0001", "lam_imag" : "0"}]
                               }
              ]
              , "lambda" :  0.0001
              , "combinations" : [{"kappa1" : "0.12104"
                                   , "kappa2" : "0.12104"}
                                  , {"kappa1" : "0.12104"
                                     , "kappa2" : "0.12062"}
                                  , {"kappa1" : "0.12062"
                                     , "kappa2" : "0.12104"}]
              # "lam_imag" :  0
}

params2 = {"fh-params" : [ {"lam_real" : "0.0001", "lam_imag" : "0", "q" : ["4","4","0"]}
                           ,{"lam_real" : "0.0001", "lam_imag" : "0", "q" : ["4","4","0"]}]}

                           
partials = {"prop_id"     : "{{#fh-params}}fh_{{/fh-params}}prop_{{kappa}}{{>fh_params}}"
            , "comb_id1" : "prop_{{kappa1}}"
            , "comb_id2" : "prop_{{kappa2}}"
            , "comb_pert_id1" : "{{#fh-params}}fh_{{/fh-params}}prop_{{kappa1}}{{>fh_params}}"
            , "comb_pert_id2" : "{{#fh-params}}fh_{{/fh-params}}prop_{{kappa2}}{{>fh_params}}"
            , "fh_params" : "{{#fh-params}}{{#op}}_{{lam_real}}_g{{opval}}_{{#q}}{{.}}{{/q}}{{/op}}{{/fh-params}}"
}

ms_renderer = pystache.Renderer(partials = partials)
def render_ms(template, obj):
    return ms_renderer.render(template,obj)
open('test_output.xml', 'w+').write(render_ms(template, parameters).replace('[[', '{{').replace(']]', '}}'))
