#### This script contains only find and replace instructions for trasnforming a Knora compliant OWL ontology into an OWL ontology that can be visualized by http://visualdataweb.de/webvowl/ ####

#### Before running it, change the paths of input and output files ####

#### Once the transformation is done, upload the ontology in http://visualdataweb.de/webvowl/. Customize the settings, for example, the degree of collapsing can be adjusted when there are lots of nodes ####


import re

infile = open('/path/to/file/xxx-onto.ttl', 'r')
outfile = open('/path/to/file/xxx-onto2webVowl.ttl', 'w')
data = infile.read()

# Delete all knora-base objects, transform object and subject contraints into range and domain
new_data = re.sub('roud.+Value.+\n+.+\n+.+\n+.+\n+.+LinkValue .','', re.sub('roud.+Value.+\n+.+(\n+.+)?LinkValue .', '', re.sub('rdfs:range knora-base:.*;', 'rdfs:range rdfs:Literal;', re.sub(',\n+\s+rdfs:label', ';\n\n\t\t\trdfs:label', (re.sub(';\n(\s)*rdfs:subClassOf knora-base:(.)*',',',re.sub(';\n(\s)*rdfs:subPropertyOf knora-base:(.)*',';',re.sub('knora-base:objectClassConstraint','rdfs:range',re.sub('knora-base:subjectClassConstraint','rdfs:domain',re.sub('rdfs:subPropertyOf(\s+)knora-base:hasValue ;','', data))))))))))

outfile.write(new_data)
outfile.close
# output can be processed by http://visualdataweb.de/webvowl/



# compile patterns does not work .. but it does elsewhere .. something with the infile
# patterns = [('rdf', 'a'),
#            ('CLASSES', ''),
#            [';\n(\s)*rdfs:subClassOf knora-base:(.)*,', 'ö']]
# for (p1,p2) in patterns:
#    p = re.compile(p1)
#    new_filedata = p.sub(p2,filedata)
