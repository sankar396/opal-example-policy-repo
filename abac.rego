package app.abac

import future.keywords.every

default allow = false

allow {
	roles = input.roles # Replenishment, access_admin
	print.info("Testing @@@ print")
}

eval(r, "equals", c) {
    r == c
}
