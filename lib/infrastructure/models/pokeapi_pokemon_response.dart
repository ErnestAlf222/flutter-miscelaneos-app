import 'dart:convert';

PokeApiPokemonsResponse pokeApiPokemonsResponseFromJson(String str) => PokeApiPokemonsResponse.fromJson(json.decode(str));

String pokeApiPokemonsResponseToJson(PokeApiPokemonsResponse data) => json.encode(data.toJson());

class PokeApiPokemonsResponse {
    final int id;
    final String name;
    final int baseExperience;
    final int height;
    final bool isDefault;
    final int order;
    final int weight;
    final List<Ability> abilities;
    final List<PastAbility> pastAbilities;
    final List<Species> forms;
    final List<GameIndex> gameIndices;
    final List<HeldItem> heldItems;
    final String locationAreaEncounters;
    final List<Move> moves;
    final Species species;
    final Sprites sprites;
    final Cries cries;
    final List<Stat> stats;
    final List<PastStat> pastStats;
    final List<Type> types;
    final List<dynamic> pastTypes;

    PokeApiPokemonsResponse({
        required this.id,
        required this.name,
        required this.baseExperience,
        required this.height,
        required this.isDefault,
        required this.order,
        required this.weight,
        required this.abilities,
        required this.pastAbilities,
        required this.forms,
        required this.gameIndices,
        required this.heldItems,
        required this.locationAreaEncounters,
        required this.moves,
        required this.species,
        required this.sprites,
        required this.cries,
        required this.stats,
        required this.pastStats,
        required this.types,
        required this.pastTypes,
    });

