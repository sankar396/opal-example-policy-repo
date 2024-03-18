package app.abac

import future.keywords.every

default allow = false

allow {
	print("Testing @@@ print")
}

eval(r, "equals", c) {
    r == c
}
