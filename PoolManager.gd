extends Node

#Manages the spawns
class_name	PoolManager

@export var poolStartSize : int

var poolDictionary : Dictionary
var poolInstances 
var poolables : Poolables

func _ready() -> void:
	poolables = load("res://Poolables.tres")
	poolInstances = poolables.poolables
	
	SignalHub.spawn.connect(spawn_at_position)
	SignalHub.despawn.connect(despawn)
	
	for instance in poolInstances.values():
		var instanceArray = []
		fill_instance_pool(instance,instanceArray)
		poolDictionary[instance] = instanceArray
	

func fill_instance_pool(instance,instanceArray):
	for i in range(poolStartSize):
		var spawned = create_instance(instance)
		instanceArray.append(spawned)

func create_instance(instance : PackedScene):
	var spawned = instance.instantiate()
	add_child(spawned)
	spawned.visible = false
	return spawned

#instance must be loaded or predloaded
#position is where the instance will be spawned
#parent is the node parent	
func spawn_at_position(instanceName : StringName,position,parent):
	var spawned = null
	
	if parent == null:
		parent = self
		
	if !poolInstances.has(instanceName):
		return
	
	var instance = poolInstances[instanceName]
	
	if instance in poolDictionary:
		var pool = poolDictionary[instance]
		if pool.size() <= 0:
			fill_instance_pool(instance,pool)
		spawned = pool.pop_front()
		
	spawned.visible = true	
	spawned.position = position
	
	if spawned is Poolable:
		spawned.setup()
	
	if spawned.get_parent():
		spawned.get_parent().remove_child(spawned)
	parent.add_child(spawned)

func despawn(poolable : CanvasItem, instanceName : StringName):
	if !poolInstances.has(instanceName):
		return
	
	var instance = poolInstances[instanceName]
	
	var pool = poolDictionary[instance]
	poolable.visible = false
	pool.append(poolable)
