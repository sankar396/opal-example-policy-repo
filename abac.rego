package app.abac

import future.keywords.every

default allow = false

allow {
	roles = input.roles # Replenishment, access_admin
	print("Found role", roles)
	policies = data.result.dss.resource_policies[input.resource] #from data

	#print("Found policy=ies", policies)
	inputAttributeMap := input.attribute
	print("inputAttributeMap: ", inputAttributeMap)

	some i, j
	role_policies = data.result.dss.role_policies[roles[i]]
	print("Found role_policies", role_policies)
	policyName := role_policies[j]
	print("Found policyName", policyName)
	policy := policies[policyName]
	print("Found policy", policy.actions)
	input.action = policy.actions[_]
    	every attribute in policy.attributes {
     	 #print("Found attribute", attribute)
     	 inputAttr := inputAttributeMap[attribute.name]
     	 #print("Found input attribute", inputAttr)
     	 eval(attribute.value,attribute.operation,inputAttr.value)
     	 #attribute.value == inputAttr.value
    	}
}

eval(r, "equals", c) {
    r == c
}
