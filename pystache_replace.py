import sys
import pystache
import json

parameterfile = sys.argv[1]
conf=parameterfile[11:27]
print(conf)
partials = json.load(open('partials.json','r'))
parameters = json.load(open(parameterfile,'r')) #parameters_allq.json 

#file = open('input_template.xml.ms', 'r').read()
file = open('test_input_template.xml.ms', 'r').read()
template = pystache.parse(file)
ms_renderer = pystache.Renderer(partials = partials)
def render_ms(template, obj):
    return ms_renderer.render(template,obj)
open('chromatemplate_'+conf+'.xml', 'w+').write(render_ms(template, parameters).replace('[[', '{{').replace(']]', '}}'))



##"fh_params"     : "{{#fh-params}}{{#op}}_{{lam_real}}_g{{opval}}_{{#q}}{{.}}{{/q}}{{/op}}{{/fh-params}}" //Only works with real lambdas for now
