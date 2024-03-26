package app.abac

import future.keywords.every

default allow = false
default data_is_available = false

data_is_available {
	test = data.dss
}

allow {
	print("Found  evaluation Subject Role")
    	input.evalSubject == "ROLE"
	roles = input.roles # Replenishment, access_admin
	print("Found role Policy: ", roles)
	policies = data.dss.resource_policies[input.resource] #from data

	#print("Found policies", policies)
	userEval(input.evalType,policies,roles)
	
}


roleEval("OR",policies,roles) {
    print("Eval type OR")
    inputAttributeMap := input.attribute
    print("inputAttributeMap: ", inputAttributeMap)
    some i
    role_policies = data.dss.role_policies[roles[i]]
    print("Found role_policies ", role_policies)
     some k
     policyName := role_policies[k]
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

roleEval("AND",policies,roles) {
    print("Eval type AND")
    print("Found roles ", roles)
    inputAttributeMap := input.attribute
    print("inputAttributeMap: ", inputAttributeMap)
    print("Found roles ", roles)
    some i
    foundRole := roles[i]
    print("Found ith role ", foundRole)
    role_policies = data.dss.role_policies[foundRole]
    print("Found role_policies ", role_policies)
    every policyName in role_policies {
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
}

allow {
	print("Found evaluation Subject  USER")
	input.evalSubject == "USER"
	userId = input.user # s0s0hg8
	print("USER POLICY ", userId)
	print("Found user", userId)
	policies = data.dss.resource_policies[input.resource] #from data

	#print("Found policies", policies)
	userEval(input.evalType,userId,policies)
}

userEval("OR",userId,policies) {
    print("Eval type OR")
    inputAttributeMap := input.attribute
    print("inputAttributeMap: ", inputAttributeMap)
    user_policies = data.dss.user_policies[userId]
    print("Found user_policies ", user_policies)
    some k
    policyName := user_policies[k]
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

userEval("AND",userId,policies) {
    print("Eval type AND")
    inputAttributeMap := input.attribute
    print("inputAttributeMap: ", inputAttributeMap)
    user_policies = data.dss.user_policies[userId]
    print("Found user_policies ", user_policies)
    every policyName in user_policies {
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
}

eval(r, "equals", c) {
    print("@@ Evaluating attribute",r) 
    r == c
}
