package app.rbs

default allow = false

allow {
	resourceActions = data.resource_actions[input.resource].actions
	input.action = resourceActions[_]

}
