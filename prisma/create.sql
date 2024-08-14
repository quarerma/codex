create type CREDIT as enum ('LOW', 'MEDIUM', 'HIGH', 'UNLIMITED');
create type FeatType as enum ('CLASS', 'SUBCLASS', 'CAMPAIGN', 'GENERAL');
create type Element as enum ('REALITY', 'DEATH', 'FEAR', 'ENERGY', 'BLOOD', 'KNOWLEDGE');
create type Proficiency as enum ('SIMPLE', 'TATICAL', 'HEAVY', 'LIGHT_ARMOR', 'HEAVY_ARMOR');
create type ItemType as enum ('WEAPON', 'ARMOR', 'AMMO', 'ACESSORY', 'EXPLOSIVE', 'OPERATIONAL_EQUIPMENT', 'PARANORMAL_EQUIPMENT', 'CURSED_ITEM', 'DEFAULT');
create type Range as enum ('MELEE', 'SHORT', 'MEDIUM', 'LONG');
create type DamageType as enum ('PIERCING', 'BALISTIC', 'IMPACT', 'SLASHING', 'FIRE');
create type WeaponCategory as enum ('SIMPLE', 'TATIC', 'HEAVY');
create type WeaponType as enum ('MELEE', 'BOLT', 'BULLET');
create type HandType as enum ('ONE_HANDED', 'TWO_HANDED', 'LIGHT');
create type ModificationType as enum ('MELEE_WEAPON', 'BULLET_WEAPON', 'BOLT_WEAPON', 'ARMOR', 'AMMO', 'ACESSORY');



create table user (
    id varchar(100) primary key not null deafult cuid(),
    username varchar(50) unique not null,
    password varchar(250) not null,
    email varchar(100) unique not null,
)

create table campaigns (
    id varchar(100) primary key not null default cuid(),
    createdAt timestamp default now(),
    name varchar(50),
    description text,
    password varchar(250),

    ownerId varchar(100),

    foreign key (ownerId) references user(id)
);


create table playerOnCampaign (
    playerId varchar(100),
    campaignId varchar(100),
    joinedAt timestamp default now(),

    primary key (playerId, campaignId),

    foreign key (playerId) references user(id),
    foreign key (campaignId) references campaigns(id)
);

create table character (
    id varchar(100) primary key not null default cuid(),
    name varchar(50),
    level int deafult 0,

    owner_id varchar(100),
    campaign_id varchar(100),

    healthInfo json,
    effortInfo json,
    sanityInfo json,

    atributes json,
    skills json[],
    attacks json[],
)

create table inventory (
    id varchar(100) primary key not null default cuid(),
    character_id varchar(100),

    carry_info json,
    credit CREDIT default 'LOW',
    equipment json[],

    foreign key (character_id) references character(id)
);


create table feat (
    id varchar(100) primary key not null default cuid(),
    name varchar(50),
    description text,
    prerequisites varchar(100)[],
    characterUpgrades json[],
    type FeatType,
    elemente Element,
);

create table origin(
    id varchar(100) primary key not null default cuid(),
    name varchar(50) unique,
    description text,
    is_custom boolean default false,
    feat_id varchar(100),

    foreign key (feat_id) references feat(id)
);

create table class (
    id varchar(100) primary key not null default cuid(),
    name varchar(50) unique,
    hitPointsPerLevel int,
    sanityPointsPerLevel int,
    effortPointsPerLevel int,

    initialHealth int,
    initialSanity int,
    initialEffort int,

    initialFeats varchar(100)[],
    proficiencies Proficiency[],
)

create table subclass (
    id varchar(100) primary key not null default cuid(),
    name varchar(50) unique,
    description text,
    class_id varchar(100),

    foreign key (class_id) references class(id)
);

create table class_feats (
    class_id varchar(100),
    feat_id varchar(100),

    foreign key (class_id) references class(id),
    foreign key (feat_id) references feat(id),

    primary key (class_id, feat_id)
);

create table subclass_feats (
    subclass_id varchar(100),
    feat_id varchar(100),

    foreign key (subclass_id) references subclass(id),
    foreign key (feat_id) references feat(id),

    primary key (subclass_id, feat_id)
);

create table campaign_feats (
    campaign_id varchar(100),
    feat_id varchar(100),

    foreign key (campaign_id) references campaigns(id),
    foreign key (feat_id) references feat(id),

    primary key (campaign_id, feat_id)
);

create table general_feats (
    feat_id varchar(100),

    foreign key (feat_id) references feat(id),
    primary key (feat_id)
);

create table character_feats (
    character_id varchar(100),
    feat_id varchar(100),

    foreign key (character_id) references character(id),
    foreign key (feat_id) references feat(id),

    primary key (character_id, feat_id)
);

ALTER TABLE character ADD COLUMN class_id varchar(100) references class(id);
ALTER TABLE character ADD COLUMN subclass_id varchar(100) references subclass(id);
ALTER TABLE character ADD COLUMN origin_id varchar(100) references origin(id);

create table rituals(
    id varchar(100) primary key not null default cuid(),
    name varchar(50) unique,
    description text,
    element Element,
    is_custom boolean default false,
)

create table character_rituals(
    character_id varchar(100),
    ritual_id varchar(100),

    foreign key (character_id) references character(id),
    foreign key (ritual_id) references rituals(id),

    primary key (character_id, ritual_id)
);

create table campaign_rituals(
    campaign_id varchar(100),
    ritual_id varchar(100),

    foreign key (campaign_id) references campaigns(id),
    foreign key (ritual_id) references rituals(id),

    primary key (campaign_id, ritual_id)
);

create table equipment(
    id varchar(100) primary key not null default cuid(),
    name varchar(50) unique,
    description text,
    weight int,
    type ItemType,
    is_custom boolean default false,
)

create table weapon(
    equipment_id varchar(100),
    damage varchar(10)[],
    critical_multiplier int,
    critical_range int,
    range Range,
    damage_type DamageType,
    weapon_category WeaponCategory,
    weapon_type WeaponType,
    hand_type HandType,

    foreign key (equipment_id) references equipment(id)
)

create table armor (
    equipment_id varchar(100),
    defense int,
    damage_reduction int,

    foreign key (equipment_id) references equipment(id)
)

create table acessory (
    equipment_id varchar(100),
    skill_check varchar(100),

    character_upgrades json[],
    foreign key (equipment_id) references equipment(id)
)

create table cursed_item (
    equipment_id varchar(100),
    element Element,

    foreign key (equipment_id) references equipment(id)
)

create table campaing_equipment (
    campaign_id varchar(100),
    equipment_id varchar(100),

    foreign key (campaign_id) references campaigns(id),
    foreign key (equipment_id) references equipment(id),

    primary key (campaign_id, equipment_id)
)

create table modification (
    id varchar(100) primary key not null default cuid(),
    name varchar(50) unique,
    description text,
    element Element,
    is_custom boolean default false,
    character_upgrades json[],
    type ModificationType[],
)

create table campaign_modification (
    campaign_id varchar(100),
    modification_id varchar(100),

    foreign key (campaign_id) references campaigns(id),
    foreign key (modification_id) references modification(id),

    primary key (campaign_id, modification_id)
)
