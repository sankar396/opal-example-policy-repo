package app.rbs

default allow = false

allow {
	roleAttr = data.role_permission.attributes[input.role]
	input.attribute = roleAttr[_]
}
