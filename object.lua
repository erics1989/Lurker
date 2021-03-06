
-- object data

_database = _database or {}

_database.object_sword = {
    name = "sword",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 0 },
    character = ")",
    description = "a sword.",
    pickup = true, part = "hand", slash = true, stab = true,
    init = function (object)
        game.object_setup(object)
    end,
    person_poststep = function (person, object, src)
        if  game.person_object_equipped(person, object) and
            game.person_can_attack(person)
        then
            game.person_poststep_attack2(person, src)
            game.person_poststep_attack3(person, src)
        end
    end,
    attack = {
        range = function (person, object, space)
            return Hex.dist(person.space, space) == 1
        end,
        execute = function (person, object, space)
            local opponent = space.person
            if opponent then
                game.print_verb2(
                    person,
                    opponent,
                    "%s slashes %s.",
                    "%s slash %s."
                )
                game.person_damage(opponent, 1)
            end
        end
    },
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    },
}

_database.object_axe = {
    name = "axe",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 2, y = 0 },
    character = ")",
    description = "an axe.",
    pickup = true, part = "hand", slash = true,
    init = function (object)
        game.object_setup(object)
    end,
    person_poststep = function (person, object, src)
        if  game.person_object_equipped(person, object) and
            game.person_can_attack(person)
        then
            game.person_poststep_attack2(person, src)
        end
    end,
    attack = {
        range = function (person, object, space)
            return Hex.dist(person.space, space) == 1
        end,
        execute = function (person, object, space)
            local spaces = Hex.adjacent(person.space)
            for _, space in ipairs(spaces) do
                local opponent = space.person
                if  opponent and
                    opponent.faction ~= person.faction
                then
                    game.print_verb2(
                        person,
                        opponent,
                        "%s hacks %s.",
                        "%s hack %s."
                    )
                    game.person_damage(opponent, 1)
                end
            end
        end
    },
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    },
}

_database.object_spear = {
    name = "spear",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 7, y = 1 },
    character = ")",
    description = "a spear.",
    pickup = true, part = "hand", stab = true,
    init = function (object)
        game.object_setup(object)
    end,
    person_poststep = function (person, object, src)
        if  game.person_object_equipped(person, object) and
            game.person_can_attack(person)
        then
            game.person_poststep_attack3(person, src)
        end
    end,
    attack = {
        range = function (person, object, space)
            return Hex.dist(person.space, space) == 1
        end,
        execute = function (person, object, space)
            local spaces = {}
            table.insert(spaces, space)
            local dx = space.x - person.space.x
            local dy = space.y - person.space.y
            local space2 = game.get_space(
                space.x + dx,
                space.y + dy
            )
            table.insert(spaces, space2)
            for _, space in ipairs(spaces) do
                local opponent = space.person
                if  opponent and
                    opponent.faction ~= person.faction
                then
                    game.print_verb2(
                        person,
                        opponent,
                        "%s skewers %s.",
                        "%s skewer %s."
                    )
                    game.person_damage(opponent, 1)
                end
            end
        end
    },
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    },
}

_database.object_hammer = {
    name = "hammer",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 14, y = 0 },
    character = ")",
    description = "a hammer.",
    pickup = true, part = "hand",
    init = function (object)
        game.object_setup(object)
    end,
    attack = {
        range = function (person, object, space)
            return Hex.dist(person.space, space) == 1
        end,
        execute = function (person, object, space)
            local opponent = space.person
            if  opponent then
                game.print_verb2(
                    person,
                    opponent,
                    "%s smashes %s.",
                    "%s smash %s."
                )
                game.person_damage(opponent, 2)
            end
        end
    },
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    },
}

_database.object_bow_and_arrows = {
    name = "bow and arrows",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 17, y = 0 },
    character = ")",
    description = "a bow and arrows.",
    pickup = true, part = "hand",
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) <= 4 and
                Hex.axis(person.space, space) and
                not game.obstructed(
                    person.space,
                    space,
                    game.space_vacant
                )
        end,
        execute = function (person, object, space)
            local opponent = space.person
            if opponent then
                game.print_verb2(
                    person,
                    opponent,
                    "%s shoots an arrow at %s.",
                    "%s shoot an arrow at %s."
                )
                game.person_damage(opponent, 1)
            else
                game.print_verb1(
                    person,
                    "%s shoots an arrow.",
                    "%s shoot an arrow."
                )
            end
        end
    }
}

