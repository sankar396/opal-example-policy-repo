package app.rbs

default allow = false

allow {
	resourceActions = data.resource_actions[input.resource].actions
	input.action = resourceActions[_]

    some i
    input.attribute[i].name == "dept"
    input.attribute[i].value == "25"

    some j
    input.attribute[j].name == "age"
    input.attribute[j].value == "27"
}

# creating policy fully into rego files as below
allow {

    actions := {"read","update"}
	input.resource == "STO"
	uuid = "abcd"
    input.action = actions[_]
    some i
    input.attribute[i].name == "dept"
    input.attribute[i].value == "25"

    some j
    input.attribute[j].name == "age"
    input.attribute[j].value < "27"
}

