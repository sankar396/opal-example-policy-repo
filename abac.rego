package app.abac

import future.keywords.every

default allow = false
default data_is_available = false

data_is_available {
	test = data.dss
}

allow {
	print("Found evaluation Subject Role")
    	input.evalSubject == "ROLE"
	roles = input.roles # Replenishment, access_admin
	print("Found role Policy ", roles)
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

allow {
	print("Found evaluation Subject USER")
	input.evalSubject == "USER"
	userId = input.user # s0s0hg8
	print("USER POLICY ", userId)
	print("Found user", userId)
	policies = data.dss.resource_policies[input.resource] #from data

	#print("Found policy=ies", policies)
	inputAttributeMap := input.attribute
	print("inputAttributeMap: ", inputAttributeMap)
	userEval(input.evalType,data,userId,policies,inputAttributeMap)
    	}
	
}

userEval("OR",data,userId,policies,inputAttributeMap) {
    print("Eval type OR")
    some j
    user_policies = data.dss.user_policies[userId]
    print("Found user_policies ", user_policies)
    policyName := user_policies[j]
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

userEval("AND",data,userId,policies,inputAttributeMap) {
    print("Eval type AND")
    every j
    user_policies = data.dss.user_policies[userId]
    print("Found user_policies ", user_policies)
    policyName := user_policies[j]
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

eval(r, "equals", c) {
    print("@@ Evaluating attribute",r) 
    r == c
}