_database.object_feather = {
    name = "feather",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 17, y = 12 },
    character = "/",
    description = "a feather. [use] it to jump to a hex.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) <= 2 and
                game.space_vacant(space)
        end,
        execute = function (person, object, space)
            game.object_discharge(object, 8)
            if game.person_sense(_state.hero, person) then
                local str = string.format(
                    game.data(person).plural and
                        "%s jump." or
                        "%s jumps.",
                    grammar.cap(grammar.the(game.data(person).name))
                )
                game.print(str)
            end
            local src = person.space
            game.person_relocate(person, space)

            local proto = game.data(person.hand)
            if proto.slash then
                game.person_poststep_attack2(person, src)
            end
            if proto.stab then
                game.person_poststep_attack3(person, src)
            end
        end
    }
}

_database.object_sprinting_shoes = {
    name = "sprinting shoes",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 11, y = 10 },
    character = "/",
    description = "a pair of sprinting shoes. [use] use it to step 4x in one direction.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) <= 4 and
                Hex.axis(person.space, space) and
                not game.obstructed(
                    person.space,
                    space,
                    game.space_vacant
                ) and
                game.space_vacant(space)
        end,
        execute = function (person, object, space)
            if game.person_sense(_state.hero, person) then
                local str = string.format(
                    game.data(person).plural and
                        "%s dash." or
                        "%s dashes.",
                    grammar.cap(grammar.the(game.data(person).name))
                )
                game.print(str)
            end
            game.object_discharge(object, 8)
            local path = Hex.line1(person.space, space)
            for i = 2, #path do
                game.person_step(person, path[i])
            end

        end
    }
}

_database.object_bear_totem = {
    name = "bear totem",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 15, y = 2 },
    character = "/",
    description = "a bear totem. [use] it to summon a bear.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) <= 1 and
                game.space_vacant(space)
        end,
        execute = function (person, object, space)
            game.print_verb1(
                person,
                "%s summons a bear.",
                "%s summon a bear."
            )
            game.person_object_exit(person, object)
            local person2 = game.data_init("person_bear")
            game.person_enter(person2, space)
            game.person_add_friend(person, person2)
        end
    }
}

_database.object_fire_staff = {
    name = "fire staff",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 4, y = 1 },
    character = "/",
    description = "a fire staff. [use] it to shoot a fireball.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) <= 4 and
                Hex.axis(person.space, space) and
                not game.obstructed(
                    person.space,
                    space,
                    game.space_vacant
                )
        end,
        execute = function (person, object, space)
            local opponent = space.person
            if opponent then
                game.print_verb2(
                    person,
                    opponent,
                    "%s shoots a fireball at %s.",
                    "%s shoot a fireball at %s."
                )
                game.person_damage(opponent, 1)
            else
                game.print_verb1(
                    person,
                    "%s shoots a fireball.",
                    "%s shoot a fireball."
                )
            end
            game.object_discharge(object, 8)
            if game.data(space.terrain).burn then
                game.terrain_exit(space.terrain)
                local terrain = game.data_init("terrain_fire")
                game.terrain_enter(terrain, space)
            end
        end
    }
}

_database.object_regeneration_charm = {
    name = "regeneration charm",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 14, y = 2 },
    character = "/",
    description = "a regeneration charm. regenerate 1 extra heart per floor.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    person_postdescend = function (person, object)
        game.person_undamage(person, 1)
    end
}

_database.object_shovel = {
    name = "shovel",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 15, y = 4 },
    character = "/",
    description = "a shovel. [use] it to dig through stone terrain.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) == 1 and
                space.terrain.id == "terrain_stone"
        end,
        execute = function (person, object, space)
            game.print_verb1(
                person,
                "%s uses a shovel.",
                "%s use a shovel."
            )
            game.terrain_exit(space.terrain)
            local terrain = game.data_init("terrain_dot")
            game.terrain_enter(terrain, space)
        end
    }
}

