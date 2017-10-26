#!/usr/bin/python
# Airport data parser
# 10/2017 John Cottrell
# Input data format: csv text file

print("Parsing airports file...")
f = open('airports.csv')

stateDict = {}

# Build dictionary of stateCodes and names from supplied data
for lines in f:
    fields = lines.split(",")
    stateCode = fields[3]   # key
    stateName = fields[4]   # value
    if stateCode not in stateDict.keys():
        stateDict[stateCode] = stateName

print("Dictionary contents:")
for i in stateDict:
    print i, stateDict[i]

print("=== Start of JSON output ===")
print("{\"airports\": [")

for key, value in stateDict.iteritems():

    records = []
    print("{")
    print("\"stateCode\": \"" + key + "\",")
    print("\"stateName\": \"" + value + "\",")

    f.seek(0)
    for lines in f:
        fields = lines.split(",")
        if(fields[3] == key):
            records.append(lines)

    print("\"Data\":[")
    for index in range(len(records)):
        print("{")
        data = records[index].split(",")
        print("\"cityName\":" + "\"" + data[0] + "\",")
        print("\"airportName\":" + "\"" + data[1] + "\",")
        print("\"airportCode\":" + "\"" + data[2] + "\",")
        print("\"lat\":" + "\"" + data[5] + "\",")
        print("\"lon\":" + "\"" + data[6] + "\",")
        print("\"website\":" + "\"" + data[7].rstrip().lstrip() + "\"")

        if(index < len(records)-1):
            print("},")
        else:
            print("}]},")
print("]}")
