package app.rbs

default allow = false

# Allow read for admin_access
allow {
	role_is_admin_access
}

allow {
	roleAttr = data.role_permission.attributes[input.role]
	input.attribute = roleAttr[_]
}