_database.object_auto_sentry = {
    name = "auto-sentry",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 5, y = 12 },
    character = "/",
    description = "an auto-sentry. [use] to setup.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) <= 1 and
                game.space_vacant(space)
        end,
        execute = function (person, object, space)
            game.print_verb1(
                person,
                "%s sets up an auto-sentry.",
                "%s set up an auto-sentry."
            )
            game.person_object_exit(person, object)
            local person2 = game.data_init("person_auto_sentry")
            game.person_enter(person2, space)
            game.person_add_friend(person, person2)
        end
    }
}

_database.object_curious_binoculars = {
    name = "curious binoculars",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 17, y = 2 },
    character = "/",
    description = "a pair of binoculars. [use] to change places with a person.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return
                space.person and
                person.sense[space.person]
        end,
        execute = function (person, object, space)
            game.object_discharge(object, 8)
            local opponent = space.person
            game.person_transpose(person, opponent)
        end
    }
}

_database.object_blurred_photograph = {
    name = "blurred photograph",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 2, y = 12 },
    character = "/",
    description = "a blurred photograph. [use] to escape from life's difficulties.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return
                Hex.dist(person.space, space) <= 1 and
                game.space_vacant(space)
        end,
        execute = function (person, object, space)
            game.print_verb1(
                person,
                "%s uses the blurred photograph.",
                "%s use the blurred photograph."
            )
            game.object_discharge(object, 8)
            local status = game.data_init("status_invisible")
            game.person_status_enter(person, status)
            local src = person.space
            game.person_step(person, space)
            local person2 = game.data_init(
                "person_blurred_photograph_image"
            )
            person2.person_ref = person
            person2.status_ref = status
            game.person_enter(person2, src)
            game.person_add_friend(person, person2)
        end
    }
}

_database.object_cuckoos_beak = {
    name = "cuckoo's beak",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 4, y = 4 },
    character = "/",
    description = "an iron beak. [use] to create a sound.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return
                game.space_stand(space)
            end,
        execute = function (person, object, space)
            game.print_verb1(
                person,
                "%s uses the cuckoo's beak.",
                "%s use the cuckoo's beak."
            )
            game.object_discharge(object, 8)
            for _, person in ipairs(_state.map.persons) do
                if person.interests then
                    person.interests[space] = true
                end
            end
        end
    }
}

_database.object_chameleon_cloak = {
    name = "chameleon cloak",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 9, y = 8 },
    character = "/",
    description = "a color-changing cloak.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    con = function (person, attacker, object)
        return 2
    end,
}

_database.object_pendulum = {
    name = "pendulum",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 10, y = 2 },
    character = "/",
    description = "a pendulum. [use] to put someone to sleep.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return space.person and person.sense[space.person]
        end,
        execute = function (person, object, space)
            local opponent = space.person
            if opponent then
                game.print_verb2(
                    person,
                    opponent,
                    "%s uses the pendulum on %s.",
                    "%s use the pendulum on %s."
                )
                game.object_discharge(object, 8)
                local status = game.data_init("status_sleep")
                status.counters = 8
                game.person_status_enter(opponent, status)
            else
                game.print_verb1(
                    person,
                    "%s uses the pendulum.",
                    "%s use the pendulum."
                )
            end
        end
    }
}

_database.object_orb = {
    name = "The Seed of Despair",
    color = color_constants.red,
    character = "*",
    sprite = { file = "resource/sprite/Items.png", x = 16, y = 3 },
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    person_poststep = function (person, object, src)
        person.seed = true
    end
}

_database.object_machete = {
    name = "machete",
    color = { 255, 255, 255 }, character = ")",
    part = "hand", pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    attack = {
        range = function (person, object, space)
            return Hex.dist(person.space, space) == 1
        end,
        execute = function (person, object, space)
            local opponent = space.person
            if opponent then
                if game.person_sense(_state.hero, person) then
                    local str = string.format(
                        game.data(person).plural and
                            "%s hack %s." or
                            "%s hacks %s.",
                        grammar.cap(grammar.the(game.data(person).name)),
                        grammar.the(game.data(opponent).name)
                    )
                    game.print(str)
                end
                game.person_damage(opponent, 1)
            end
        end
    },
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    },
    person_poststep = function (person, object, src)
        if  game.person_object_equipped(person, object) and
            game.person_can_attack(person)
        then
            game.person_poststep_attack2(person, src)
        end
    end
}

