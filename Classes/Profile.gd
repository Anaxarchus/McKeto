class_name Profile
extends Node


var data:Dictionary = {
    "PROFILE":{
        "name":"",
        "id":0
       },
    "SUNDAY":{
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[]
       },
    "MONDAY":{
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[]
       },
    "TUESDAY":{
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[]
       },
    "WEDNESDAY":{
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[]
       },
    "THURSDAY":{
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[]
       },
    "FRIDAY":{
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[]
       },
    "SATURDAY":{
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[]
       }
   }

var registry:Dictionary = {
    "id":0,
    "name":"",
   }


func new_profile(profile_name:String):
    registry.name = profile_name
    var id = get_uid()
    registry.id = id
    data.name = profile_name
    data.id = id
    register_profile()

func load_profile(id:int):
    var file = File.new()
    var err = file.open("user://Profiles/" + String(id) + ".txt", File.READ)
    if err == OK:
        data = file.get_var()
    file.close()

func save_profile():
    var directory = Directory.new()
    if not directory.dir_exists("user://Profiles"):
        directory.make_dir("user://Profiles")
    var file = File.new()
    file.open("user://Profiles/" + String(data.PROFILE.id) + ".txt", File.WRITE)
    file.store_var(data)
    file.close()

func register_profile():
    var reg = File.new()
    var err = reg.open("user://Registry.txt",File.READ)
    print(err)
    var current_reg:Dictionary
    if err == OK:
        current_reg = reg.get_var()
    reg.close()
    err = reg.open("user://Registry.txt",File.WRITE)
    current_reg[registry.id] = registry
    reg.store_var(current_reg)
    reg.close()

func get_all_profiles():
    var reg = File.new()
    var err = reg.open("user://Registry.txt",File.READ)
    if err == OK:
        var profiles = reg.get_var()
        reg.close()
        return profiles
    else:
        reg.close()
        return {}

func get_uid():
    var uid = 0
    var profiles = get_all_profiles()
    if profiles.keys().size()>0:
        for profile in profiles.keys():
            if uid == profiles[profile].id:
                uid+=1
            else:
                return uid
    return uid
