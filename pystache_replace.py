import pystache

file = open('input_template.xml.ms', 'r').read()
template = pystache.parse(file)

parameters = {"kappas" : [{"kappa" : 0.12104},
                          {"kappa" : 0.12062}],
              "src_smr" : 30,
              "sink_smearing" : [{"sink_type" : "POINT_SINK"},
                                 {"sink_type" : "SHELL_SINK", "smearing" : {"smintpar" : 30}},
                                 {"sink_type" : "SHELL_SINK", "smearing" : {"smintpar" : 60}}],
              "momenta" : [{"momentum" : "4 4 0"},
                           {"momentum" : "4 2 0"},
                           {"momentum" : "2 2 2"},
                           {"momentum" : "2 0 0"}
              ],
              "operators" : ["2", "8"]
}

#[{"momentum" : "4 4 0"},
# {"momentum" : "4 2 0"},
# {"momentum" : "2 2 2"},
# {"momentum" : "2 0 0"}]

partials = {"prop_id" : "{{#fh-params}}fh_{{/fh-params}}prop_{{kappa}}"}

ms_renderer = pystache.Renderer(partials = partials)
def render_ms(template, obj):
    return ms_renderer.render(template,obj)

open('test_output.xml', 'w+').write(render_ms(template, parameters))