_database.object_shortbow = {
    name = "shortbow",
    color = { 255, 255, 255 }, character = ")",
    part = "hand", pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    attack = {
        range = function (person, object, space)
            local d = Hex.dist(person.space, space)
            return
                2 <= d and d <= 4 and
                Hex.axis(person.space, space) and
                not game.obstructed(
                    person.space,
                    space,
                    function (space)
                        return
                            game.data(space.terrain).stand and
                            (
                                not space.person or
                                not person.sense[space.person] or
                                person == space.person
                            )
                    end
                )
        end,
        execute = function (person, object, space)
            space = game.obstructed(
                person.space, space, game.space_vacant
            ) or space
            local opponent = space.person
            if opponent then
                local sense1 = game.person_sense(_state.hero, person)
                local sense2 = game.person_sense(_state.hero, opponent)
                if sense1 and sense2 then
                    local str = string.format(
                        game.data(person).plural and
                            "%s shoot an arrow at %s." or
                            "%s shoots an arrow at %s.",
                        grammar.cap(grammar.the(game.data(person).name)),
                        grammar.the(game.data(opponent).name)
                    )
                    game.print(str)
                elseif sense1 then
                    local str = string.format(
                        game.data(person).plural and
                            "%s shoot an arrow." or
                            "%s shoots an arrow.",
                        grammar.cap(grammar.the(game.data(person).name))
                    )
                    game.print(str)
                elseif sense2 then
                    local str = string.format(
                        game.data(opponent).plural and
                            "%s are shot by an arrow." or
                            "%s is shot by an arrow.",
                        grammar.cap(grammar.the(game.data(opponent).name)
                        )
                    )
                    game.print(str)
                end
                game.person_damage(opponent, 1)
            end
        end
    },
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    },
}

_database.object_ring_of_stealth = {
    name = "ring of stealth",
    plural_name = "rings of stealth",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 8, y = 11 },
    character = "o",
    description = "a ring of stealth.",
    part = "ring", pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    con = function (person, attacker, object)
        if game.person_object_equipped(person, object) then
            return 2
        end
    end,
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    }
}

_database.object_ring_of_clairvoyance = {
    name = "ring of clairvoyance",
    plural_name = "rings of clairvoyance",
    color = color_constants.base3,
    sprite = { file = "resource/sprite/Items.png", x = 8, y = 11 },
    character = "o", pickup = true,
    description = "a ring of clairvoyance.",
    part = "ring",
    init = function (object)
        game.object_setup(object)
    end,
    person_space_sense2 = function (person, object, space)
        if game.person_object_equipped(person, object) then
            return Hex.dist(person.space, space) <= 2
        end
    end,
    equip = {
        valid = function (person, object, space)
            return not game.person_object_equipped(person, object)
        end,
        execute = function (person, object, space)
            if game.person_object_equipped(person, object) then
                game.person_object_unequip(person, object)
            else
                game.person_object_equip(person, object)
            end
        end
    }
}

_database.object_staff_of_incineration = {
    name = "staff of incineration",
    color = { 255, 255, 255 },
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 1 },
    character = "/",
    description = "Upon use, the user shoots a firebolt, which damages the target and sets plants on fire. Recharges in 8 turns.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return game.person_space_proj(person, space)
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.object_discharge(object, 8)
            local space = game.person_space_proj_obstruction(person, space)
            local opponent = space.person
            if opponent then
                if game.person_sense(_state.hero, person) then
                    local str = string.format(
                        game.data(person).plural and
                            "%s incinerate %s." or
                            "%s incinerates %s.",
                        grammar.cap(grammar.the(game.data(person).name)),
                        grammar.the(game.data(opponent).name)
                    )
                    game.print(str)
                end
                game.person_damage(opponent, 1)
            end
            if game.data(space.terrain).burn then
                game.terrain_exit(space.terrain)
                game.terrain_enter(game.data_init("terrain_fire"), space)
            end
        end
    }
}

_database.object_staff_of_distortion = {
    name = "staff of distortion",
    color = { 255, 255, 255 },
    character = "/",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 1 },
    description = "Upon use, the user shoots a splash of unstable energies, which teleports the target to a random space. Recharges in 8 turns.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return game.person_space_proj(person, space)
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.object_discharge(object, 8)
            local space = game.person_space_proj_obstruction(person, space)
            local opponent = space.person
            if opponent then
                game.person_teleport(opponent)
            end
        end
    }
}

