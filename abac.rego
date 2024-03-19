package app.abac

import future.keywords.every

default allow = false

allow {
	print("Testing @@@1 print")
	print("@@ DATA ",data.dss)
	
}

eval(r, "equals", c) {
    r == c
}
