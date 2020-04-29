import json
import re

print("Starting static type checker")
file = open("output.txt")
parsed = []
unit = {}
functions = []
declerations = {}
definations = {}
calls = {}
error = False
for line in file:
    if "Defination" in line:
        unit["type"] = "Defination"
        unit["params"] = []
    elif "Declaration" in line:
        unit["type"] = "Declaration"
        unit["params"] = []
    elif "Call" in line:
        unit["type"] = "Call"
        unit["params"] = []
    elif "Function Name" in line:
        unit["name"] = re.split("Function Name:", line)[1].rstrip("\n").strip()
    elif "Function Return Type" in line:
        unit["Return Type"] = (
            re.split("Function Return Type:", line)[1].rstrip("\n").strip()
        )
    elif "Parameter of type" in line:
        unit["params"].append(
            re.split("Parameter of type", line)[1]
            .rstrip("\n")
            .strip()
            .replace("float/double", "float")
        )
    elif re.match("Parameter [a-zA-Z][_a-zA-Z0-9]* of type", line) is not None:
        unit["params"].append(
            re.split("Parameter [a-zA-Z][_a-zA-Z0-9]* of type", line)[1]
            .rstrip("\n")
            .strip()
        )
    elif "*****************" in line:
        if unit["type"] == "Defination":
            unit["params"].reverse()
        parsed.append(unit)
        unit = {}
print(json.dumps(parsed, indent=4))
print()
print("*****************\n\n")
for i in parsed:
    functions.append(i["name"])
    if i["type"] == "Defination":
        definations[i["name"]] = i
    elif i["type"] == "Declaration":
        declerations[i["name"]] = i
    elif i["type"] == "Call":
        calls[i["name"]] = i
functions = list(set(functions))
for func in functions:
    if func in declerations.keys() and func in calls.keys():
        if not declerations[func]["params"] == calls[func]["params"]:
            print(
                "Type Mismatch in Function Decleration and Function Call of %s" % (func)
            )
            print("Decleration parameter types:" + str(declerations[func]["params"]))
            print("Call parameter types:" + str(calls[func]["params"]))
            error = True
            print()
            print("*****************\n\n")
    if func in definations.keys() and func in calls.keys():
        if not definations[func]["params"] == calls[func]["params"]:
            print(
                "Type Mismatch in Function Defination and Function Call of %s" % (func)
            )
            print("Defination parameter types:" + str(definations[func]["params"]))
            print("Call parameter types:" + str(calls[func]["params"]))
            print()
            error = True
            print("*****************\n\n")
    if func in definations.keys() and func in declerations.keys():
        if not definations[func]["params"] == declerations[func]["params"]:
            print(
                "Type Mismatch in Function Defination and Function Decleration of %s"
                % (func)
            )
            print("Defination parameter types:" + str(definations[func]["params"]))
            print("Decleration parameter types:" + str(declerations[func]["params"]))
            print()
            error = True
            print("*****************\n\n")
        if not definations[func]["Return Type"] == declerations[func]["Return Type"]:
            print(
                "Return Type Mismatch in Function Defination and Function Decleration of %s"
                % (func)
            )
            print("Defination return type:" + str(definations[func]["Return Type"]))
            print("Decleration return type:" + str(declerations[func]["Return Type"]))
            print()
            error = True
            print("*****************\n\n")
    if func in calls.keys() and func not in definations.keys():
        print("Undefined reference to %s\nFunction body not found" % (func))
        print()
        error = True
        print("*****************\n\n")
    if func in declerations.keys() and func not in definations.keys():
        print("Function body for %s not written" % (func))
        print()
        error = True
        print("*****************\n\n")
if not error:
    print("No Type Errors found")
    print()
    print("*****************\n\n")