_database.object_staff_of_suggestion = {
    name = "staff of suggestion",
    color = { 255, 255, 255 },
    character = "/",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 1 },
    description = "Upon use, the user sends a suggestion, which causes the target to act as an ally for one turn. Recharges in 8 turns.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return game.person_space_proj(person, space)
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.object_discharge(object, 8)
            local space = game.person_space_proj_obstruction(person, space)
            local opponent = space.person
            if opponent then
                local status = game.data_init("status_charmed")
                status.charmer = person
                status.counters = 1
                game.person_status_enter(opponent, status)
            end
        end
    }
}

_database.object_staff_of_substitution = {
    name = "staff of substitution",
    color = { 255, 255, 255 },
    character = "/",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 1 },
    description = "A staff of substitution. [use] to change places with another person.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            return game.person_space_proj(person, space)
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.object_discharge(object, 8)
            local space = game.person_space_proj_obstruction(person, space)
            local opponent = space.person
            if opponent then
                game.person_transpose(person, opponent)
            end
        end
    }
}

_database.object_charm_of_passage = {
    name = "charm of passage",
    color = { 255, 255, 255 },
    character = "~",
    sprite = { file = "resource/sprite/Items.png", x = 15, y = 3 },
    description = "Upon use, the user teleports to a space of his/her choice, up to 4 spaces away. Recharges in 8 turns.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        range = function (person, object, space)
            local d = Hex.dist(person.space, space)
            return
                d <= 4 and
                game.data(space.terrain).stand and
                space.person == nil
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.object_discharge(object, 8)
            game.person_relocate(person, space)
        end
    }
}

_database.object_charm_of_verdure = {
    name = "charm of verdure",
    color = { 255, 255, 255 },
    character = "~",
    sprite = { file = "resource/sprite/Items.png", x = 15, y = 3 },
    description = "A charm of verdure. [use] to summon a forest.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end,
    person_postact = function (person, object)
        local status = object.status_charging
        if status then
            game.object_status_decrement(object, status)
        end
    end,
    use = {
        valid = function (person, object)
            return not object.status_charging
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.object_discharge(object, 8)
            local f = function (space)
                return
                    Hex.dist(person.space, space) <= 2 and
                    game.data(space.terrain).stand and
                    not game.data(space.terrain).water and
                    not space.terrain.door
            end
            local spaces = List.filter(_state.map.spaces, f)
            for _, space in ipairs(spaces) do
                game.terrain_exit(space.terrain)
                local terrain = game.data_init("terrain_tree")
                game.terrain_enter(terrain, space)
            end
        end
    }
}

_database.object_potion_of_health = {
    name = "potion of health",
    plural_name = "potions of health",
    color = { 255, 255, 255 },
    character = "!",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 3 },
    description = "An herbal tonic. Upon use, the user recovers 4 hearts.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                game.person_undamage(opponent, 4)
            end
        end
    },
    throw = {
        valid = function (person, object)
            return not person.restricted
        end,
        range = function (person, object, space)
            return Hex.dist(person.space, space) <= 4
        end,
        execute = function (person, object, space)
            game.person_object_throw(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                game.person_undamage(opponent, 4)
            end
        end
    }
}

_database.object_potion_of_distortion = {
    name = "potion of distortion",
    plural_name = "potions of distortion",
    description = "A potion of unstable energies. Upon use, the user teleports to a random space.",
    color = { 255, 255, 255 }, character = "!",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 3 },
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                game.person_teleport(opponent)
            end
        end
    },
    throw = {
        valid = function (person, object)
            return not person.restricted
        end,
        range = function (person, object, space)
            return Hex.dist(person.space, space) <= 4
        end,
        execute = function (person, object, space)
            game.person_object_throw(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                game.person_teleport(opponent)
            end
        end
    }
}

