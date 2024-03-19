package app.abac

import future.keywords.every

default allow = false
default data_is_available = false
default data2_is_available = false

allow {
	roles = input.roles # Replenishment, access_admin
	print("Found role", roles)
	policies = data.dss.resource_policies[input.resource] #from data

	#print("Found policy=ies", policies)
	inputAttributeMap := input.attribute
	print("inputAttributeMap: ", inputAttributeMap)

	some i, j
	role_policies = data.dss.role_policies[roles[i]]
	print("Found role_policies", role_policies)
	policyName := role_policies[j]
	print("Found policyName", policyName)
	policy := policies[policyName]
	print("Found policy", policy)
	input.action = policy.actions[_]
    	every attribute in policy.attributes {
     	 print("Found attribute", attribute)
     	 inputAttr := inputAttributeMap[attribute.name]
     	 print("Found input attribute", inputAttr)
     	 eval(attribute.value,attribute.operation,inputAttr.value)
     	 #attribute.value == inputAttr.value
    	}
	
}

data_is_available {
	test = data.dss
}

data2_is_available {
	test = data.dst
}

eval(r, "equals", c) {
    print("@@ Evaluating attribute",r) 
    r == c
}
