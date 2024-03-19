package app.abac

import future.keywords.every

default allow = false

allow {
	print("Testing @@@1 print")
	print("DATA ",data.result.dss)
	
}

eval(r, "equals", c) {
    r == c
}