    factory PokeApiPokemonsResponse.fromJson(Map<String, dynamic> json) => PokeApiPokemonsResponse(
        id: json["id"],
        name: json["name"],
        baseExperience: json["base_experience"],
        height: json["height"],
        isDefault: json["is_default"],
        order: json["order"],
        weight: json["weight"],
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
        pastAbilities: List<PastAbility>.from(json["past_abilities"].map((x) => PastAbility.fromJson(x))),
        forms: List<Species>.from(json["forms"].map((x) => Species.fromJson(x))),
        gameIndices: List<GameIndex>.from(json["game_indices"].map((x) => GameIndex.fromJson(x))),
        heldItems: List<HeldItem>.from(json["held_items"].map((x) => HeldItem.fromJson(x))),
        locationAreaEncounters: json["location_area_encounters"],
        moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        species: Species.fromJson(json["species"]),
        sprites: Sprites.fromJson(json["sprites"]),
        cries: Cries.fromJson(json["cries"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        pastStats: List<PastStat>.from(json["past_stats"].map((x) => PastStat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        pastTypes: List<dynamic>.from(json["past_types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "base_experience": baseExperience,
        "height": height,
        "is_default": isDefault,
        "order": order,
        "weight": weight,
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "past_abilities": List<dynamic>.from(pastAbilities.map((x) => x.toJson())),
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
        "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
        "held_items": List<dynamic>.from(heldItems.map((x) => x.toJson())),
        "location_area_encounters": locationAreaEncounters,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "species": species.toJson(),
        "sprites": sprites.toJson(),
        "cries": cries.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "past_stats": List<dynamic>.from(pastStats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "past_types": List<dynamic>.from(pastTypes.map((x) => x)),
    };
}

class Ability {
    final bool isHidden;
    final int slot;
    final Species? ability;

    Ability({
        required this.isHidden,
        required this.slot,
        required this.ability,
    });

    factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        isHidden: json["is_hidden"],
        slot: json["slot"],
        ability: json["ability"] == null ? null : Species.fromJson(json["ability"]),
    );

    Map<String, dynamic> toJson() => {
        "is_hidden": isHidden,
        "slot": slot,
        "ability": ability?.toJson(),
    };
}

class Species {
    final String name;
    final String url;

    Species({
        required this.name,
        required this.url,
    });

    factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

class Cries {
    final String latest;
    final String legacy;

    Cries({
        required this.latest,
        required this.legacy,
    });

    factory Cries.fromJson(Map<String, dynamic> json) => Cries(
        latest: json["latest"],
        legacy: json["legacy"],
    );

    Map<String, dynamic> toJson() => {
        "latest": latest,
        "legacy": legacy,
    };
}

class GameIndex {
    final int gameIndex;
    final Species version;

    GameIndex({
        required this.gameIndex,
        required this.version,
    });

    factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
        gameIndex: json["game_index"],
        version: Species.fromJson(json["version"]),
    );

    Map<String, dynamic> toJson() => {
        "game_index": gameIndex,
        "version": version.toJson(),
    };
}

class HeldItem {
    final Species item;
    final List<VersionDetail> versionDetails;

    HeldItem({
        required this.item,
        required this.versionDetails,
    });

    factory HeldItem.fromJson(Map<String, dynamic> json) => HeldItem(
        item: Species.fromJson(json["item"]),
        versionDetails: List<VersionDetail>.from(json["version_details"].map((x) => VersionDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item": item.toJson(),
        "version_details": List<dynamic>.from(versionDetails.map((x) => x.toJson())),
    };
}

class VersionDetail {
    final int rarity;
    final Species version;

    VersionDetail({
        required this.rarity,
        required this.version,
    });

    factory VersionDetail.fromJson(Map<String, dynamic> json) => VersionDetail(
        rarity: json["rarity"],
        version: Species.fromJson(json["version"]),
    );

    Map<String, dynamic> toJson() => {
        "rarity": rarity,
        "version": version.toJson(),
    };
}

class Move {
    final Species move;
    final List<VersionGroupDetail> versionGroupDetails;

    Move({
        required this.move,
        required this.versionGroupDetails,
    });

    factory Move.fromJson(Map<String, dynamic> json) => Move(
        move: Species.fromJson(json["move"]),
        versionGroupDetails: List<VersionGroupDetail>.from(json["version_group_details"].map((x) => VersionGroupDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "move": move.toJson(),
        "version_group_details": List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
    };
}

class VersionGroupDetail {
    final int levelLearnedAt;
    final Species versionGroup;
    final Species moveLearnMethod;
    final int? order;

    VersionGroupDetail({
        required this.levelLearnedAt,
        required this.versionGroup,
        required this.moveLearnMethod,
        required this.order,
    });

    factory VersionGroupDetail.fromJson(Map<String, dynamic> json) => VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        versionGroup: Species.fromJson(json["version_group"]),
        moveLearnMethod: Species.fromJson(json["move_learn_method"]),
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "level_learned_at": levelLearnedAt,
        "version_group": versionGroup.toJson(),
        "move_learn_method": moveLearnMethod.toJson(),
        "order": order,
    };
}

class PastAbility {
    final Species generation;
    final List<Ability> abilities;

    PastAbility({
        required this.generation,
        required this.abilities,
    });

    factory PastAbility.fromJson(Map<String, dynamic> json) => PastAbility(
        generation: Species.fromJson(json["generation"]),
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "generation": generation.toJson(),
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
    };
}

class PastStat {
    final Species generation;
    final List<Stat> stats;

    PastStat({
        required this.generation,
        required this.stats,
    });

    factory PastStat.fromJson(Map<String, dynamic> json) => PastStat(
        generation: Species.fromJson(json["generation"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "generation": generation.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
    };
}

class Stat {
    final int baseStat;
    final int effort;
    final Species stat;

    Stat({
        required this.baseStat,
        required this.effort,
        required this.stat,
    });

    factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromJson(json["stat"]),
    );

    Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
    };
}

class GenerationViii {
    final Sprites swordShield;
    final Sprites legendsArceus;
    final Sprites brilliantDiamondShiningPearl;

    GenerationViii({
        required this.swordShield,
        required this.legendsArceus,
        required this.brilliantDiamondShiningPearl,
    });

    factory GenerationViii.fromJson(Map<String, dynamic> json) => GenerationViii(
        swordShield: Sprites.fromJson(json["sword-shield"]),
        legendsArceus: Sprites.fromJson(json["legends-arceus"]),
        brilliantDiamondShiningPearl: Sprites.fromJson(json["brilliant-diamond-shining-pearl"]),
    );

    Map<String, dynamic> toJson() => {
        "sword-shield": swordShield.toJson(),
        "legends-arceus": legendsArceus.toJson(),
        "brilliant-diamond-shining-pearl": brilliantDiamondShiningPearl.toJson(),
    };
}

class GenerationVii {
    final DreamWorld icons;
    final Sprites ultraSunUltraMoon;
    final Sprites letsGoPikachuLetsGoEevee;

    GenerationVii({
        required this.icons,
        required this.ultraSunUltraMoon,
        required this.letsGoPikachuLetsGoEevee,
    });

    factory GenerationVii.fromJson(Map<String, dynamic> json) => GenerationVii(
        icons: DreamWorld.fromJson(json["icons"]),
        ultraSunUltraMoon: Sprites.fromJson(json["ultra-sun-ultra-moon"]),
        letsGoPikachuLetsGoEevee: Sprites.fromJson(json["lets-go-pikachu-lets-go-eevee"]),
    );

    Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
        "ultra-sun-ultra-moon": ultraSunUltraMoon.toJson(),
        "lets-go-pikachu-lets-go-eevee": letsGoPikachuLetsGoEevee.toJson(),
    };
}

class GenerationVi {
    final Sprites xY;
    final DreamWorld icons;
    final Sprites omegaRubyAlphaSapphire;

    GenerationVi({
        required this.xY,
        required this.icons,
        required this.omegaRubyAlphaSapphire,
    });

    factory GenerationVi.fromJson(Map<String, dynamic> json) => GenerationVi(
        xY: Sprites.fromJson(json["x-y"]),
        icons: DreamWorld.fromJson(json["icons"]),
        omegaRubyAlphaSapphire: Sprites.fromJson(json["omega-ruby-alpha-sapphire"]),
    );

    Map<String, dynamic> toJson() => {
        "x-y": xY.toJson(),
        "icons": icons.toJson(),
        "omega-ruby-alpha-sapphire": omegaRubyAlphaSapphire.toJson(),
    };
}

class GenerationV {
    final GenerationVIcons icons;
    final Sprites blackWhite;

    GenerationV({
        required this.icons,
        required this.blackWhite,
    });

    factory GenerationV.fromJson(Map<String, dynamic> json) => GenerationV(
        icons: GenerationVIcons.fromJson(json["icons"]),
        blackWhite: Sprites.fromJson(json["black-white"]),
    );

    Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
        "black-white": blackWhite.toJson(),
    };
}

class GenerationIx {
    final Sprites champions;
    final Sprites legendsZa;
    final Sprites scarletViolet;

    GenerationIx({
        required this.champions,
        required this.legendsZa,
        required this.scarletViolet,
    });

    factory GenerationIx.fromJson(Map<String, dynamic> json) => GenerationIx(
        champions: Sprites.fromJson(json["champions"]),
        legendsZa: Sprites.fromJson(json["legends-za"]),
        scarletViolet: Sprites.fromJson(json["scarlet-violet"]),
    );

    Map<String, dynamic> toJson() => {
        "champions": champions.toJson(),
        "legends-za": legendsZa.toJson(),
        "scarlet-violet": scarletViolet.toJson(),
    };
}

class GenerationIv {
    final AnimatedClass icons;
    final Sprites platinum;
    final Sprites diamondPearl;
    final Sprites heartgoldSoulsilver;

    GenerationIv({
        required this.icons,
        required this.platinum,
        required this.diamondPearl,
        required this.heartgoldSoulsilver,
    });

    factory GenerationIv.fromJson(Map<String, dynamic> json) => GenerationIv(
        icons: AnimatedClass.fromJson(json["icons"]),
        platinum: Sprites.fromJson(json["platinum"]),
        diamondPearl: Sprites.fromJson(json["diamond-pearl"]),
        heartgoldSoulsilver: Sprites.fromJson(json["heartgold-soulsilver"]),
    );

    Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
        "platinum": platinum.toJson(),
        "diamond-pearl": diamondPearl.toJson(),
        "heartgold-soulsilver": heartgoldSoulsilver.toJson(),
    };
}

class SpritesVersions {
    final FluffyGenerationI generationI;
    final GenerationV generationV;
    final FluffyGenerationIi generationIi;
    final GenerationIv generationIv;
    final GenerationIx generationIx;
    final GenerationVi generationVi;
    final GenerationIii generationIii;
    final GenerationVii generationVii;
    final GenerationViii generationViii;

    SpritesVersions({
        required this.generationI,
        required this.generationV,
        required this.generationIi,
        required this.generationIv,
        required this.generationIx,
        required this.generationVi,
        required this.generationIii,
        required this.generationVii,
        required this.generationViii,
    });

    factory SpritesVersions.fromJson(Map<String, dynamic> json) => SpritesVersions(
        generationI: FluffyGenerationI.fromJson(json["generation-i"]),
        generationV: GenerationV.fromJson(json["generation-v"]),
        generationIi: FluffyGenerationIi.fromJson(json["generation-ii"]),
        generationIv: GenerationIv.fromJson(json["generation-iv"]),
        generationIx: GenerationIx.fromJson(json["generation-ix"]),
        generationVi: GenerationVi.fromJson(json["generation-vi"]),
        generationIii: GenerationIii.fromJson(json["generation-iii"]),
        generationVii: GenerationVii.fromJson(json["generation-vii"]),
        generationViii: GenerationViii.fromJson(json["generation-viii"]),
    );

    Map<String, dynamic> toJson() => {
        "generation-i": generationI.toJson(),
        "generation-v": generationV.toJson(),
        "generation-ii": generationIi.toJson(),
        "generation-iv": generationIv.toJson(),
        "generation-ix": generationIx.toJson(),
        "generation-vi": generationVi.toJson(),
        "generation-iii": generationIii.toJson(),
        "generation-vii": generationVii.toJson(),
        "generation-viii": generationViii.toJson(),
    };
}

class Other {
    final HomeClass home;
    final Sprites showdown;
    final DreamWorld dreamWorld;
    final OfficialArtwork officialArtwork;

    Other({
        required this.home,
        required this.showdown,
        required this.dreamWorld,
        required this.officialArtwork,
    });

    factory Other.fromJson(Map<String, dynamic> json) => Other(
        home: HomeClass.fromJson(json["home"]),
        showdown: Sprites.fromJson(json["showdown"]),
        dreamWorld: DreamWorld.fromJson(json["dream_world"]),
        officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
    );

    Map<String, dynamic> toJson() => {
        "home": home.toJson(),
        "showdown": showdown.toJson(),
        "dream_world": dreamWorld.toJson(),
        "official-artwork": officialArtwork.toJson(),
    };
}

class Sprites {
    final Other? other;
    final SpritesVersions? versions;
    final String? backShiny;
    final dynamic backFemale;
    final String? frontShiny;
    final String? backDefault;
    final dynamic frontFemale;
    final String? frontDefault;
    final dynamic backShinyFemale;
    final dynamic frontShinyFemale;
    final SpritesAnimated? animated;
    final HomeClass? icons;

    Sprites({
        this.other,
        this.versions,
        required this.backShiny,
        required this.backFemale,
        required this.frontShiny,
        required this.backDefault,
        required this.frontFemale,
        required this.frontDefault,
        required this.backShinyFemale,
        required this.frontShinyFemale,
        this.animated,
        this.icons,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
        versions: json["versions"] == null ? null : SpritesVersions.fromJson(json["versions"]),
        backShiny: json["back_shiny"],
        backFemale: json["back_female"],
        frontShiny: json["front_shiny"],
        backDefault: json["back_default"],
        frontFemale: json["front_female"],
        frontDefault: json["front_default"],
        backShinyFemale: json["back_shiny_female"],
        frontShinyFemale: json["front_shiny_female"],
        animated: json["animated"] == null ? null : SpritesAnimated.fromJson(json["animated"]),
        icons: json["icons"] == null ? null : HomeClass.fromJson(json["icons"]),
    );

    Map<String, dynamic> toJson() => {
        "other": other?.toJson(),
        "versions": versions?.toJson(),
        "back_shiny": backShiny,
        "back_female": backFemale,
        "front_shiny": frontShiny,
        "back_default": backDefault,
        "front_female": frontFemale,
        "front_default": frontDefault,
        "back_shiny_female": backShinyFemale,
        "front_shiny_female": frontShinyFemale,
        "animated": animated?.toJson(),
        "icons": icons?.toJson(),
    };
}

class DreamWorld {
    final dynamic frontFemale;
    final String? frontDefault;

    DreamWorld({
        required this.frontFemale,
        required this.frontDefault,
    });

    factory DreamWorld.fromJson(Map<String, dynamic> json) => DreamWorld(
        frontFemale: json["front_female"],
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "front_female": frontFemale,
        "front_default": frontDefault,
    };
}

class GenerationVIcons {
    final AnimatedClass animated;
    final String frontDefault;

    GenerationVIcons({
        required this.animated,
        required this.frontDefault,
    });

    factory GenerationVIcons.fromJson(Map<String, dynamic> json) => GenerationVIcons(
        animated: AnimatedClass.fromJson(json["animated"]),
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "animated": animated.toJson(),
        "front_default": frontDefault,
    };
}

class AnimatedClass {
    final String? frontDefault;

    AnimatedClass({
        required this.frontDefault,
    });

    factory AnimatedClass.fromJson(Map<String, dynamic> json) => AnimatedClass(
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
    };
}

class FluffyGenerationI {
    final RedBlue yellow;
    final RedBlue redBlue;
    final RedGreenJapan redGreenJapan;

    FluffyGenerationI({
        required this.yellow,
        required this.redBlue,
        required this.redGreenJapan,
    });

    factory FluffyGenerationI.fromJson(Map<String, dynamic> json) => FluffyGenerationI(
        yellow: RedBlue.fromJson(json["yellow"]),
        redBlue: RedBlue.fromJson(json["red-blue"]),
        redGreenJapan: RedGreenJapan.fromJson(json["red-green-japan"]),
    );

    Map<String, dynamic> toJson() => {
        "yellow": yellow.toJson(),
        "red-blue": redBlue.toJson(),
        "red-green-japan": redGreenJapan.toJson(),
    };
}

class RedBlue {
    final String backGray;
    final String frontGray;
    final String backDefault;
    final String frontDefault;
    final String backTransparent;
    final String frontTransparent;
    final String backTransparentGray;
    final String frontTransparentGray;
    final String? backGbc;
    final String? frontGbc;

    RedBlue({
        required this.backGray,
        required this.frontGray,
        required this.backDefault,
        required this.frontDefault,
        required this.backTransparent,
        required this.frontTransparent,
        required this.backTransparentGray,
        required this.frontTransparentGray,
        this.backGbc,
        this.frontGbc,
    });

    factory RedBlue.fromJson(Map<String, dynamic> json) => RedBlue(
        backGray: json["back_gray"],
        frontGray: json["front_gray"],
        backDefault: json["back_default"],
        frontDefault: json["front_default"],
        backTransparent: json["back_transparent"],
        frontTransparent: json["front_transparent"],
        backTransparentGray: json["back_transparent_gray"],
        frontTransparentGray: json["front_transparent_gray"],
        backGbc: json["back_gbc"],
        frontGbc: json["front_gbc"],
    );

    Map<String, dynamic> toJson() => {
        "back_gray": backGray,
        "front_gray": frontGray,
        "back_default": backDefault,
        "front_default": frontDefault,
        "back_transparent": backTransparent,
        "front_transparent": frontTransparent,
        "back_transparent_gray": backTransparentGray,
        "front_transparent_gray": frontTransparentGray,
        "back_gbc": backGbc,
        "front_gbc": frontGbc,
    };
}

class RedGreenJapan {
    final String backGray;
    final String frontGray;
    final String backDefault;
    final String frontDefault;

    RedGreenJapan({
        required this.backGray,
        required this.frontGray,
        required this.backDefault,
        required this.frontDefault,
    });

    factory RedGreenJapan.fromJson(Map<String, dynamic> json) => RedGreenJapan(
        backGray: json["back_gray"],
        frontGray: json["front_gray"],
        backDefault: json["back_default"],
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "back_gray": backGray,
        "front_gray": frontGray,
        "back_default": backDefault,
        "front_default": frontDefault,
    };
}

class FluffyGenerationIi {
    final Crystal gold;
    final Crystal silver;
    final Crystal crystal;

    FluffyGenerationIi({
        required this.gold,
        required this.silver,
        required this.crystal,
    });

    factory FluffyGenerationIi.fromJson(Map<String, dynamic> json) => FluffyGenerationIi(
        gold: Crystal.fromJson(json["gold"]),
        silver: Crystal.fromJson(json["silver"]),
        crystal: Crystal.fromJson(json["crystal"]),
    );

    Map<String, dynamic> toJson() => {
        "gold": gold.toJson(),
        "silver": silver.toJson(),
        "crystal": crystal.toJson(),
    };
}

class Crystal {
    final CrystalAnimated? animated;
    final String backShiny;
    final String frontShiny;
    final String backDefault;
    final String frontDefault;
    final String backTransparent;
    final String frontTransparent;
    final String backShinyTransparent;
    final String frontShinyTransparent;

    Crystal({
        this.animated,
        required this.backShiny,
        required this.frontShiny,
        required this.backDefault,
        required this.frontDefault,
        required this.backTransparent,
        required this.frontTransparent,
        required this.backShinyTransparent,
        required this.frontShinyTransparent,
    });

    factory Crystal.fromJson(Map<String, dynamic> json) => Crystal(
        animated: json["animated"] == null ? null : CrystalAnimated.fromJson(json["animated"]),
        backShiny: json["back_shiny"],
        frontShiny: json["front_shiny"],
        backDefault: json["back_default"],
        frontDefault: json["front_default"],
        backTransparent: json["back_transparent"],
        frontTransparent: json["front_transparent"],
        backShinyTransparent: json["back_shiny_transparent"],
        frontShinyTransparent: json["front_shiny_transparent"],
    );

    Map<String, dynamic> toJson() => {
        "animated": animated?.toJson(),
        "back_shiny": backShiny,
        "front_shiny": frontShiny,
        "back_default": backDefault,
        "front_default": frontDefault,
        "back_transparent": backTransparent,
        "front_transparent": frontTransparent,
        "back_shiny_transparent": backShinyTransparent,
        "front_shiny_transparent": frontShinyTransparent,
    };
}

class CrystalAnimated {
    final String? frontShiny;
    final String? frontDefault;

    CrystalAnimated({
        required this.frontShiny,
        required this.frontDefault,
    });

    factory CrystalAnimated.fromJson(Map<String, dynamic> json) => CrystalAnimated(
        frontShiny: json["front_shiny"],
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "front_shiny": frontShiny,
        "front_default": frontDefault,
    };
}

class GenerationIii {
    final AnimatedClass icons;
    final Emerald emerald;
    final Emerald rubySapphire;
    final Emerald fireredLeafgreen;

    GenerationIii({
        required this.icons,
        required this.emerald,
        required this.rubySapphire,
        required this.fireredLeafgreen,
    });

    factory GenerationIii.fromJson(Map<String, dynamic> json) => GenerationIii(
        icons: AnimatedClass.fromJson(json["icons"]),
        emerald: Emerald.fromJson(json["emerald"]),
        rubySapphire: Emerald.fromJson(json["ruby-sapphire"]),
        fireredLeafgreen: Emerald.fromJson(json["firered-leafgreen"]),
    );

    Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
        "emerald": emerald.toJson(),
        "ruby-sapphire": rubySapphire.toJson(),
        "firered-leafgreen": fireredLeafgreen.toJson(),
    };
}

class Emerald {
    final Emerald? animated;
    final String backShiny;
    final String frontShiny;
    final String backDefault;
    final String frontDefault;

    Emerald({
        this.animated,
        required this.backShiny,
        required this.frontShiny,
        required this.backDefault,
        required this.frontDefault,
    });

    factory Emerald.fromJson(Map<String, dynamic> json) => Emerald(
        animated: json["animated"] == null ? null : Emerald.fromJson(json["animated"]),
        backShiny: json["back_shiny"],
        frontShiny: json["front_shiny"],
        backDefault: json["back_default"],
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "animated": animated?.toJson(),
        "back_shiny": backShiny,
        "front_shiny": frontShiny,
        "back_default": backDefault,
        "front_default": frontDefault,
    };
}

class HomeClass {
    final String? frontShiny;
    final String? frontDefault;
    final dynamic frontFemale;
    final dynamic frontShinyFemale;

    HomeClass({
        this.frontShiny,
        required this.frontDefault,
        this.frontFemale,
        this.frontShinyFemale,
    });

    factory HomeClass.fromJson(Map<String, dynamic> json) => HomeClass(
        frontShiny: json["front_shiny"],
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShinyFemale: json["front_shiny_female"],
    );

    Map<String, dynamic> toJson() => {
        "front_shiny": frontShiny,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny_female": frontShinyFemale,
    };
}

class OfficialArtwork {
    final OfficialArtworkVersions versions;
    final String frontShiny;
    final String frontDefault;

    OfficialArtwork({
        required this.versions,
        required this.frontShiny,
        required this.frontDefault,
    });

    factory OfficialArtwork.fromJson(Map<String, dynamic> json) => OfficialArtwork(
        versions: OfficialArtworkVersions.fromJson(json["versions"]),
        frontShiny: json["front_shiny"],
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "versions": versions.toJson(),
        "front_shiny": frontShiny,
        "front_default": frontDefault,
    };
}

class OfficialArtworkVersions {
    final PurpleGenerationI generationI;
    final PurpleGenerationIi generationIi;

    OfficialArtworkVersions({
        required this.generationI,
        required this.generationIi,
    });

    factory OfficialArtworkVersions.fromJson(Map<String, dynamic> json) => OfficialArtworkVersions(
        generationI: PurpleGenerationI.fromJson(json["generation-i"]),
        generationIi: PurpleGenerationIi.fromJson(json["generation-ii"]),
    );

    Map<String, dynamic> toJson() => {
        "generation-i": generationI.toJson(),
        "generation-ii": generationIi.toJson(),
    };
}

class PurpleGenerationI {
    final AnimatedClass redAndBlue;
    final AnimatedClass redAndGreen;

    PurpleGenerationI({
        required this.redAndBlue,
        required this.redAndGreen,
    });

    factory PurpleGenerationI.fromJson(Map<String, dynamic> json) => PurpleGenerationI(
        redAndBlue: AnimatedClass.fromJson(json["red-and-blue"]),
        redAndGreen: AnimatedClass.fromJson(json["red-and-green"]),
    );

    Map<String, dynamic> toJson() => {
        "red-and-blue": redAndBlue.toJson(),
        "red-and-green": redAndGreen.toJson(),
    };
}

class PurpleGenerationIi {
    final AnimatedClass goldAndSilver;

    PurpleGenerationIi({
        required this.goldAndSilver,
    });

    factory PurpleGenerationIi.fromJson(Map<String, dynamic> json) => PurpleGenerationIi(
        goldAndSilver: AnimatedClass.fromJson(json["gold-and-silver"]),
    );

    Map<String, dynamic> toJson() => {
        "gold-and-silver": goldAndSilver.toJson(),
    };
}

class SpritesAnimated {
    final String frontShiny;
    final dynamic frontFemale;
    final String frontDefault;
    final dynamic frontShinyFemale;
    final String? backShiny;
    final dynamic backFemale;
    final String? backDefault;
    final dynamic backShinyFemale;

    SpritesAnimated({
        required this.frontShiny,
        required this.frontFemale,
        required this.frontDefault,
        required this.frontShinyFemale,
        this.backShiny,
        this.backFemale,
        this.backDefault,
        this.backShinyFemale,
    });

    factory SpritesAnimated.fromJson(Map<String, dynamic> json) => SpritesAnimated(
        frontShiny: json["front_shiny"],
        frontFemale: json["front_female"],
        frontDefault: json["front_default"],
        frontShinyFemale: json["front_shiny_female"],
        backShiny: json["back_shiny"],
        backFemale: json["back_female"],
        backDefault: json["back_default"],
        backShinyFemale: json["back_shiny_female"],
    );

    Map<String, dynamic> toJson() => {
        "front_shiny": frontShiny,
        "front_female": frontFemale,
        "front_default": frontDefault,
        "front_shiny_female": frontShinyFemale,
        "back_shiny": backShiny,
        "back_female": backFemale,
        "back_default": backDefault,
        "back_shiny_female": backShinyFemale,
    };
}

class Type {
    final int slot;
    final Species type;

    Type({
        required this.slot,
        required this.type,
    });

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
    };
}
