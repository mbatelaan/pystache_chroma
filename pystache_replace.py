import sys
import pystache
import json

parameterfile = sys.argv[1] # file containing the pystache parameters
conf=parameterfile[11:27] # Extract kappa values
print(conf)
partials = json.load(open('partials.json','r')) # File with partials for pystache
parameters = json.load(open(parameterfile,'r')) #parameters_allq.json 

file = open('test_input_template.xml.ms', 'r').read()
#file = open('input_template_CC.xml.ms', 'r').read() # Input template
template = pystache.parse(file)
ms_renderer = pystache.Renderer(partials = partials) # Apply the partials
def render_ms(template, obj):
    return ms_renderer.render(template,obj)
open('chromatemplate_'+conf+'.xml', 'w+').write(render_ms(template, parameters).replace('[[', '{{').replace(']]', '}}'))



##"fh_params"     : "{{#fh-params}}{{#op}}_{{lam_real}}_g{{opval}}_{{#q}}{{.}}{{/q}}{{/op}}{{/fh-params}}" //Only works with real lambdas for now
