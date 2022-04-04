import sys
import pystache
import json

def render_ms(template, obj):
    return ms_renderer.render(template, obj)

# json file containing the pystache parameters
parameterfile = sys.argv[1]

# Select the desired partials & template files
# Partials are evaluated first, before all the other parameters
partials = json.load(open("partials.json", "r"))  # File with partials for pystache
file = open("test_input_template.xml.ms", "r").read()
# Conserved Vector Current partials & template:
# partials = json.load(open('partials_CVC.json','r')) # File with partials for pystache
# file = open('input_template_CVC.xml.ms', 'r').read() # Input template

# Read the parameters file and print kappa as check
parameters = json.load(open(parameterfile, "r"))  # parameters_allq.json
print(parameters["kappas"][0]["kappa"])

# Extract the kappa values from the json file and make a string for the file name
if len(parameters["kappas"]) == 1:
    kappastr = (
        "kp"
        + parameters["kappas"][0]["kappa"][2:]
        + "kp"
        + parameters["kappas"][0]["kappa"][2:]
    )
elif len(parameters["kappas"]) == 2:
    kappastr = (
        "kp"
        + parameters["kappas"][0]["kappa"][2:]
        + "kp"
        + parameters["kappas"][1]["kappa"][2:]
    )
outname = kappastr

# Make a string for the beta value if it exists in the dictionary
if "beta" in parameters:
    betastr = "b" + parameters["beta"][0] + "p" + parameters["beta"][2:]
    # betastr = 'b'+str(parameters['beta'])[0]+'p'+str(parameters['beta'])[2:]
    outname = betastr + outname
outname = "chromatemplate_" + outname + ".xml"
print(outname)

# Run pystache to replace the templates with their values and save to the output file
template = pystache.parse(file)
ms_renderer = pystache.Renderer(partials=partials)  # Apply the partials
open(outname, "w+").write(
    render_ms(template, parameters).replace("[[", "{{").replace("]]", "}}")
)


# "fh_params"     : "{{#fh-params}}{{#op}}_{{lam_real}}_g{{opval}}_{{#q}}{{.}}{{/q}}{{/op}}{{/fh-params}}" //Only works with real lambdas for now