_database.object_potion_of_blindness = {
    name = "potion of blindness",
    plural_name = "potions of blindness",
    description = "A potion of cursed dust. Upon use, the user goes blind.",
    color = { 255, 255, 255 },
    character = "!",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 3 },
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                local status = game.data_init("status_blind")
                status.counters = 16
                game.person_status_enter(opponent, status)
            end
        end
    },
    throw = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return Hex.dist(person.space, space) <= 4
        end,
        execute = function (person, object, space)
            game.person_object_throw(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                local status = game.data_init("status_blind")
                status.counters = 16
                game.person_status_enter(opponent, status)
            end
        end
    }
}

_database.object_potion_of_invisibility = {
    name = "potion of invisibility",
    plural_name = "potions of invisibility",
    description = "A potion of clear, viscous fluid. Upon use, the user vanishes from the visible world for 16 turns.",
    color = { 255, 255, 255 },
    character = "!",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 3 },
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,

    use = {
        valid = function (person, object)
            return true
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                local status = game.data_init("status_invisible")
                status.counters = 16
                game.person_status_enter(opponent, status)
            end
        end
    },
    throw = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return Hex.dist(person.space, space) <= 4
        end,
        execute = function (person, object, space)
            game.person_object_throw(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                local status = game.data_init("status_invisible")
                status.counters = 16
                game.person_status_enter(opponent, status)
            end
        end
    }
}

_database.object_potion_of_incineration = {
    name = "potion of incineration",
    plural_name = "potions of incineration",
    description = "A flask of dancing sparks. Upon use, the user starts a fire.",
    color = { 255, 255, 255 },
    character = "!",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 3 },
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                if game.person_sense(_state.hero, opponent) then
                    local str = string.format(
                        game.data(person).plural and
                            "%s burn." or
                            "%s burns.",
                        grammar.cap(grammar.the(game.data(person).name))
                    )
                    game.print(str)
                end
                game.person_damage(opponent, 1)
            end
            if game.data(space.terrain).burn then
                game.terrain_exit(space.terrain)
                local fire = game.data_init("terrain_fire")
                game.terrain_enter(fire, space)
            end
        end
    },
    throw = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return Hex.dist(person.space, space) <= 4
        end,
        execute = function (person, object, space)
            game.person_object_throw(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                if game.person_sense(_state.hero, opponent) then
                    local str = string.format(
                        game.data(person).plural and
                            "%s burn." or
                            "%s burns.",
                        grammar.cap(grammar.the(game.data(person).name))
                    )
                    game.print(str)
                end
                game.person_damage(opponent, 1)
            end
            if game.data(space.terrain).burn then
                game.terrain_exit(space.terrain)
                local fire = game.data_init("terrain_fire")
                game.terrain_enter(fire, space)
            end
        end
    }
}

_database.object_potion_of_domination = {
    name = "potion of domination",
    plural_name = "potions of domination",
    color = { 255, 255, 255 },
    character = "!",
    sprite = { file = "resource/sprite/Items.png", x = 0, y = 3 },
    description = "Causes a person to join your party.",
    pickup = true,
    init = function (object)
        game.object_setup(object)
    end,
    use = {
        valid = function (person, object)
            return true
        end,
        execute = function (person, object, space)
            game.person_object_use(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                local status = game.data_init("status_charmed")
                status.charmer = person
                game.person_status_enter(opponent, status)
            end
        end
    },
    throw = {
        valid = function (person, object)
            return true
        end,
        range = function (person, object, space)
            return Hex.dist(person.space, space) <= 4
        end,
        execute = function (person, object, space)
            game.person_object_throw(person, object)
            game.person_object_exit(person, object)
            local opponent = space.person
            if opponent then
                local status = game.data_init("status_charmed")
                status.charmer = person
                game.person_status_enter(opponent, status)
            end
        end
    }
}

_database.object_bones = {
    name = "a pile of bones",
    plural_name = "piles of bones",
    color = { 255, 255, 255 },
    character = "%",
    sprite = { file = "resource/sprite/Terrain_Objects.png", x = 1, y = 4 },
    description = "bones",
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end
}

_database.object_blood = {
    name = "a puddle of blood",
    plural_name = "puddles of blood",
    color = color_constants.red,
    character = "%",
    sprite = { file = "resource/sprite/FX_Blood.png", x = 9, y = 0 },
    description = "blood",
    init = function (object)
        game.object_setup(object)
    end,
    act = function (object)
        game.object_act(object)
    end
}
