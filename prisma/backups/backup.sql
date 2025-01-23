--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: Atribute; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Atribute" AS ENUM (
    'STRENGTH',
    'DEXTERITY',
    'VITALITY',
    'INTELLIGENCE',
    'PRESENCE'
);


ALTER TYPE public."Atribute" OWNER TO postgres;

--
-- Name: Credit; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Credit" AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'UNLIMITED'
);


ALTER TYPE public."Credit" OWNER TO postgres;

--
-- Name: DamageType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DamageType" AS ENUM (
    'PIERCING',
    'BALISTIC',
    'IMPACT',
    'SLASHING',
    'FIRE',
    'CHEMICAL',
    'POISON',
    'BLOOD',
    'FEAR',
    'KNOWLEDGE',
    'DEATH',
    'ENERGY',
    'ELETRIC'
);


ALTER TYPE public."DamageType" OWNER TO postgres;

--
-- Name: Element; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Element" AS ENUM (
    'REALITY',
    'FEAR',
    'BLOOD',
    'DEATH',
    'ENERGY',
    'KNOWLEDGE'
);


ALTER TYPE public."Element" OWNER TO postgres;

--
-- Name: FeatType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."FeatType" AS ENUM (
    'CLASS',
    'SUBCLASS',
    'GENERAL',
    'CUSTOM',
    'ORIGIN'
);


ALTER TYPE public."FeatType" OWNER TO postgres;

--
-- Name: HandType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."HandType" AS ENUM (
    'LIGHT',
    'ONE_HANDED',
    'TWO_HANDED'
);


ALTER TYPE public."HandType" OWNER TO postgres;

--
-- Name: ItemType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ItemType" AS ENUM (
    'WEAPON',
    'ARMOR',
    'AMMO',
    'ACESSORY',
    'EXPLOSIVE',
    'OPERATIONAL_EQUIPMENT',
    'PARANORMAL_EQUIPMENT',
    'CURSED_ITEM',
    'DEFAULT'
);


ALTER TYPE public."ItemType" OWNER TO postgres;

--
-- Name: ModificationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ModificationType" AS ENUM (
    'MELEE_WEAPON',
    'BULLET_WEAPON',
    'BOLT_WEAPON',
    'ARMOR',
    'AMMO',
    'ACESSORY'
);


ALTER TYPE public."ModificationType" OWNER TO postgres;

--
-- Name: Patent; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Patent" AS ENUM (
    'ROOKIE',
    'OPERATOR',
    'SPECIAL_AGENT',
    'OPERATION_OFFICER',
    'ELITE_AGENT'
);


ALTER TYPE public."Patent" OWNER TO postgres;

--
-- Name: Proficiency; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Proficiency" AS ENUM (
    'SIMPLE',
    'TATICAL',
    'HEAVY',
    'LIGHT_ARMOR',
    'HEAVY_ARMOR'
);


ALTER TYPE public."Proficiency" OWNER TO postgres;

--
-- Name: Range; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Range" AS ENUM (
    'MELEE',
    'SHORT',
    'MEDIUM',
    'LONG',
    'SELF',
    'TOUCH',
    'EXTREME',
    'UNLIMITED'
);


ALTER TYPE public."Range" OWNER TO postgres;

--
-- Name: RitualType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."RitualType" AS ENUM (
    'EFFECT',
    'DAMAGE'
);


ALTER TYPE public."RitualType" OWNER TO postgres;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'USER',
    'ADMIN'
);


ALTER TYPE public."Role" OWNER TO postgres;

--
-- Name: WeaponCategory; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."WeaponCategory" AS ENUM (
    'SIMPLE',
    'TATICAL',
    'HEAVY'
);


ALTER TYPE public."WeaponCategory" OWNER TO postgres;

--
-- Name: WeaponType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."WeaponType" AS ENUM (
    'MELEE',
    'BOLT',
    'BULLET'
);


ALTER TYPE public."WeaponType" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Campaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Campaign" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255) NOT NULL,
    password text NOT NULL,
    owner_id text NOT NULL
);


ALTER TABLE public."Campaign" OWNER TO postgres;

--
-- Name: CampaignEquipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CampaignEquipment" (
    id text NOT NULL,
    campaign_id text NOT NULL,
    equipment_id integer NOT NULL
);


ALTER TABLE public."CampaignEquipment" OWNER TO postgres;

--
-- Name: CampaignFeats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CampaignFeats" (
    "featId" text NOT NULL,
    "campaignId" text NOT NULL
);


ALTER TABLE public."CampaignFeats" OWNER TO postgres;

--
-- Name: CampaignModifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CampaignModifications" (
    id text NOT NULL,
    campaign_id text NOT NULL,
    modification_id text NOT NULL
);


ALTER TABLE public."CampaignModifications" OWNER TO postgres;

--
-- Name: CampaignOrigin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CampaignOrigin" (
    id text NOT NULL,
    campaign_id text NOT NULL,
    origin_id text NOT NULL
);


ALTER TABLE public."CampaignOrigin" OWNER TO postgres;

--
-- Name: CampaignRitual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CampaignRitual" (
    id text NOT NULL,
    campaign_id text NOT NULL,
    ritual_id text NOT NULL
);


ALTER TABLE public."CampaignRitual" OWNER TO postgres;

--
-- Name: Character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Character" (
    id text NOT NULL,
    name character varying(50) NOT NULL,
    level integer NOT NULL,
    owner_id text NOT NULL,
    campaign_id text NOT NULL,
    class_id text NOT NULL,
    subclass_id text NOT NULL,
    health_info jsonb NOT NULL,
    effort_info jsonb NOT NULL,
    sanity_info jsonb NOT NULL,
    atributes jsonb NOT NULL,
    skills jsonb[],
    attacks jsonb[],
    origin_id text NOT NULL,
    proficiencies public."Proficiency"[],
    current_effort integer NOT NULL,
    current_health integer NOT NULL,
    current_sanity integer NOT NULL,
    max_effort integer NOT NULL,
    max_health integer NOT NULL,
    max_sanity integer NOT NULL,
    defense integer NOT NULL,
    speed integer NOT NULL,
    num_of_skills integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Character" OWNER TO postgres;

--
-- Name: CharacterCondition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CharacterCondition" (
    character_id text NOT NULL,
    condition_id text NOT NULL
);


ALTER TABLE public."CharacterCondition" OWNER TO postgres;

--
-- Name: CharacterFeat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CharacterFeat" (
    character_id text NOT NULL,
    feat_id text NOT NULL,
    "usingAfinity" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."CharacterFeat" OWNER TO postgres;

--
-- Name: CharacterRitual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CharacterRitual" (
    character_id text NOT NULL,
    ritual_id text NOT NULL,
    alterations jsonb[],
    ritual_cost integer NOT NULL
);


ALTER TABLE public."CharacterRitual" OWNER TO postgres;

--
-- Name: Class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Class" (
    id text NOT NULL,
    name character varying(50) NOT NULL,
    "SanityPointsPerLevel" integer NOT NULL,
    "effortPointsPerLevel" integer NOT NULL,
    "hitPointsPerLevel" integer NOT NULL,
    "initialEffort" integer NOT NULL,
    "initialHealth" integer NOT NULL,
    "initialSanity" integer NOT NULL,
    proficiencies public."Proficiency"[],
    description text NOT NULL,
    number_of_skills integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Class" OWNER TO postgres;

--
-- Name: ClassFeats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClassFeats" (
    "featId" text NOT NULL,
    "classId" text NOT NULL,
    "isStarterFeat" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."ClassFeats" OWNER TO postgres;

--
-- Name: Condition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Condition" (
    id text NOT NULL,
    name character varying(50) NOT NULL,
    description text NOT NULL,
    is_custom boolean NOT NULL
);


ALTER TABLE public."Condition" OWNER TO postgres;

--
-- Name: CursedItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CursedItem" (
    "equipmentId" integer NOT NULL,
    element public."Element" NOT NULL
);


ALTER TABLE public."CursedItem" OWNER TO postgres;

--
-- Name: DamageRitual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DamageRitual" (
    "ritualId" text NOT NULL,
    "normalCastDamageType" public."DamageType",
    "discentCastDamageType" public."DamageType",
    "trueCastDamageType" public."DamageType",
    "normalCastDamage" text,
    "discentCastDamage" text,
    "trueCastDamage" text
);


ALTER TABLE public."DamageRitual" OWNER TO postgres;

--
-- Name: Equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Equipment" (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    weight integer NOT NULL,
    category integer NOT NULL,
    type public."ItemType" NOT NULL,
    is_custom boolean NOT NULL,
    num_of_uses integer NOT NULL,
    "characterUpgrades" jsonb[]
);


ALTER TABLE public."Equipment" OWNER TO postgres;

--
-- Name: Equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Equipment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Equipment_id_seq" OWNER TO postgres;

--
-- Name: Equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Equipment_id_seq" OWNED BY public."Equipment".id;


--
-- Name: Feat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Feat" (
    id text NOT NULL,
    name character varying(50) NOT NULL,
    description text NOT NULL,
    prerequisites text,
    "characterUpgrades" jsonb[],
    type public."FeatType" NOT NULL,
    element public."Element" NOT NULL,
    afinity text,
    "afinityUpgrades" jsonb[]
);


ALTER TABLE public."Feat" OWNER TO postgres;

--
-- Name: GeneralFeats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GeneralFeats" (
    id text NOT NULL,
    "featId" text NOT NULL
);


ALTER TABLE public."GeneralFeats" OWNER TO postgres;

--
-- Name: Inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Inventory" (
    character_id text NOT NULL,
    credit public."Credit" DEFAULT 'LOW'::public."Credit" NOT NULL,
    alterations jsonb[],
    "maxValue" integer NOT NULL,
    patent public."Patent" NOT NULL
);


ALTER TABLE public."Inventory" OWNER TO postgres;

--
-- Name: InventorySlot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InventorySlot" (
    id text NOT NULL,
    inventory_id text NOT NULL,
    equipment_id integer,
    uses integer DEFAULT 0 NOT NULL,
    category integer NOT NULL,
    local_name text NOT NULL,
    alterations jsonb[],
    is_equipped boolean DEFAULT false NOT NULL,
    local_description text NOT NULL,
    weight integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."InventorySlot" OWNER TO postgres;

--
-- Name: Modification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Modification" (
    id text NOT NULL,
    name text NOT NULL,
    type public."ModificationType"[],
    element public."Element" NOT NULL,
    "characterUpgrades" jsonb[],
    description text NOT NULL,
    is_custom boolean NOT NULL
);


ALTER TABLE public."Modification" OWNER TO postgres;

--
-- Name: Notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Notes" (
    id text NOT NULL,
    title character varying(50) NOT NULL,
    character_id text,
    campaign_id text,
    content text
);


ALTER TABLE public."Notes" OWNER TO postgres;

--
-- Name: Origin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Origin" (
    id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    is_custom boolean NOT NULL,
    feat_id text NOT NULL,
    skills text[]
);


ALTER TABLE public."Origin" OWNER TO postgres;

--
-- Name: PlayerOnCampaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PlayerOnCampaign" (
    campaign_id text NOT NULL,
    player_id text NOT NULL,
    joined_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."PlayerOnCampaign" OWNER TO postgres;

--
-- Name: Ritual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ritual" (
    id text NOT NULL,
    name text NOT NULL,
    element public."Element" NOT NULL,
    is_custom boolean NOT NULL,
    "discentCastDescription" text,
    duration text NOT NULL,
    "exectutionTime" text NOT NULL,
    "normalCastDescription" text NOT NULL,
    range public."Range" NOT NULL,
    target text NOT NULL,
    "trueCastDescription" text,
    type public."RitualType" NOT NULL,
    "discentCost" integer,
    "ritualLevel" integer NOT NULL,
    "trueCost" integer,
    "normalCost" integer NOT NULL,
    resistence text NOT NULL
);


ALTER TABLE public."Ritual" OWNER TO postgres;

--
-- Name: RitualCondition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RitualCondition" (
    ritual_id text NOT NULL,
    condition_id text NOT NULL
);


ALTER TABLE public."RitualCondition" OWNER TO postgres;

--
-- Name: Skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Skill" (
    name text NOT NULL,
    atribute public."Atribute" NOT NULL,
    description text NOT NULL,
    only_trained boolean NOT NULL,
    carry_peanalty boolean NOT NULL,
    needs_kit boolean NOT NULL,
    is_custom boolean NOT NULL,
    campaign_id text
);


ALTER TABLE public."Skill" OWNER TO postgres;

--
-- Name: Subclass; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Subclass" (
    id text NOT NULL,
    name character varying(50) NOT NULL,
    "classId" text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public."Subclass" OWNER TO postgres;

--
-- Name: SubclassFeats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SubclassFeats" (
    "featId" text NOT NULL,
    "subclassId" text NOT NULL,
    "levelRequired" integer NOT NULL
);


ALTER TABLE public."SubclassFeats" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id text NOT NULL,
    username character varying(50) NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    role public."Role" DEFAULT 'USER'::public."Role" NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: Weapon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Weapon" (
    "equipmentId" integer NOT NULL,
    damage text NOT NULL,
    critical_multiplier integer NOT NULL,
    critical_range integer NOT NULL,
    range public."Range" NOT NULL,
    damage_type public."DamageType" NOT NULL,
    weapon_category public."WeaponCategory" NOT NULL,
    weapon_type public."WeaponType" NOT NULL,
    hand_type public."HandType" NOT NULL
);


ALTER TABLE public."Weapon" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Equipment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Equipment" ALTER COLUMN id SET DEFAULT nextval('public."Equipment_id_seq"'::regclass);


--
-- Data for Name: Campaign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Campaign" (id, "createdAt", name, description, password, owner_id) FROM stdin;
cm5hc4i6z00014p9wyqal4c7k	2025-01-03 22:36:52.311	Olhos do Passado	Lugar onde todos te observam	$2b$10$3mIZN.0qJDRgQnLm.hHNNu66PX4wjNnMhVzM95bS/jLyrR3N5fPMK	cm5hc0bh900004p9wvlq38ry2
cm5hjm9hj0000147bc51q2l0p	2025-01-04 02:06:38.142	Pesadelos	História de uma mulher que adorava brincar com pedrinhas na praia... e pessoas.	$2b$10$yIbjk.jpkeCzrPmwA9JeQuWw23WO8hsE8icwRuQbk3sP2bm5K/i/i	cm1bc46xx0000knwbt37wqtvi
\.


--
-- Data for Name: CampaignEquipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CampaignEquipment" (id, campaign_id, equipment_id) FROM stdin;
cm5hc9w6g00024p9wzf2szlrl	cm5hc4i6z00014p9wyqal4c7k	8
cm5j13jff000311umdb5zms2f	cm5hc4i6z00014p9wyqal4c7k	18
\.


--
-- Data for Name: CampaignFeats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CampaignFeats" ("featId", "campaignId") FROM stdin;
\.


--
-- Data for Name: CampaignModifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CampaignModifications" (id, campaign_id, modification_id) FROM stdin;
\.


--
-- Data for Name: CampaignOrigin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CampaignOrigin" (id, campaign_id, origin_id) FROM stdin;
\.


--
-- Data for Name: CampaignRitual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CampaignRitual" (id, campaign_id, ritual_id) FROM stdin;
\.


--
-- Data for Name: Character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Character" (id, name, level, owner_id, campaign_id, class_id, subclass_id, health_info, effort_info, sanity_info, atributes, skills, attacks, origin_id, proficiencies, current_effort, current_health, current_sanity, max_effort, max_health, max_sanity, defense, speed, num_of_skills) FROM stdin;
cm5ilwpxl0009b9sj0y59694c	Kleber Martins	4	cm5bmno2k0000n92qg3024kzq	cm5hc4i6z00014p9wyqal4c7k	cm1beidgp0001knwb86n0e6w6	cm1bemy380008knwbh8ht7a7b	{"alterations": [{"feat": "cm5ia5pp8000511v8w1wdr8db", "featName": "Vitalidade Reforçada"}], "valuePerLevel": 10}	{"alterations": [], "valuePerLevel": 3}	{"maxValue": 21, "alterations": [], "currentValue": 21, "valuePerLevel": 3}	{"presence": 1, "strength": 3, "vitality": 4, "dexterity": 0, "alterations": [], "intelligence": 2}	{"{\\"name\\": \\"Acrobacia\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Adestramento\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Artes\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Atletismo\\", \\"value\\": 5, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Atualidades\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Ciências\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Crime\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Diplomacia\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Enganação\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Fortitude\\", \\"value\\": 7, \\"atribute\\": \\"VITALITY\\", \\"alterations\\": [{\\"feat\\": \\"cm5ia5pp8000511v8w1wdr8db\\", \\"value\\": 2, \\"featName\\": \\"Vitalidade Reforçada\\"}], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Furtividade\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Iniciativa\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Intimidação\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Intuição\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Investigação\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Luta\\", \\"value\\": 5, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Medicina\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Ocultismo\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Percepção\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Pilotagem\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Pontaria\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Profissão\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Reflexos\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Religião\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Sobrevivência\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tática\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tecnologia\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Vontade\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}"}	{"{\\"name\\": \\"Machado\\", \\"skill\\": \\"Luta\\", \\"local_id\\": \\"cm5ilzhd3000ab9sjwg9g6n4l\\", \\"alterations\\": [], \\"damage_dies\\": [\\"1d8\\"], \\"extra_damage\\": [], \\"critical_margin\\": 20, \\"critical_multiplier\\": 3}"}	cm5i9y1dk000011v8dfwtxcvz	{SIMPLE,TATICAL,LIGHT_ARMOR}	12	56	21	12	56	21	19	9	5
cm5jiyyz20001pa9ebsck83xh	Giovanni Constanzo	4	cm5jis4km0000pa9ew5i0gk3s	cm5hc4i6z00014p9wyqal4c7k	cm1beidgp0001knwb86n0e6w6	cm1bely5b0004knwb1e1zi0hi	{"alterations": [], "valuePerLevel": 6}	{"alterations": [], "valuePerLevel": 3}	{"maxValue": 21, "alterations": [], "currentValue": 21, "valuePerLevel": 3}	{"presence": 1, "strength": 3, "vitality": 2, "dexterity": 2, "alterations": [], "intelligence": 1}	{"{\\"name\\": \\"Acrobacia\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Adestramento\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Artes\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Atletismo\\", \\"value\\": 0, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Atualidades\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Ciências\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Crime\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Diplomacia\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Enganação\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Fortitude\\", \\"value\\": 5, \\"atribute\\": \\"VITALITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Furtividade\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Iniciativa\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Intimidação\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Intuição\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Investigação\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Luta\\", \\"value\\": 5, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Medicina\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Ocultismo\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Percepção\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Pilotagem\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Pontaria\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Profissão\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Reflexos\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Religião\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Sobrevivência\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tática\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tecnologia\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Vontade\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}"}	\N	cm5icnn6v0005xhvh67p6pkdp	{SIMPLE,TATICAL,LIGHT_ARMOR}	10	37	19	12	40	21	17	9	5
cm5ieylye0009xhvh61qjflda	Kate Carter	4	cm5ieq8i70008xhvho01d3xkv	cm5hc4i6z00014p9wyqal4c7k	cm1bejpao0002knwbwlri6asv	cm1benvcd000cknwbwjc693zu	{"alterations": [], "valuePerLevel": 4}	{"alterations": [], "valuePerLevel": 6}	{"maxValue": 28, "alterations": [], "currentValue": 28, "valuePerLevel": 4}	{"presence": 3, "strength": 1, "vitality": 1, "dexterity": 2, "alterations": [], "intelligence": 3}	{"{\\"name\\": \\"Acrobacia\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Adestramento\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Artes\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Atletismo\\", \\"value\\": 0, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Atualidades\\", \\"value\\": 5, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Ciências\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Crime\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Diplomacia\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Enganação\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Fortitude\\", \\"value\\": 0, \\"atribute\\": \\"VITALITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Furtividade\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Iniciativa\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Intimidação\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Intuição\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Investigação\\", \\"value\\": 5, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Luta\\", \\"value\\": 0, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Medicina\\", \\"value\\": 5, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Ocultismo\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Percepção\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Pilotagem\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Pontaria\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Profissão\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Reflexos\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Religião\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Sobrevivência\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tática\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tecnologia\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Vontade\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}"}	{"{\\"name\\": \\"Fuzil de caça\\", \\"skill\\": \\"Pontaria\\", \\"local_id\\": \\"cm5j3ralf00005p0p2d69jw7h\\", \\"alterations\\": [], \\"damage_dies\\": [\\"2d8\\"], \\"extra_damage\\": [], \\"critical_margin\\": 19, \\"critical_multiplier\\": 3}"}	cm1bgje25001jknwb0be1qzbq	{SIMPLE,LIGHT_ARMOR}	22	22	21	24	29	28	12	9	9
cm5iapljv000f11v8nsb6ew4j	Tobias Porto	4	cm1bc46xx0000knwbt37wqtvi	cm5hc4i6z00014p9wyqal4c7k	cm1bekpmk0003knwbdi0gscjk	cm1beodck000eknwbtc0du48u	{"alterations": [], "valuePerLevel": 4}	{"alterations": [], "valuePerLevel": 8}	{"maxValue": 35, "alterations": [], "currentValue": 35, "valuePerLevel": 5}	{"presence": 4, "strength": 0, "vitality": 1, "dexterity": 2, "alterations": [], "intelligence": 3}	{"{\\"name\\": \\"Acrobacia\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Adestramento\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Artes\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Atletismo\\", \\"value\\": 0, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Atualidades\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Ciências\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Crime\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Diplomacia\\", \\"value\\": 10, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [{\\"feat\\": \\"cm5hkz485000d6apb0fck9bza\\", \\"value\\": 5, \\"featName\\": \\"Sensitivo\\"}], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Enganação\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Fortitude\\", \\"value\\": 4, \\"atribute\\": \\"VITALITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Furtividade\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Iniciativa\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Intimidação\\", \\"value\\": 10, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [{\\"feat\\": \\"cm5hkz485000d6apb0fck9bza\\", \\"value\\": 5, \\"featName\\": \\"Sensitivo\\"}], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Intuição\\", \\"value\\": 10, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [{\\"feat\\": \\"cm5hkz485000d6apb0fck9bza\\", \\"value\\": 5, \\"featName\\": \\"Sensitivo\\"}], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Investigação\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Luta\\", \\"value\\": 0, \\"atribute\\": \\"STRENGTH\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Medicina\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Ocultismo\\", \\"value\\": 10, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [{\\"item\\": 8, \\"value\\": 5, \\"itemName\\": \\"Crucifixo Invertido\\"}], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Percepção\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Pilotagem\\", \\"value\\": 0, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Pontaria\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Profissão\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Reflexos\\", \\"value\\": 5, \\"atribute\\": \\"DEXTERITY\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}","{\\"name\\": \\"Religião\\", \\"value\\": 0, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Sobrevivência\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tática\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Tecnologia\\", \\"value\\": 0, \\"atribute\\": \\"INTELLIGENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"none\\"}","{\\"name\\": \\"Vontade\\", \\"value\\": 5, \\"atribute\\": \\"PRESENCE\\", \\"alterations\\": [], \\"trainingLevel\\": \\"trained\\"}"}	{"{\\"name\\": \\"Revólver\\", \\"skill\\": \\"Pontaria\\", \\"local_id\\": \\"cm5ilsiie0007b9sjpun1t6r1\\", \\"alterations\\": [], \\"damage_dies\\": [\\"2d6\\"], \\"extra_damage\\": [], \\"critical_margin\\": 19, \\"critical_multiplier\\": 3}","{\\"name\\": \\"Faca\\", \\"skill\\": \\"Pontaria\\", \\"local_id\\": \\"cm5j26eks000b11umy5lx534y\\", \\"alterations\\": [], \\"damage_dies\\": [\\"1d4\\"], \\"extra_damage\\": [], \\"critical_margin\\": 19, \\"critical_multiplier\\": 2}"}	cm1bgje25001jknwb0be1qzbq	{SIMPLE}	27	22	22	32	22	30	12	9	7
\.


--
-- Data for Name: CharacterCondition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CharacterCondition" (character_id, condition_id) FROM stdin;
\.


--
-- Data for Name: CharacterFeat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CharacterFeat" (character_id, feat_id, "usingAfinity") FROM stdin;
cm5iapljv000f11v8nsb6ew4j	cm5hkz485000d6apb0fck9bza	f
cm5ilwpxl0009b9sj0y59694c	cm5ia5pp8000511v8w1wdr8db	f
\.


--
-- Data for Name: CharacterRitual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CharacterRitual" (character_id, ritual_id, alterations, ritual_cost) FROM stdin;
cm5iapljv000f11v8nsb6ew4j	cm5j19qq2000511umm0dq0rl6	\N	1
cm5iapljv000f11v8nsb6ew4j	cm5j1cgnx000611um7acukdm2	\N	1
cm5iapljv000f11v8nsb6ew4j	cm5j1f7u9000711um2j4gis5o	\N	1
cm5iapljv000f11v8nsb6ew4j	cm5j1i8sf000811um31vh5nk2	\N	1
cm5iapljv000f11v8nsb6ew4j	cm5j1npzn000a11umnpb5p836	\N	1
cm5iapljv000f11v8nsb6ew4j	cm1bgryld001uknwbjhewmpq9	\N	1
cm5iapljv000f11v8nsb6ew4j	cm5j1kece000911umr28219vr	\N	1
\.


--
-- Data for Name: Class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Class" (id, name, "SanityPointsPerLevel", "effortPointsPerLevel", "hitPointsPerLevel", "initialEffort", "initialHealth", "initialSanity", proficiencies, description, number_of_skills) FROM stdin;
cm1beidgp0001knwb86n0e6w6	Combatente	3	2	4	2	20	12	{SIMPLE,TATICAL,LIGHT_ARMOR}	<p>Treinado para lutar com todo tipo de armas, e com a força e a coragem para encarar os perigos de frente, É o tipo de agente que prefere abordagens mais diretas e costuma atirar primeiro e perguntar depois. </p><p><br></p><p>Do mercenário especialista em armas de fogo até o perito em espadas, combatentes apresentam uma gama enorme de habilidades e técnicas especiais que aprimoram sua eficiência no campo de batalha, tornando-os membros essenciais em qualquer missão de extermínio. </p><p><br></p><p>Além de treinar seu corpo, o combatente também é perito em liderar seus aliados em batalha e cuidar de seu equipamento de combate, sempre preparado para assumir a linha de frente quando a coisa fica feia</p>	3
cm1bejpao0002knwbwlri6asv	Especialista	4	3	3	3	16	16	{SIMPLE,LIGHT_ARMOR}	<p>Um agente que confia mais em esperteza do que em força bruta. Um especialista se vale de conhecimento técnico, raciocínio rápido ou mesmo lábia para resolver mistérios e enfrentar o paranormal. </p><p><br></p><p>Cientistas, inventores, pesquisadores e técnicos de vários tipos são exemplos de especialistas, que são tão variados quanto as áreas do conhecimento e da tecnologia. Alguns ainda preferem estudar engenharia social e se tornam excelentes espiões infiltrados, ou mesmo estudam técnicas especiais de combate como artes marciais e tiro a distância, aliando conhecimento técnico e habilidade. </p><p><br></p><p>O que une todos os especialistas é sua incrível capacidade de aprender e improvisar usando seu intelecto e conhecimento avançado, que pode tirar o grupo todo dos mais diversos tipos de enrascadas.</p>	7
cm1bekpmk0003knwbdi0gscjk	Ocultista	5	4	2	4	12	20	{SIMPLE}	<p>O Outro Lado é misterioso, perigoso e, de certa forma, cativante. Muitos estudiosos das entidades se perdem em seus reinos obscuros em busca de poder, mas existem aqueles que visam compreender e dominar os mistérios paranormais para usá-los para combater o próprio Outro Lado. Esse tipo de agente não é apenas um conhecedor do oculto, como também possui talento para se conectar com elementos paranormais. </p><p><br></p><p>Ao contrário da crendice popular, ocultistas não são intrinsecamente malignos. Seria como dizer que o cientista que inventou a pólvora é culpado pelo assassino que disparou o revólver. Para a Ordem, o paranormal é uma força que pode ser usada para os mais diversos propósitos, de acordo com a intenção de seu usuário. </p><p><br></p><p>Ocultistas aplicam seu conhecimento acadêmico e suas capacidades de conjuração de rituais em missões para investigar e combater o paranormal em todas as suas formas, principalmente quando munição convencional não é o suficiente para lidar com a tarefa.</p>	5
\.


--
-- Data for Name: ClassFeats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ClassFeats" ("featId", "classId", "isStarterFeat") FROM stdin;
cm1bfssqn000jknwbawu9pgbz	cm1beidgp0001knwb86n0e6w6	t
cm1bftmrr000kknwbl8q2s9fj	cm1beidgp0001knwb86n0e6w6	t
cm1bfv6cs000lknwbgjqn1nhu	cm1beidgp0001knwb86n0e6w6	t
cm1bfvj04000mknwbs9slbd5b	cm1beidgp0001knwb86n0e6w6	t
cm1bfvswi000nknwbpgiv43gf	cm1beidgp0001knwb86n0e6w6	t
cm1bfw2ms000oknwb2tkpjazy	cm1beidgp0001knwb86n0e6w6	t
cm1bfx0pa000pknwbzwqgwclv	cm1bejpao0002knwbwlri6asv	t
cm1bfxgsu000qknwb3jpzo5vq	cm1bejpao0002knwbwlri6asv	t
cm1bfxvxs000rknwbia2ih4x9	cm1bejpao0002knwbwlri6asv	t
cm1bfyank000sknwbleo6wjpg	cm1bejpao0002knwbwlri6asv	t
cm1bfyrr8000tknwbkrmeojn5	cm1bejpao0002knwbwlri6asv	t
cm1bfz1p5000uknwbot9tihzq	cm1bejpao0002knwbwlri6asv	t
cm1bfz8y0000vknwbpc0dxs1e	cm1bejpao0002knwbwlri6asv	t
cm1bfzgle000wknwbw1gur7q4	cm1bejpao0002knwbwlri6asv	t
cm5iaejay000611v86sv20smy	cm1bejpao0002knwbwlri6asv	f
cm5ialr96000911v85d170hcm	cm1bekpmk0003knwbdi0gscjk	t
cm5iam940000a11v8oh0jmmzm	cm1bekpmk0003knwbdi0gscjk	t
cm5iamiri000b11v8z3iidy73	cm1bekpmk0003knwbdi0gscjk	t
cm5iamwhp000c11v8wvgxkdrl	cm1bekpmk0003knwbdi0gscjk	t
cm5ianb2g000d11v8ogslnpeb	cm1bekpmk0003knwbdi0gscjk	t
cm5ianigo000e11v8i3wjxnxe	cm1bekpmk0003knwbdi0gscjk	t
cm5icvvxv0007xhvhv5tdudy3	cm1beidgp0001knwb86n0e6w6	f
\.


--
-- Data for Name: Condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Condition" (id, name, description, is_custom) FROM stdin;
cm1bgrn7x001tknwbxj0bvf3m	Vulnerável	<p>O personagem sofre –5 na Defesa.</p>	f
cm1h5ctzq000712tey5r657jh	Debilitado	<p>O personagem sofre –2d20 em testes de Agilidade, Força e Vigor. Se o personagem ficar debilitado novamente, em vez disso fica inconsciente.</p>	f
cm1h5d1i8000812teko5plk00	Asfixiado	<p>O personagem não pode respirar. Um personagem asfixiado pode prender seu fôlego por um total de rodadas igual ao seu Vigor e, a cada vez que sofre dano enquanto está nesta condição, reduz este valor em 1. Ao final de seu turno na última dessas rodadas, o personagem fica morrendo.</p>	f
cm1h5d8ie000912te8mnlbi44	Atordoado	<p>O personagem fica desprevenido e não pode fazer ações. Condição mental.</p>	f
\.


--
-- Data for Name: CursedItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CursedItem" ("equipmentId", element) FROM stdin;
\.


--
-- Data for Name: DamageRitual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DamageRitual" ("ritualId", "normalCastDamageType", "discentCastDamageType", "trueCastDamageType", "normalCastDamage", "discentCastDamage", "trueCastDamage") FROM stdin;
cm1bgryld001uknwbjhewmpq9	ELETRIC	ENERGY	ENERGY	3d6	6d6	8d6
cm1h5py6b000f12tevm7nhzsq	DEATH	DEATH	DEATH	2d8+2	3d8+3	8d8+8
\.


--
-- Data for Name: Equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Equipment" (id, name, description, weight, category, type, is_custom, num_of_uses, "characterUpgrades") FROM stdin;
10	Kit de Perícia	<p>Um conjunto de ferramentas necessárias para algumas perícias ou usos de perícias. Sem o kit, você sofre –5 no teste. Existe um kit de perícia para cada perícia que exige este item.</p>	1	0	OPERATIONAL_EQUIPMENT	f	0	{}
12	Granada de Fumaça	<p>Para usar uma granada, você precisa empunhá-la e então gastar uma ação padrão para arremessá-la em um ponto à sua escolha em alcance médio. A granada afeta um raio de 6m a partir do ponto de impacto. O efeito que ela causa varia conforme o tipo de granada. Produz uma fumaça espessa e escura. Seres na área ficam cegos e sob camuflagem total. A fumaça dura 2 rodadas.</p>	1	1	OPERATIONAL_EQUIPMENT	f	0	{}
8	Crucifixo Invertido	<p>Crucifixo Invertido que emana uma aura estranha</p>	1	2	ACESSORY	f	0	{"{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 5, \\"upgradeTarget\\": \\"Ocultismo\\"}"}
17	Machado	<p>Uma ferramenta importante para lenhadores e bombeiros, um machado pode causar ferimentos terríveis.</p>	1	1	WEAPON	f	0	{}
16	Escudo	<p>Um escudo medieval ou moderno, como aqueles usados por tropas de choque. Precisa ser empunhado em uma mão e fornece Defesa +2. Bônus na Defesa fornecido por um escudo acumula com o de uma proteção. Para efeitos de proficiência e penalidade por não proficiência, escudos contam como proteção pesada.</p>	2	1	ARMOR	f	0	{"{\\"type\\": \\"DEFESA\\", \\"upgradeValue\\": 2}"}
15	Proteção Leve	<p>Jaqueta de couro pesada ou um colete de kevlar. Essa proteção é tipicamente usada por seguranças e policiais.</p>	2	1	ARMOR	f	0	{"{\\"type\\": \\"DEFESA\\", \\"upgradeValue\\": 5}"}
14	Balas Longas	<p>Maior e mais potente, esta munição é usada em fuzis e metralhadoras. Um pacote de balas longas dura uma cena.</p>	1	1	AMMO	f	1	{}
13	Balas Curtas	<p>Munição básica, usada em pistolas, revólveres e submetralhadoras. Um pacote de balas curtas dura duas cenas.</p>	1	0	AMMO	f	2	{}
11	Mochila Militar	<p>Uma mochila leve e de alta qualidade. Ela não usa nenhum espaço e aumenta sua capacidade de carga em 2 espaços.</p>	0	1	OPERATIONAL_EQUIPMENT	f	0	{}
9	Revólver	<p>A arma de fogo mais comum, e uma das mais confiáveis.</p>	1	1	WEAPON	f	0	{}
18	Deck de Cartas Paranormais	<p>Conjunto de cartas paranormais com poder ocultista contido.</p>	2	0	PARANORMAL_EQUIPMENT	f	0	{}
19	Fuzil de caça	<p>Esta arma de fogo é bastante popular entre fazendeiros, caçadores e atiradores esportistas.</p>	2	1	WEAPON	f	0	{}
20	Faca	<p>Uma lâmina longa e afiada, como uma navalha, uma faca de churrasco ou uma faca militar (facas de cozinha pequenas causam apenas 1d3 pontos de dano). É uma arma ágil e pode ser arremessada.</p>	1	0	WEAPON	f	0	{}
\.


--
-- Data for Name: Feat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Feat" (id, name, description, prerequisites, "characterUpgrades", type, element, afinity, "afinityUpgrades") FROM stdin;
cm1bfssqn000jknwbawu9pgbz	Ataque Especial	<p>Quando faz um ataque, você pode gastar 2 PE para receber +5 no teste de ataque ou na rolagem de dano. Conforme avança de NEX, você pode gastar +1 PE para receber mais bônus de +5. Você pode aplicar cada bônus de +5 em ataque ou dano. Por exemplo, em NEX 55%, você pode gastar 4 PE para receber +5 no teste de ataque e +10 na rolagem de dano.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bftmrr000kknwbl8q2s9fj	Habilidade de Trilha	<p>Em NEX 10% você escolhe uma das trilhas de combatente e recebe o primeiro poder da trilha escolhida. Você recebe um novo poder da trilha escolhida em NEX 40%, 65% e 99%.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfv6cs000lknwbgjqn1nhu	Poder de Combatente	<p>Em NEX 15%, você recebe um poder de combatente à sua escolha. Você recebe um novo poder de combatente em NEX 30% e a cada 15% de NEX subsequentes.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfvj04000mknwbs9slbd5b	Aumento de Atributo	<p>Em NEX 20%, e novamente em NEX 50%, 80% e 95%, aumente um atributo a sua escolha em +1. Você não pode aumentar um atributo além de 5 desta forma.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfw2ms000oknwb2tkpjazy	Versatilidade	<p>Em NEX 50%, escolha entre receber um poder de combatente ou o primeiro poder de uma trilha de combatente que não a sua.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfx0pa000pknwbzwqgwclv	Eclético	<p>Quando faz um teste de uma perícia, você pode gastar 2 PE para receber os benefícios de ser treinado nesta perícia.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfxgsu000qknwb3jpzo5vq	Perito	<p>Escolha duas perícias nas quais você é treinado (exceto Luta e Pontaria). Quando faz um teste de uma dessas perícias, você pode gastar 2 PE para somar +1d6 no resultado do teste. Conforme avança de NEX, você pode gastar +1 PE para aumentar o dado de bônus. Por exemplo, em NEX 55%, pode gastar 4 PE para receber +1d10 no teste.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfxvxs000rknwbia2ih4x9	Habilidade de Trilha	<p>Em NEX 10% você escolhe uma das trilhas de especialista disponíveis e recebe o primeiro poder da trilha escolhida. Você recebe um novo poder da trilha escolhida respectivamente em NEX 40%, 65% e 99%.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfyank000sknwbleo6wjpg	Poder de Especialista	<p>Em NEX 15%, você recebe um poder de especialista à sua escolha. Você recebe um novo poder de especialista em NEX 30% e a cada 15% de NEX subsequentes.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfyrr8000tknwbkrmeojn5	Aumento de Atributo	<p>Em NEX 20%, e novamente em NEX 50%, 80% e 95%, aumente um atributo a sua escolha em +1. Você não pode aumentar um atributo além de 5 desta forma.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfz1p5000uknwbot9tihzq	Grau de Treinamento	<p>Em NEX 35%, e novamente em NEX 70%, escolha um número de perícias treinadas igual a 5 + Int. Seu grau de treinamento nessas perícias aumenta em um (de treinado para veterano ou de veterano para expert).</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfz8y0000vknwbpc0dxs1e	Engenhosidade	<p>Em NEX 40%, quando usa sua habilidade Eclético, você pode gastar 2 PE adicionais para receber os benefícios de ser veterano na perícia. Em NEX 75%, pode gastar 4 PE adicionais para receber os benefícios de ser expert na perícia.&nbsp;</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bfzgle000wknwbw1gur7q4	Versatilidade	<p>Em NEX 50%, escolha entre receber um poder de especialista ou o primeiro poder de uma trilha de especialista que não a sua.</p>	\N	\N	CLASS	REALITY	\N	\N
cm1bg55f10013knwbforr1pde	Técnica Letal	<p>Você recebe um aumento de +2 na margem de ameaça com todos os seus ataques corpo a corpo.</p>	\N	{"{\\"type\\": \\"MARGEM_DE_CRITICO\\", \\"upgradeValue\\": 2}"}	SUBCLASS	REALITY	\N	\N
cm1bg5u690014knwbv0yo3wbz	Revidar	<p>Sempre que bloquear um ataque, você pode gastar uma reação e 2 PE para fazer um ataque corpo a corpo no inimigo que o atacou.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bg69z80015knwbavyay2zw	Força Opressora	<p>Quando acerta um ataque corpo a corpo, você pode gastar 1 PE para realizar uma manobra derrubar ou empurrar contra o alvo do ataque como ação livre. Se escolher empurrar, recebe um bônus de +5 para cada 10 pontos de dano que causou no alvo. Se escolher derrubar e vencer no teste oposto, você pode gastar 1 PE para fazer um ataque adicional contra o alvo caído.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bg6jw50016knwbpxevoa1k	Potência Máxima	<p>Quando usa seu Ataque Especial com armas corpo a corpo, todos os bônus numéricos são dobrados. Por exemplo, se usar 5 PE para receber +5 no ataque e +15 no dano, você recebe +10 no ataque e +30 no dano.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bg8yip0017knwb9a86ftbs	Ataque Furtivo	<p>Você sabe atingir os pontos vitais de um inimigo distraído. Uma vez por rodada, quando atinge um alvo desprevenido com um ataque corpo a corpo ou em alcance curto, ou um alvo que você esteja flanqueando, você pode gastar 1 PE para causar +1d6 pontos de dano do mesmo tipo da arma. Em NEX 40% o dano adicional aumenta para +2d6, em NEX 65% aumenta para +3d6 e em NEX 99% aumenta para +4d6.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bgad3a0018knwblw7ce5ty	Gatuno	<p>Você recebe +5 em Atletismo e Crime e pode percorrer seu deslocamento normal quando se esconder sem penalidade (veja a perícia Furtividade).</p>	\N	{"{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 5, \\"upgradeTarget\\": \\"Crime\\"}","{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 5, \\"upgradeTarget\\": \\"Atletismo\\"}"}	SUBCLASS	REALITY	\N	\N
cm1bgappw0019knwbkx5f7drn	Assassinar	<p>Você pode gastar uma ação de movimento e 3 PE para analisar um alvo em alcance curto. Até o fim de seu próximo turno, seu primeiro Ataque Furtivo que causar dano a ele tem seus dados de dano extras dessa habilidade dobrados. Além disso, se sofrer dano de seu ataque, o alvo fica inconsciente ou morrendo, à sua escolha (Fortitude DT Agi evita).</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bgb2ow001aknwb944fcpfz	Sombra Fugaz	<p>Quando faz um teste de Furtividade após atacar ou fazer outra ação chamativa, você pode gastar 3 PE para não sofrer a penalidade de –15 no teste.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bgd3la001bknwbdjtvg63u	Ampliar Ritual	<p>Quando lança um ritual, você pode gastar +2 PE para aumentar seu alcance em um passo (de curto para médio, de médio para longo ou de longo para extremo) ou dobrar sua área de efeito.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bgdsfd001cknwbdaol9ytc	Acelerar Ritual	<p>Uma vez por rodada, você pode aumentar o custo de um ritual em 4 PE para conjurá-lo como uma ação livre.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bgemhg001dknwbjoved7i7	Anular Ritual	<p>Quando for alvo de um ritual, você pode gastar uma quantidade de PE igual ao custo pago por esse ritual e fazer um teste oposto de Ocultismo contra o conjurador. Se vencer, você anula o ritual, cancelando todos os seus efeitos.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bgeytz001eknwb5pr0w5bf	Canalizar o Medo	<p>Você aprende o ritual Canalizar o Medo.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm1bghpuz001gknwbrzirzrqa	Ferramentas Favoritas	<p>Um item a sua escolha (exceto armas) conta como uma categoria abaixo (por exemplo, um item de categoria II conta como categoria I para você).</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm1bgin13001iknwb02cd504v	Ingrediente Secreto	<p>Em cenas de interlúdio, você pode fazer a ação alimentar-se para cozinhar um prato especial. Você, e todos os membros do grupo que fizeram a ação alimentar-se, recebem o benefício de dois pratos (caso o mesmo benefício seja escolhido duas vezes, seus efeitos se acumulam).</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm1bgje25001kknwb410wk3fv	Magnum Opus	<p>Você é famoso por uma de suas obras. Uma vez por missão, pode determinar que um personagem envolvido em uma cena de interação o reconheça. Você recebe +5 em testes de Presença e de perícias baseadas em Presença contra aquele personagem. A critério do mestre, pode receber esses bônus em outras situações nas quais seria reconhecido.</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm1bgjzt5001mknwbkim3ntpu	Técnica Medicinal	<p>Sempre que cura um personagem, você adiciona seu Intelecto no total de PV curados.</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm1bgkq35001oknwb6zqls2m3	Saber é Poder	<p>Quando faz um teste usando Intelecto, você pode gastar 2 PE para receber +5 nesse teste.</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm1bglsmp001qknwb0b47de1w	Vislumbres do Passado	<p>Uma vez por sessão, você pode fazer um teste de Intelecto (DT 10) para reconhecer pessoas ou lugares familiares, que tenha encontrado antes de perder a memória. Se passar, recebe 1d4 PE temporários e, a critério do mestre, uma informação útil.</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm1bgmjke001sknwbvuxg4nku	110%	<p>Quando faz um teste de perícia usando Força ou Agilidade (exceto Luta e Pontaria) você pode gastar 2 PE para receber +5 nesse teste.</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm1cftky30001rtj4n01adomh	Sangue de Ferro	<p>Seu sangue ferve e cria uma camada de proteção em seu corpo, recebe +2 PE por Nex</p>	\N	{"{\\"type\\": \\"VIDA_P_NEX\\", \\"upgradeValue\\": 2}"}	GENERAL	BLOOD	Imunidade a doenças e Fortitude +5	{"{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 5, \\"upgradeTarget\\": \\"Fortitude\\"}"}
cm1hxwcd30002p5u6f99vcy16	Poder de Pesadelos	<p>Descrição Padrão</p>	\N	{}	CUSTOM	REALITY	\N	{}
cm5hkq8rp00006apb9o0gccm5	A Favorita	<p>Escolha uma arma para ser sua favorita, como katana ou fuzil de assalto. A categoria da arma escolhida é reduzida em I.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkrqj800016apbcwrpgkq3	Técnica Secreta	<p>A categoria da arma favorita passa a ser reduzida em II. Quando faz um ataque com ela, você pode gastar 2 PE para executar um dos efeitos abaixo como parte do ataque. Você pode adicionar mais efeitos gastando +2 PE por efeito adicional. </p><ul><li> Amplo. O ataque pode atingir um alvo adicional em seu alcance e adjacente ao original (use o mesmo teste de ataque para ambos). </li><li> Destruidor. Aumenta o multiplicador de crítico da arma em +1</li></ul>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hksk3w00026apbcmcdl2hw	Técnica Sublime	<p>Você adiciona os seguintes efeitos à lista de sua Técnica Secreta: </p><ul><li>Letal. Aumenta a margem de ameaça em +2. Você pode escolher este efeito duas vezes para aumentar a margem de ameaça em +5. b</li><li>Perfurante. Ignora até 5 pontos de resistência a dano de qualquer tipo do alvo.</li></ul>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkt3el00036apbq4spyc4f	Máquina de Matar	<p>A categoria da arma favorita passa a ser reduzida em III, ela recebe +2 na margem de ameaça e seu dano aumenta em um dado do mesmo tipo.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hktw6k00046apbwr56pqnk	Casca Grossa	<p>Você recebe +1 PV para cada 5% de NEX e, quando faz um bloqueio, soma seu Vigor na resistência a dano recebida.</p>	\N	{"{\\"type\\": \\"VIDA_P_NEX\\", \\"upgradeValue\\": 1}"}	SUBCLASS	REALITY	\N	\N
cm5hkuox800056apb81oodk9y	Cai Dentro	<p>Sempre que um oponente em alcance curto ataca um de seus aliados, você pode gastar uma reação e 1 PE para fazer com que esse oponente faça um teste de Vontade (DT Vig). Se falhar, o oponente deve atacar você em vez de seu aliado. Este poder só funciona se você puder ser efetivamente atacado e estiver no alcance do ataque (por exemplo, adjacente a um oponente atacando em corpo a corpo ou dentro do alcance de uma arma de ataque à distância). Um oponente que passe no teste de Vontade não pode ser afetado por seu poder Cai Dentro até o final da cena.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkv69m00066apbe3uj442t	Duro de Matar	<p>Ao sofrer dano não paranormal, você pode gastar uma reação e 2 PE para reduzir esse dano à metade. Em NEX 85%, você pode usar esta habilidade para reduzir dano paranormal.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkvjyi00076apb5z6464fk	Inquebrável	<p>Enquanto estiver machucado, você recebe +5 na Defesa e resistência a dano 5. Enquanto estiver morrendo, em vez do normal, você não fica indefeso e ainda pode realizar ações. Você ainda segue as regras de morte normalmente</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkw49100086apb0f6iwu34	Eloquência	<p>Você pode usar uma ação completa e 1 PE por alvo em alcance curto para afetar outros personagens com sua fala. Faça um teste de Diplomacia, Enganação ou Intimidação contra a Vontade dos alvos. Se você vencer, os alvos ficam fascinados enquanto você se concentrar (uma ação padrão por rodada). Um alvo hostil ou que esteja envolvido em combate recebe +5 em seu teste de resistência e tem direito a um novo teste por rodada, sempre que você se concentrar Um personagem que passar no teste fica imune a este efeito por um dia.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkwr0h00096apbjd8jnjn8	Discurso Motivador	<p>Você pode gastar uma ação padrão e 4 PE para inspirar seus aliados com suas palavras. Você e todos os seus aliados em alcance curto ganham +1d20 em testes de perícia até o fim da cena. A partir de NEX 65%, você pode gastar 8 PE para fornecer um bônus total de +2d20.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkx5s9000a6apbasfrrgvh	Eu Conheço um Cara	<p>Uma vez por missão, você pode ativar sua rede de contatos para pedir um favor, como por exemplo trocar todo o equipamento do seu grupo (como se tivesse uma segunda fase de preparação de missão), conseguir um local de descanso ou mesmo ser resgatado de uma cena. O mestre tem a palavra final de quando é possível usar essa habilidade e quais favores podem ser obtidos.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkxkoa000b6apbiqnmubat	Truque de Mestre	<p>Acostumado a uma vida de fingimento e manipulação, você pode gastar 5 PE para simular o efeito de qualquer habilidade que você tenha visto um de seus aliados usar durante a cena. Você ignora os pré-requisitos da habilidade, mas ainda precisa pagar todos os seus custos, incluindo ações, PE e materiais, e ela usa os seus parâmetros de jogo, como se você estivesse usando a habilidade em questão.</p>	\N	{}	SUBCLASS	REALITY	\N	\N
cm5hkz485000d6apb0fck9bza	Sensitivo	<p>Você consegue sentir as emoções e intenções de outros personagens, como medo, raiva ou malícia, recebendo +5 em testes de Diplomacia, Intimidação e Intuição.</p>	\N	{"{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 5, \\"upgradeTarget\\": \\"Diplomacia\\"}","{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 5, \\"upgradeTarget\\": \\"Intimidação\\"}","{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 5, \\"upgradeTarget\\": \\"Intuição\\"}"}	GENERAL	KNOWLEDGE	Quando você faz um teste oposto usando  uma dessas perícias, o oponente sofre –1d20.	{}
cm5i9y1dk000111v8vbj4y1wo	Patrulha	<p>Você recebe +2 em Defesa</p>	\N	{"{\\"type\\": \\"DEFESA\\", \\"upgradeValue\\": 2}"}	ORIGIN	REALITY	\N	\N
cm5i9zds6000311v8f4ybv8q5	Posição de Combate	<p>No primeiro turno de cada cena de ação, você pode gastar 2 PE para receber uma ação de movimento adicional.</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm5ia5pp8000511v8w1wdr8db	Vitalidade Reforçada	<p>Você possui uma capacidade superior de suportar ferimentos. Você recebe +1 PV para cada 5% de NEX (ou para cada nível, se estiver usando a regra de nível de experiência) e +2 em Fortitude.</p>	Vigor 2	{"{\\"type\\": \\"VIDA_P_NEX\\", \\"upgradeValue\\": 1}","{\\"type\\": \\"PERICIA\\", \\"upgradeValue\\": 2, \\"upgradeTarget\\": \\"Fortitude\\"}"}	GENERAL	REALITY	\N	{}
cm5iaejay000611v86sv20smy	Primeira Impressão	<p>Você recebe +2d20 no primeiro teste de Diplomacia, Enganação, Intimidação ou Intuição que fizer em uma cena.</p>	\N	{}	CLASS	REALITY	\N	\N
cm5ialr96000911v85d170hcm	Escolhido pelo Outro Lado	<p>Você teve uma experiência paranormal e foi marcado pelo Outro Lado, absorvendo o conhecimento e poder necessários para realizar rituais. Você pode lançar rituais de 1º círculo. À medida que aumenta seu NEX, pode lançar rituais de círculos maiores (2º círculo em NEX 25%,&nbsp;3º círculo em NEX 55% e 4º círculo em NEX 85%). Você começa com três rituais de 1º círculo. Sempre que avança de NEX, aprende um ritual de qualquer círculo que possa lançar. Esses rituais não contam no seu limite de rituais conhecidos.</p>	\N	\N	CLASS	REALITY	\N	\N
cm5iam940000a11v8oh0jmmzm	Habilidade de Trilha	<p>Em NEX 10% você escolhe uma das trilhas de ocultista disponíveis e recebe o primeiro poder da trilha escolhida. Você recebe um novo poder da trilha escolhida respectivamente em NEX 40%, 65% e 99%.</p>	\N	\N	CLASS	REALITY	\N	\N
cm5iamiri000b11v8z3iidy73	Poder de Ocultista	<p>Em NEX 15%, você recebe um poder de ocultista à sua escolha. Você recebe um novo poder de ocultista em NEX 30% e a cada 15% de NEX subsequentes, conforme indicado na tabela. Veja a lista de poderes a seguir.</p>	\N	\N	CLASS	REALITY	\N	\N
cm5iamwhp000c11v8wvgxkdrl	Aumento de Atributo	<p>Em NEX 20%, e novamente em NEX 50%, 80% e 95%, aumente um atributo a sua escolha em +1. Você não pode aumentar um atributo além de 5 desta forma.</p>	\N	\N	CLASS	REALITY	\N	\N
cm5ianb2g000d11v8ogslnpeb	Grau de Treinamento	<p>Em NEX 35%, e novamente em NEX 70%, escolha um número de perícias treinadas igual a 3 + Int. Seu grau de treinamento nessas perícias aumenta em um (de treinado para veterano ou de veterano para expert).</p>	\N	\N	CLASS	REALITY	\N	\N
cm5ianigo000e11v8i3wjxnxe	Versatilidade	<p>Em NEX 50%, escolha entre receber um poder de ocultista ou o primeiro poder de uma trilha de ocultista que não a sua.</p>	\N	\N	CLASS	REALITY	\N	\N
cm5icnn6v0006xhvh31qjz9rp	O Crime Compensa	<p>No final de uma missão, escolha um item encontrado na missão. Em sua próxima missão, você pode incluir esse item em seu inventário sem que ele conte em seu limite de itens por patente.</p>	\N	{}	ORIGIN	REALITY	\N	\N
cm5icvvxv0007xhvhv5tdudy3	Golpe Pesado	<p>O dano de suas armas corpo a corpo aumenta em mais um dado do mesmo tipo.</p>	\N	{"{\\"type\\": \\"GLOBAL_MESMO_DADO_DE_DANO_MELEE\\"}"}	CLASS	REALITY	\N	\N
cm1bfvswi000nknwbpgiv43gf	Grau de Treinamento	<p>Em NEX 35%, e novamente em NEX 70%, escolha um número de perícias treinadas igual a 2 + Int. Seu grau de treinamento nessas perícias aumenta em um (de treinado para veterano ou de veterano para expert).</p>	\N	\N	CLASS	REALITY	\N	\N
\.


--
-- Data for Name: GeneralFeats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."GeneralFeats" (id, "featId") FROM stdin;
cm1cftkxz0000rtj4ii78jsv8	cm1cftky30001rtj4n01adomh
cm5hkz485000c6apb2meaj95o	cm5hkz485000d6apb0fck9bza
cm5ia5pp8000411v8j077si0b	cm5ia5pp8000511v8w1wdr8db
\.


--
-- Data for Name: Inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Inventory" (character_id, credit, alterations, "maxValue", patent) FROM stdin;
cm5ilwpxl0009b9sj0y59694c	MEDIUM	{}	15	OPERATOR
cm5iapljv000f11v8nsb6ew4j	MEDIUM	{}	2	OPERATOR
cm5ieylye0009xhvh61qjflda	MEDIUM	{}	5	OPERATOR
cm5jiyyz20001pa9ebsck83xh	MEDIUM	{}	15	OPERATOR
\.


--
-- Data for Name: InventorySlot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."InventorySlot" (id, inventory_id, equipment_id, uses, category, local_name, alterations, is_equipped, local_description, weight) FROM stdin;
cm5ild9380002b9sjkzod1n9o	cm5iapljv000f11v8nsb6ew4j	11	0	0	Mochila Militar	{}	t	<p>Uma mochila leve e de alta qualidade. Ela não usa nenhum espaço e aumenta sua capacidade de carga em 2 espaços.</p>	0
cm5ilzp93000bb9sjzjfa4vd2	cm5ilwpxl0009b9sj0y59694c	12	0	1	Granada de Fumaça	{}	t	<p>Para usar uma granada, você precisa empunhá-la e então gastar uma ação padrão para arremessá-la em um ponto à sua escolha em alcance médio. A granada afeta um raio de 6m a partir do ponto de impacto. O efeito que ela causa varia conforme o tipo de granada. Produz uma fumaça espessa e escura. Seres na área ficam cegos e sob camuflagem total. A fumaça dura 2 rodadas.</p>	0
cm5ilfeaj0005b9sje6vbhp0m	cm5iapljv000f11v8nsb6ew4j	8	0	2	Crucifixo Invertido	{}	t	<p>Crucifixo Invertido que emana uma aura estranha</p>	0
cm5im01k9000db9sjb333wz36	cm5ilwpxl0009b9sj0y59694c	16	0	1	Escudo	{}	t	<p>Um escudo medieval ou moderno, como aqueles usados por tropas de choque. Precisa ser empunhado em uma mão e fornece Defesa +2. Bônus na Defesa fornecido por um escudo acumula com o de uma proteção. Para efeitos de proficiência e penalidade por não proficiência, escudos contam como proteção pesada.</p>	0
cm5ils6w10006b9sj9x5aynt8	cm5iapljv000f11v8nsb6ew4j	13	2	0	Balas Curtas	{}	t	<p>Munição básica, usada em pistolas, revólveres e submetralhadoras. Um pacote de balas curtas dura duas cenas.</p>	0
cm5ilsiie0007b9sjpun1t6r1	cm5iapljv000f11v8nsb6ew4j	9	0	1	Revólver	{}	t	<p>A arma de fogo mais comum, e uma das mais confiáveis.</p>	0
cm5iltflj0008b9sjsienvgjz	cm5iapljv000f11v8nsb6ew4j	12	0	1	Granada de Fumaça	{}	t	<p>Para usar uma granada, você precisa empunhá-la e então gastar uma ação padrão para arremessá-la em um ponto à sua escolha em alcance médio. A granada afeta um raio de 6m a partir do ponto de impacto. O efeito que ela causa varia conforme o tipo de granada. Produz uma fumaça espessa e escura. Seres na área ficam cegos e sob camuflagem total. A fumaça dura 2 rodadas.</p>	0
cm5ilzhd3000ab9sjwg9g6n4l	cm5ilwpxl0009b9sj0y59694c	17	0	1	Machado	{}	t	<p>Uma ferramenta importante para lenhadores e bombeiros, um machado pode causar ferimentos terríveis.</p>	0
cm5im03nt000eb9sj8gj7uv0h	cm5ilwpxl0009b9sj0y59694c	15	0	1	Proteção Leve	{}	t	<p>Jaqueta de couro pesada ou um colete de kevlar. Essa proteção é tipicamente usada por seguranças e policiais.</p>	0
cm5im0pet000fb9sjboazupcq	cm5ilwpxl0009b9sj0y59694c	12	0	1	Granada de Fumaça	{}	t	<p>Para usar uma granada, você precisa empunhá-la e então gastar uma ação padrão para arremessá-la em um ponto à sua escolha em alcance médio. A granada afeta um raio de 6m a partir do ponto de impacto. O efeito que ela causa varia conforme o tipo de granada. Produz uma fumaça espessa e escura. Seres na área ficam cegos e sob camuflagem total. A fumaça dura 2 rodadas.</p>	0
cm5j26eks000b11umy5lx534y	cm5iapljv000f11v8nsb6ew4j	20	0	0	Faca Ritualística	{}	t	<p>Uma lâmina longa e afiada, como uma navalha, uma faca de churrasco ou uma faca militar (facas de cozinha pequenas causam apenas 1d3 pontos de dano). É uma arma ágil e pode ser arremessada.</p>	0
cm5j0krk6000211um4rxjcpiw	cm5ieylye0009xhvh61qjflda	14	1	1	Balas Longas	{}	t	<p>Maior e mais potente, esta munição é usada em fuzis e metralhadoras. Um pacote de balas longas dura uma cena.</p>	0
cm5j0kh87000111um5acwkjxg	cm5ieylye0009xhvh61qjflda	10	0	0	Kit de Medicina	{}	t	<p>Um conjunto de ferramentas necessárias para algumas perícias ou usos de perícias. Sem o kit, você sofre –5 no teste. Existe um kit de perícia para cada perícia que exige este item.</p>	0
cm5j149gn000411um4r6978rd	cm5iapljv000f11v8nsb6ew4j	18	0	0	Deck de Cartas Paranormais	{}	t	<p>Conjunto de cartas paranormais com poder ocultista contido.</p>	0
cm5ild5b50001b9sj2x2e43pv	cm5iapljv000f11v8nsb6ew4j	10	0	0	Kit de Enganação	{}	t	<p>Um conjunto de ferramentas necessárias para algumas perícias ou usos de perícias. Sem o kit, você sofre –5 no teste. Existe um kit de perícia para cada perícia que exige este item.</p>	0
cm5ilzy61000cb9sjlqkf38va	cm5ilwpxl0009b9sj0y59694c	10	0	0	Kit de Medicina	{}	t	<p>Um conjunto de ferramentas necessárias para algumas perícias ou usos de perícias. Sem o kit, você sofre –5 no teste. Existe um kit de perícia para cada perícia que exige este item.</p>	0
cm5j3ralf00005p0p2d69jw7h	cm5ieylye0009xhvh61qjflda	19	0	1	Fuzil de caça	{}	t	<p>Esta arma de fogo é bastante popular entre fazendeiros, caçadores e atiradores esportistas.</p>	0
cm5jj3l1m0002pa9ewdphec9h	cm5jiyyz20001pa9ebsck83xh	15	0	1	Proteção Leve	{}	t	<p>Jaqueta de couro pesada ou um colete de kevlar. Essa proteção é tipicamente usada por seguranças e policiais.</p>	0
\.


--
-- Data for Name: Modification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Modification" (id, name, type, element, "characterUpgrades", description, is_custom) FROM stdin;
\.


--
-- Data for Name: Notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Notes" (id, title, character_id, campaign_id, content) FROM stdin;
\.


--
-- Data for Name: Origin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Origin" (id, name, description, is_custom, feat_id, skills) FROM stdin;
cm1bghpuz001fknwbcape5u7o	Engenheiro	<p>Enquanto os acadêmicos estão preocupados com teorias, você colocar a mão na massa, seja como engenheiro profissional, seja como inventor de garagem. Provavelmente você criou algum dispositivo paranormal que chamou a atenção da Ordem.</p>	f	cm1bghpuz001gknwbrzirzrqa	{Profissão,Tecnologia}
cm1bgin13001hknwb1dh5lqnb	Chef	<p>Você é um cozinheiro amador ou profissional. Talvez trabalhasse em um restaurante, talvez simplesmente gostasse de cozinhar para a família e amigos. Como sua comida fez com que você se envolvesse com o paranormal? Ninguém sabe. Mas os outros agentes adoram quando você vai para a missão!</p>	f	cm1bgin13001iknwb02cd504v	{Fortitude,Profissão}
cm1bgje25001jknwb0be1qzbq	Artista	<p>Você era um ator, músico, escritor, dançarino, influenciador... Seu trabalho pode ter sido inspirado por uma experiência paranormal do passado e o que o público acha que é pura criatividade, a Ordem sabe que tem um lado mais sombrio.</p>	f	cm1bgje25001kknwb410wk3fv	{Artes,Enganação}
cm1bgjzt5001lknwbydoyib7g	Agente de Saúde	<p>Você era um profissional da saúde como um enfermeiro, farmacêutico, médico, psicólogo ou socorrista, treinado no atendimento e cuidado de pessoas. Você pode ter sido surpreendido por um evento paranormal durante o trabalho ou mesmo cuidado de um agente da Ordem em uma emergência, que ficou surpreso com o quão bem você lidou com a situação.</p>	f	cm1bgjzt5001mknwbkim3ntpu	{Intuição,Medicina}
cm1bgkq34001nknwbbjyyjucm	Acadêmico	<p>Você era um pesquisador ou professor universitário. De forma proposital ou não, seus estudos tocaram em assuntos misteriosos e chamaram a atenção da Ordo Realitas.</p>	f	cm1bgkq35001oknwb6zqls2m3	{Ciências,Investigação}
cm1bglsmp001pknwbql2d9fw1	Amnésico	<p>Você perdeu a maior parte da memória. Sabe apenas o próprio nome, ou nem isso. Sua amnésia pode ser resultado de um trauma paranormal ou mesmo de um ritual. Talvez você tenha sido vítima de cultistas? Talvez você tenha sido um cultista? Seja como for, hoje a Ordem é a única família que conhece. Quem sabe, cumprindo missões, você descubra algo sobre seu passado.</p>	f	cm1bglsmp001qknwb0b47de1w	{}
cm1bgmjke001rknwb56c0wsak	Atleta	<p>Você competia em um esporte individual ou por equipe, como natação ou futebol. Seu alto desempenho pode ser fruto de alguma influência paranormal que nem mesmo você conhecia ou você pode ter se envolvido em algum evento paranormal em uma de suas competições.</p>	f	cm1bgmjke001sknwbvuxg4nku	{Acrobacia,Atletismo}
cm5i9y1dk000011v8dfwtxcvz	Policial	<p>Você fez parte de uma força de segurança pública, civil ou militar. Em alguma patrulha ou chamado se deparou com um caso paranormal e sobreviveu para contar a história</p>	f	cm5i9y1dk000111v8vbj4y1wo	{Pontaria,Percepção}
cm5i9zds6000211v8aqqdm484	Mercenário	<p>Você é um soldado de aluguel, que trabalha sozinho ou como parte de alguma organização que vende serviços militares. Escoltas e assassinatos fizeram parte de sua rotina por tempo o suficiente para você se envolver em alguma situação com o paranormal.</p>	f	cm5i9zds6000311v8f4ybv8q5	{Iniciativa,Intimidação}
cm5icnn6v0005xhvh67p6pkdp	Criminoso	<p><span style="color: rgb(250, 250, 249);">Você vivia uma vida fora da lei, seja como mero batedor de carteiras, seja como membro de uma facção criminosa. Em algum momento, você se envolveu em um assunto da Ordem talvez tenha roubado um item amaldiçoado? A organização, por sua vez, achou melhor recrutar seus talentos do que ter você como um estorvo.</span></p>	f	cm5icnn6v0006xhvh31qjz9rp	{Crime,Furtividade}
\.


--
-- Data for Name: PlayerOnCampaign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PlayerOnCampaign" (campaign_id, player_id, joined_at) FROM stdin;
cm5hc4i6z00014p9wyqal4c7k	cm1bc46xx0000knwbt37wqtvi	2025-01-03 22:37:24.708
cm5hc4i6z00014p9wyqal4c7k	cm5bmno2k0000n92qg3024kzq	2025-01-04 11:01:49.611
cm5hc4i6z00014p9wyqal4c7k	cm5ieq8i70008xhvho01d3xkv	2025-01-04 16:40:34.281
cm5hc4i6z00014p9wyqal4c7k	cm5jis4km0000pa9ew5i0gk3s	2025-01-05 11:20:10.247
\.


--
-- Data for Name: Ritual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Ritual" (id, name, element, is_custom, "discentCastDescription", duration, "exectutionTime", "normalCastDescription", range, target, "trueCastDescription", type, "discentCost", "ritualLevel", "trueCost", "normalCost", resistence) FROM stdin;
cm1bgryld001uknwbjhewmpq9	Eletrocussão	ENERGY	f	<p>Muda o alvo para “área: linha de 30m”. Você dispara um poderoso raio que causa 6d6 pontos de dano de Energia em todos os seres e objetos livres na área. Requer 2º círculo.</p>	Instantânea	Padrão	<p>Você manifesta e dispara uma corrente elétrica contra o alvo, que sofre 3d6 pontos de dano de eletricidade e fica vulnerável por uma rodada. Se passar no teste de resistência, sofre apenas metade do dano e evita a condição. Se usado contra objetos eletrônicos, este ritual causa o dobro de dano e ignora resistência.</p>	SHORT	1 ser ou objeto	<p>Muda a área para “alvos escolhidos”. Em vez do normal, você dispara vários relâmpagos, um para cada alvo escolhido, causando 8d6 pontos de dano de Energia em cada. Requer 3º círculo.</p>	DAMAGE	2	1	5	1	Fortitude Parcial
cm1h5en9s000a12te7fbstxb5	Alterar Destino	ENERGY	f	\N	Instantanea	Padrão	<p>Você vislumbra seu futuro próximo, analisando milhões de possibilidades e escolhendo a melhor. Você recebe +15 em um teste de resistência ou na Defesa contra um ataque.</p>	SELF	Você	<p>Muda o alcance para “curto” e o alvo para “um aliado à sua escolha”</p>	EFFECT	0	4	5	9	Nenhuma
cm1h5mbgq000c12teo5oqs450	Âncora Temporal	DEATH	f	\N	Instantanea	Padrão	<p>Uma aura espiralada surge sobre o alvo. No início de cada turno dele, ele deve fazer um teste de Vontade. Se falhar, não poderá se deslocar naquele turno (ele ainda pode agir, só não pode se deslocar). Se o alvo passar nesse teste dois turnos seguidos o efeito termina.</p>	MEDIUM	Você	<p>Muda o alvo para “seres à sua escolha”. Requer 4º círculo</p>	EFFECT	0	4	4	9	Nenhuma
cm1h5py6b000f12tevm7nhzsq	Decadência	DEATH	f	<p>muda a resistência para “nenhuma” e o dano para 3d8+3. Como parte da execução do ritual, você transfere as espirais para uma arma e faz um ataque corpo a corpo contra o alvo com esta arma. Se acertar, causa o dano da arma e do ritual, somados.</p>	Instantanea	Padrão	<p>Espirais de trevas envolvem sua mão e definham o alvo, que sofre 2d8+2 pontos de dano de Morte.</p>	TOUCH	1 ser	<p>&nbsp;muda o alcance para “pessoal” o alvo para “área: explosão com 6m de raio” e o dano para 8d8+8. As espirais afetam todos os seres na área. Requer 3º círculo.</p>	DAMAGE	2	1	5	1	Fortitude reduz à metade
cm5j19qq2000511umm0dq0rl6	Enfeitiçar	KNOWLEDGE	f	<p>Em vez do normal, você sugere uma ação para o alvo e ele obedece. A sugestão deve ser feita de modo que pareça aceitável, a critério do mestre. Pedir que o alvo atire em seu companheiro, por exemplo, dissipa o efeito. Já sugerir a um guarda que descanse um pouco, de modo que você e seus aliados passem por ele, é aceitável. Quando o alvo executa a ação, o efeito termina. Você pode determinar uma condição específica para a sugestão: por exemplo, que o policial prenda a próxima pessoa de casaco verde que ele encontrar. Requer 2º círculo.</p>	Cena	Padrão	<p>Este ritual torna o alvo prestativo (veja a página 45). Ele não fica sob seu controle, mas percebe suas palavras e ações da maneira mais favorável possível. Você recebe um bônus de +10 em testes de Diplomacia com ele. Um alvo hostil ou que esteja envolvido em combate recebe +5 em seu teste de resistência. Se você ou seus aliados tomarem qualquer ação hostil contra o alvo, o efeito é dissipado e o alvo retorna à atitude que tinha antes (ou piorada, de acordo com o mestre).&nbsp;</p>	SHORT	1 pessoa	<p>Afeta todos os alvos dentro do alcance. Requer 3º círculo.</p>	EFFECT	2	1	5	1	Vontade anula
cm5j1cgnx000611um7acukdm2	Ouvir Sussurros	KNOWLEDGE	f	<p>Muda a execução para 1 minuto. Em vez do normal, você pode consultar os ecos fazendo uma pergunta sobre um evento que poderá acontecer até um dia no futuro. O mestre rola a chance de falha; com um resultado de 2 a 6, você recebe uma resposta, desde uma simples frase até uma profecia ou enigma. Em geral, este uso oferece pistas, indicando um caminho a tomar para descobrir a resposta que se procura. Numa falha você não recebe resposta alguma. Requer 2º círculo.</p>	Instantânea	Completa	<p>O ritual conecta você com os sussurros, memórias ecoadas pelo Outro Lado, que você pode consultar para receber conhecimento proibido em relação a uma ação que tomará em breve. Ao usar este ritual, faça uma pergunta sobre um evento que você está prestes a fazer (na mesma cena) que possa ser respondida com “sim” ou “não”. O mestre rola 1d6 em segredo; com um resultado de 2 a 6, o ritual funciona e você recebe sua resposta, que pode ser “sim”, “não” ou “sim e não”. Com um resultado 1, o ritual falha e oferece o resultado “não”. Não há como saber se esse resultado foi dado porque o ritual falhou ou não. Lançar este ritual múltiplas vezes sobre o mesmo assunto gera sempre o primeiro resultado. Por exemplo, você está prestes a entrar em um prédio que pode ser o esconderijo de um cultista. Se você perguntar para os sussurros se o cultista está mesmo nesse local, a resposta pode ser “sim” (ele está no prédio), “não” (ele não está no prédio) ou “sim e não” (ele está no prédio, mas usou um ritual para se esconder seu corpo físico em uma dimensão do Outro Lado...). Isso é útil para saber se você deve (ou não) gastar recursos para um possível combate.</p>	SELF	Você	<p>Muda a execução para 10 minutos e a duração para 5 rodadas. Em vez do normal, você consulta os ecos, podendo fazer uma pergunta por rodada, desde que ela possa ser respondida com “sim”, “não” ou “ninguém sabe”. O mestre rola a chance de falha para cada pergunta. Em caso de falha, a resposta também é “ninguém sabe”. Requer 3º círculo.</p>	EFFECT	2	1	5	1	Nenhuma
cm5j1f7u9000711um2j4gis5o	Tecer Ilusões	KNOWLEDGE	f	<p>Muda o efeito para até 8 cubos de 1,5m e a duração para sustentada. Você pode criar ilusões de imagem e sons combinados, e pode criar sons complexos, odores e sensações térmicas. Também pode criar sensações táteis, como texturas; objetos ainda atravessam a ilusão, mas seres não conseguem atravessá-la sem passar em um teste de Vontade. A cada rodada, você pode usar uma ação livre para mover a imagem ou alterar o som, como aumentar o volume ou fazer com que pareça se afastar ou se aproximar, ainda dentro dos limites do efeito. Você pode, por exemplo, criar a ilusão de um fantasma que anda pela sala, controlando seus movimentos. A ilusão ainda é incapaz de causar ou sofrer dano. Quando você para de sustentar o ritual, a imagem ou som persistem por mais uma rodada antes do ritual se dissipar. Requer 2º círculo.</p>	Cena	Padrão	<p>Este ritual cria uma ilusão visual (uma pessoa, uma parede...) ou sonora (um grito de socorro, um uivo assustador...). O ritual cria apenas imagens ou sons simples, com volume equivalente à voz de uma pessoa para cada cubo de 1,5m no efeito. Não é possível criar cheiros, texturas ou temperaturas, nem sons complexos, como uma música ou diálogo. Seres e objetos atravessam uma ilusão sem sofrer dano, mas o ritual pode, por exemplo, esconder uma armadilha ou emboscada. A ilusão é dissipada se você sair do alcance.</p>	MEDIUM	Ilusão que se estende a até 4 cubos de 1,5m	<p>Você cria a ilusão de um perigo mortal. Quando o ritual é conjurado, e no início de cada um de seus turnos, um alvo interagindo com a ilusão deve fazer um teste de Vontade; se falhar, acredita que a ilusão é real e sofre 6d6 pontos de dano de Conhecimento. O alvo racionaliza o efeito sempre que falha no teste (por exemplo, acredita que o mesmo teto pode cair sobre ele várias vezes). Se um alvo passar em dois testes de Vontade seguidos, o efeito é anulado para ele. Requer 3º círculo</p>	EFFECT	2	1	5	1	Vontade desacredita
cm5j1i8sf000811um31vh5nk2	Terceiro Olho	KNOWLEDGE	f	<p>Muda a duração para 1 dia.&nbsp;</p>	Cena	Padrão	<p>Seus olhos se enchem de sigilos e você passa a enxergar auras paranormais em alcance longo. Rituais, itens amaldiçoados e criaturas emitem auras. Você sabe o elemento da aura e seu poder aproximado — rituais de 1º círculo e criaturas de VD até 80 emitem uma aura fraca; rituais de 2º e 3º círculos e criaturas de VD entre 81 e 280 emitem uma aura moderada, e rituais de 4º círculo e criaturas de VD 281 ou maior emitem uma aura poderosa. </p><p><br></p><p>Além disso, você pode gastar uma ação de movimento para descobrir se um ser que possa ver em alcance médio tem poderes paranormais ou se é capaz de conjurar rituais e de quais elementos.</p>	SELF	Você	<p>Também pode enxergar objetos e seres invisíveis, que aparecem como formas translúcidas.&nbsp;</p>	EFFECT	2	1	5	1	
cm5j1kece000911umr28219vr	Embaralhar	ENERGY	f	<p>Muda o número de cópias para 5 (e o bônus na Defesa para +10). Requer 2º círculo.</p>	Cena	Padrão	<p>Você cria três cópias ilusórias suas, como hologramas extremamente realistas. As cópias ficam ao seu redor e imitam suas ações, tornando difícil para um inimigo saber quem é o verdadeiro. Você recebe +6 na Defesa. Cada vez que um ataque contra você erra, uma das imagens desaparece e o bônus na Defesa diminui em 2. Um oponente deve ver as cópias para ser confundido. Se você estiver invisível, ou o atacante fechar os olhos, você não recebe o bônus (mas o atacante sofre as penalidades normais por não enxergar).</p>	SELF	Você	<p>Muda o número de cópias para 8 (e o bônus na Defesa para +16). Além do normal, toda vez que uma cópia é destruída, emite um clarão de luz. O ser que destruiu a cópia fica ofuscada por uma rodada. Requer 3º círculo.</p>	EFFECT	2	1	5	1	
cm5j1npzn000a11umnpb5p836	Distorcer Aparência	BLOOD	f	<p>Muda o alcance para “curto” e o alvo para “1 ser”. Um alvo involuntária pode anular o efeito com um teste de Vontade.</p>	Cena	Padrão	<p>Você modifica sua aparência de modo a parecer outra pessoa. Isso inclui altura, peso, tom de pele, cor de cabelo, timbre de voz, impressão digital, córnea etc. Você recebe +10 em testes de Enganação para 131 disfarce, mas não recebe habilidades da nova forma nem modifica suas demais estatísticas.</p>	SELF	Você	<p>Como em Discente, mas muda o alvo para “seres escolhidos”. Requer 3º círculo.</p>	EFFECT	2	1	5	1	Vontade desacredita
\.


--
-- Data for Name: RitualCondition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RitualCondition" (ritual_id, condition_id) FROM stdin;
cm1bgryld001uknwbjhewmpq9	cm1bgrn7x001tknwbxj0bvf3m
\.


--
-- Data for Name: Skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Skill" (name, atribute, description, only_trained, carry_peanalty, needs_kit, is_custom, campaign_id) FROM stdin;
Acrobacia	DEXTERITY	<p><strong>Você consegue fazer proezas acrobáticas.</strong></p><p><br></p><p><strong>Amortecer Queda (Veterano, DT 15)</strong></p><p>Quando cai, você pode gastar uma reação e fazer um teste de Acrobacia para reduzir o dano. Se passar, reduz o dano da queda em 1d6, mais 1d6 para cada 5 pontos pelos quais o resultado do teste exceder a DT. Se reduzir o dano a zero, você cai de pé.</p><p><br></p><p><strong>Equilíbrio</strong></p><p>Se estiver andando por superfícies precárias, você precisa fazer testes de Acrobacia para não cair. Cada ação de movimento exige um teste. Se passar, você avança metade do seu deslocamento. Se falhar, não avança. Se falhar por 5 ou mais, cai. A DT é 10 para piso escorregadio, 15 para uma superfície estreita (como o topo de um muro) e 20 para uma superfície muito estreita (como uma corda esticada). Você pode sofrer -1d20 no teste para avançar seu deslocamento total. Quando está se equilibrando, você fica desprevenido e, se sofrer dano, deve fazer um novo teste de Acrobacia; se falhar, cai.</p><p><br></p><p><strong>Escapar</strong></p><p>Você pode escapar de amarras. A DT é igual ao resultado do teste de Agilidade de quem o amarrou +10, se você estiver preso por cordas, ou 30, se você estiver preso por algemas. Este uso gasta uma ação completa.</p><p><br></p><p><strong>Levantar-se Rapidamente (Treinado, DT 20)</strong></p><p>Se estiver caído, você pode fazer um teste de Acrobacia para ficar de pé. Você precisa ter uma ação de movimento disponível. Se passar no teste, se levanta como uma ação livre. Se falhar, gasta sua ação de movimento, mas continua caído.</p><p><br></p><p><strong>Passar por Espaço Apertado (Treinado, DT 25)</strong></p><p>Você pode se espremer por lugares estreitos, por onde apenas sua cabeça normalmente passaria. Você gasta uma ação completa e avança metade do deslocamento.</p><p><br></p><p><strong>Passar por Inimigo</strong></p><p>Você pode atravessar um espaço ocupado por um inimigo como parte de seu movimento. Faça um teste de Acrobacia oposto ao teste de Acrobacia, Iniciativa ou Luta do oponente (o que for melhor). Se você passar, atravessa o espaço; se falhar, não atravessa e sua ação de movimento termina. Um espaço ocupado por um inimigo conta como terreno difícil.</p><p><br></p>	f	t	f	f	\N
Adestramento	PRESENCE	<p>Você sabe lidar com animais.</p><p><br></p><p><strong>Acalmar Animal (DT 25)</strong></p><p>Você acalma um animal nervoso ou agressivo. Isso permite a você controlar um touro furioso ou convencer um cão de guarda a não atacá-lo. Este uso gasta uma ação completa.</p><p><br></p><p><strong>Cavalgar</strong></p><p>Você pode andar a cavalo. Montar exige uma ação de movimento, mas você pode montar como uma ação livre com um teste de Adestramento contra DT 20 (porém, se falhar por 5 ou mais, cai no chão). Andar em terreno plano não exige testes, mas passar por obstáculos ou andar em terreno acidentado, sim. A DT é 15 para obstáculos pequenos ou terreno ruim (estrada esburacada) e 20 para obstáculos grandes ou terreno muito ruim (floresta à noite). Se você falhar, cai da montaria e sofre 1d6 pontos de dano. Cavalgar é parte de seu movimento e não exige uma ação.</p><p><br></p><p>Se estiver a cavalo, você pode galopar. Gaste uma ação completa e faça um teste de Adestramento. Você avança um número de quadrados de 1,5m igual ao seu deslocamento (modificado pela montaria) mais o resultado do teste. Você só pode galopar em linha reta e não pode galopar em terreno difícil.</p><p><br></p><p><strong>Manejar Animal (DT 15)</strong></p><p>Você faz um animal realizar uma tarefa para a qual foi treinado. Isso permite usar Adestramento como Pilotagem para veículos de tração animal, como carroças. Este uso gasta uma ação de movimento.</p>	t	f	f	f	\N
Artes	PRESENCE	<p>Você sabe se expressar com diversas formas de arte, como música, dança, escrita, pintura, atuação e outras.</p><p><br></p><p><strong>Impressionar</strong></p><p>Faça um teste de Artes oposto pelo teste de Vontade de quem você está tentando impressionar. Se você passar, recebe +2 em testes de perícia baseados em Presença contra essa pessoa na mesma cena. Se falhar, sofre -2 nesses testes e não pode tentar de novo na mesma cena. Se estiver tentando impressionar mais de uma pessoa, o mestre faz apenas um teste pela plateia toda, usando o melhor bônus. Este uso leva de alguns minutos (música ou dança) até algumas horas (apresentação de teatro).</p>	t	f	f	f	\N
Atletismo	STRENGTH	<p>Você pode realizar façanhas atléticas.</p><p><br></p><p><strong>Corrida</strong></p><p>Você pode gastar uma ação completa para fazer um teste de Atletismo. Avance um número de quadrados (1,5m cada) igual ao seu deslocamento mais o resultado do teste. Se tem deslocamento de 9m e tirar 15 no teste, avançará 21 quadrados. Só pode correr em linha reta e não em terreno difícil. Pode correr por um número de rodadas igual ao seu Vigor. Após isso, faça um teste de Fortitude (DT 5 + 5 por teste anterior) por rodada. Se falhar, fica fatigado.</p><p><br></p><p><strong>Escalar</strong></p><p>Gaste uma ação de movimento e faça um teste de Atletismo. Se passar, avança metade do seu deslocamento. Se falhar, não avança. Se falhar por 5 ou mais, você cai. A DT é 10 para superfícies com apoios para os pés e mãos (como um barranco com raízes), 15 para um portão ou árvore, 20 para um muro ou parede com reentrâncias e 25 para um muro ou parede liso. Você pode sofrer –1d20 no teste para avançar seu deslocamento total. Quando está escalando, você fica desprevenido, e se sofrer dano, deve fazer um novo teste de Atletismo; se falhar, você cai.</p><p><br></p><p><strong>Natação</strong></p><p>Se estiver na água, gaste uma ação de movimento e faça um teste de Atletismo por rodada para não afundar. A DT é 10 para água calma, 15 para agitada e 20 ou mais para tempestuosa. Se passar, você pode avançar metade do seu deslocamento. Se falhar, boia, mas não avança. Se falhar por 5 ou mais, você afunda. Se quiser avançar mais, pode gastar uma segunda ação de movimento para outro teste de Atletismo. Se submerso, você pode prender a respiração por um número de rodadas igual ao seu Vigor. Após isso, teste Fortitude (DT 5 + 5 por teste anterior). Se falhar, começa a se afogar, ficando com 0 PVs e morrendo.</p><p><br></p><p><strong>Saltar</strong></p><p>Você pode pular sobre buracos ou obstáculos. Para salto em distância, a DT é 5 por quadrado de 1,5m (DT 10 para 3m, 15 para 4,5m, 20 para 6m e assim por diante). Para salto em altura, a DT é 15 por quadrado de 1,5m (DT 30 para 3m). Deve ter pelo menos 6m para pegar impulso (sem essa distância, a DT aumenta em +5). Saltar faz parte do movimento e não exige uma ação.</p>	f	f	f	f	\N
Atualidades	INTELLIGENCE	<p>Você é um conhecedor de assuntos gerais, como política, esporte e entretenimento, e pode responder dúvidas relativas a esses assuntos. A DT é 15 para informações comuns, como o nome do autor de um livro, 20 para informações específicas, como a história do fundador de uma empresa, e 25 para informações quase desconhecidas, como uma lenda urbana já esquecida.</p>	f	f	f	f	\N
Ciências	INTELLIGENCE	<p>Você estudou diversos campos científicos, como matemática, física, química e biologia, e pode responder dúvidas relativas a esses assuntos. Questões simples, como a composição química de uma substância conhecida, não exigem teste. Questões complexas, como detalhes sobre o funcionamento de um procedimento científico específico, exigem um teste contra DT 20. Por fim, questões envolvendo campos experimentais, como avaliar a capacidade de proteção de uma liga metálica recém-criada, exigem um teste contra DT 30.</p><p><br></p>	t	f	f	f	\N
Crime	DEXTERITY	<p>Você sabe exercer atividades ilícitas.</p><p><br></p><p><strong>Arrombar</strong></p><p>Você abre uma fechadura trancada. A DT é 20 para fechaduras comuns (porta de um apartamento), 25 para fechaduras reforçadas (porta de uma loja) e 30 para fechaduras avançadas (cofre de um banco). Este uso gasta uma ação completa.</p><p><br></p><p><strong>Furto (DT 20)</strong></p><p>Você pega um objeto de outra pessoa (ou planta um objeto nas posses dela). Gaste uma ação padrão e faça um teste de Crime. Se passar, você pega (ou coloca) o que queria. A vítima tem direito a um teste de Percepção (DT igual ao resultado de seu teste de Crime). Se passar, ela percebe sua tentativa, tenha você conseguido ou não.</p><p><br></p><p><strong>Ocultar</strong></p><p>Você esconde um objeto em você mesmo. Gaste uma ação padrão e faça um teste de Crime oposto ao teste de Percepção de qualquer um que possa vê-lo. Se uma pessoa revistar você, ela recebe +10 no teste de Percepção.</p><p><br></p><p><strong>Sabotar (Veterano)</strong></p><p>Você desabilita um dispositivo. Uma ação simples, como desativar um alarme, tem DT 20. Uma ação complexa, como sabotar uma pistola para que exploda quando disparada, tem DT 30. Se você falhar por 5 ou mais, algo sai errado (o alarme dispara, você acha que a arma está sabotada, mas na verdade ainda funciona...). Este uso gasta 1d4+1 ações completas. Você pode sofrer uma penalidade de –1d20 em seu teste para fazê-lo como uma ação completa.</p><p><br></p><p>Os usos arrombar e sabotar exigem um kit. Sem ele, você sofre –5 no teste.</p><p><br></p>	t	t	t	f	\N
Luta	STRENGTH	<p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você usa Luta para fazer ataques corpo a corpo. A DT é a Defesa do alvo. Se você acertar, causa dano de acordo com a arma utilizada.</span></p>	f	f	f	f	\N
Diplomacia	PRESENCE	<p>Você convence pessoas com lábia e argumentação.</p><p><br></p><p><strong>Acalmar (Treinado, DT 20)</strong></p><p>Você estabiliza um personagem adjacente que esteja enlouquecendo, fazendo com que ele fique com Sanidade 1. A DT aumenta em +5 para cada vez que ele tiver sido acalmado na cena. Este uso gasta uma ação padrão.</p><p><br></p><p><strong>Mudar Atitude</strong></p><p>Você muda a categoria de atitude de um NPC em relação a você ou a outra pessoa (veja a página ao lado para a explicação das categorias de atitude). Faça um teste de Diplomacia oposto pelo teste de Vontade do alvo. Se você passar, muda a atitude dele em uma categoria para cima ou para baixo, à sua escolha. Se passar por 10 ou mais, muda a atitude em até duas categorias. Se falhar por 5 ou mais, a atitude do alvo muda uma categoria na direção oposta. Este uso gasta um minuto. Você pode sofrer -2d20 no teste para fazê-lo como uma ação completa (para evitar uma briga, por exemplo). Você só pode mudar a atitude de uma mesma pessoa uma vez por dia. ( Consulte a lista abaixo )</p><p><br></p><p><strong>Persuasão (DT 20)</strong></p><p>Você convence uma pessoa a fazer alguma coisa, como responder a uma pergunta ou prestar um favor. Se essa coisa for custosa (como emprestar um carro), você sofre -5 em seu teste. Se for perigosa (como cometer um crime), você sofre -10 ou falha automaticamente. De acordo com o mestre, seu teste pode ser oposto ao teste de Vontade da pessoa. Este uso gasta um minuto ou mais, de acordo com o mestre.</p><p><br></p><p><strong><em>CATEGORIAS DE ATITUDE </em></strong></p><p>Todo NPC possui uma categoria de atitude em relação a cada personagem. Por padrão, a categoria inicial é “indiferente”, mas o mestre possa estipular outra se quiser. As categorias são descritas a seguir. I</p><ul><li>Prestativo. Adora o personagem. Você recebe +5 em testes de persuasão contra pessoas prestativas. I Amistoso. Gosta do personagem. Pode ajudá-lo e fazer pequenos favores, mas dificilmente se arriscará por ele.</li><li> Indiferente. Não gosta nem desgosta do personagem. Vai tratá-lo como socialmente esperado.</li><li>Inamistoso. Não vai com a cara do personagem contra.  Você sofre –5 em testes de persuasão <span style="color: rgb(250, 250, 249);">pessoas inamistosas</span> .</li><li>Hostil. Odeia o personagem e vai tentar prejudicá-lo — pode falar mal dele, roubar suas coisas ou mesmo atacá-lo! Você falha automaticamente em testes de persuasão contra pessoas hostis.</li></ul>	f	f	f	f	\N
Enganação	PRESENCE	<p>Você manipula pessoas com blefes e trapaças.</p><p><br></p><p><strong>Disfarce (Treinado)</strong></p><p>Você muda sua aparência ou a de outra pessoa. Faça um teste de Enganação oposto pelo teste de Percepção de quem prestar atenção no disfarçado. Se você passar, a pessoa acredita no disfarce; caso contrário, percebe que há algo errado. Se o disfarce é de uma pessoa específica, aqueles que conhecem essa pessoa recebem +10 no teste de Percepção. Um disfarce exige pelo menos dez minutos e um kit. Sem ele, você sofre -5 no teste.</p><p><br></p><p><strong>Falsificação (Veterano)</strong></p><p>Você falsifica um documento. Faça um teste de Enganação oposto pelo teste de Percepção de quem examinar o documento. Se você passar, a pessoa acredita que ele é válido; caso contrário, percebe que é falso. Se o documento é muito complexo, ou inclui uma assinatura ou carimbo específico, você sofre -2d20 no teste.</p><p><br></p><p><strong>Fintar (Treinado)</strong></p><p>Você pode gastar uma ação padrão e fazer um teste de Enganação oposto a um teste de Reflexos de um ser em alcance curto. Se você passar, ele fica desprevenido contra seu próximo ataque, se realizado até o fim de seu próximo turno.</p><p><br></p><p><strong>Insinuação (DT 20)</strong></p><p>Você fala algo para alguém sem que outras pessoas entendam do que você está falando. Se você passar, o receptor entende sua mensagem. Se falhar por 5 ou mais, entende algo diferente do que você queria. Outras pessoas podem fazer um teste de Intuição oposto ao seu teste de Enganação. Se passarem, entendem o que você está dizendo.</p><p><br></p><p><strong>Intriga (DT 20)</strong></p><p>Você espalha uma fofoca. Por exemplo, pode dizer que o dono do bar está aguando a cerveja para enfurecer o povo contra ele. Intrigas muito improváveis (convencer o povo que o delegado é um ET que está abduzindo as pessoas) têm DT 30. Este uso exige pelo menos um dia, mas pode levar mais tempo, de acordo com o mestre. Uma pessoa pode investigar a fonte da fofoca e chegar até você. Isso exige um teste de Investigação por parte dela, com DT igual ao resultado do seu teste para a intriga.</p><p><br></p><p><strong>Mentir</strong></p><p>Você faz uma pessoa acreditar em algo que não é verdade. Seu teste é oposto pelo teste de Intuição da vítima. Mentiras muito implausíveis impõem uma penalidade de -2d20 em seu teste (“Por que estou com o crachá do chefe de segurança? Ora, porque ele deixou cair e estou indo devolver!”).</p>	f	f	t	f	\N
Fortitude	VITALITY	<p>Você usa esta perícia para testes de resistência contra efeitos que exigem vitalidade, como doenças e venenos. A DT é determinada pelo efeito. Você também usa Fortitude para manter seu fôlego quando está correndo ou sem respirar. A DT é 5 +5 por teste anterior (veja a perícia Atletismo para mais detalhes).</p>	f	f	f	f	\N
Furtividade	DEXTERITY	<p>Você sabe ser discreto e sorrateiro.</p><p><br></p><p><strong>Esconder-se</strong></p><p>Faça um teste de Furtividade oposto pelos testes de Percepção de qualquer um que possa notá-lo. Todos que falharem não conseguem percebê-lo (você tem camuflagem total contra eles). Esconder-se é uma ação livre que você só pode fazer no final do seu turno e apenas se terminar seu turno em um lugar onde seja possível se esconder (atrás de uma porta, num quarto escuro, numa mata densa, no meio de uma multidão...). Se tiver se movido durante o turno, você sofre –1d20 no teste (você pode se mover à metade do deslocamento normal para não sofrer essa penalidade). Se tiver atacado ou feito outra ação muito chamativa, sofre –3d20.</p><p><br></p><p><strong>Seguir</strong></p><p>Faça um teste de Furtividade oposto ao teste de Percepção da pessoa sendo seguida. Você sofre –5 se estiver em um lugar sem esconderijos ou sem movimento, como um descampado ou rua deserta. A vítima recebe +5 em seu teste de Percepção se estiver tomando precauções para não ser seguida (como olhar para trás de vez em quando). Se você passar, segue a pessoa até ela chegar ao seu destino. Se falhar, a pessoa o percebe na metade do caminho.</p>	f	t	f	f	\N
Iniciativa	DEXTERITY	<p>Esta perícia determina sua velocidade de reação. Quando uma cena de ação começa, cada personagem envolvido faz um teste de Iniciativa. Eles então agem em ordem decrescente dos resultados.</p><p><br></p>	f	f	f	f	\N
Intimidação	PRESENCE	<p>Você pode assustar ou coagir outras pessoas. Todos os usos de Intimidação são efeitos de medo.</p><p><br></p><p><strong>Assustar (Treinado)</strong></p><p>Gaste uma ação padrão e faça um teste de Intimidação oposto pelo teste de Vontade de uma pessoa em alcance curto. Se você passar, ela fica abalada pelo resto da cena (não cumulativo). Se você passar por 10 ou mais, ela fica apavorada por uma rodada e então abalada pelo resto da cena.</p><p><br></p><p><strong>Coagir</strong></p><p>Faça um teste de Intimidação oposto pelo teste de Vontade de uma pessoa adjacente. Se você passar, ela obedece a uma ordem sua (como fazer uma pequena tarefa, deixar que você passe por um lugar que ela estava protegendo, etc.). Se você mandar a pessoa fazer algo perigoso ou que vá contra a natureza dela, ela recebe +5 no teste ou passa automaticamente. Este uso gasta um minuto ou mais, de acordo com o mestre, e deixa a pessoa hostil contra você.</p>	f	f	f	f	\N
Intuição	PRESENCE	<p>Esta perícia mede sua empatia e “sexto sentido”.</p><p><br></p><p><strong>Perceber Mentira</strong></p><p>Você descobre se alguém está mentindo (veja a perícia Enganação).</p><p><br></p><p><strong>Pressentimento (Treinado, DT 20)</strong></p><p>Você analisa uma pessoa, para ter uma ideia de sua índole ou caráter, ou uma situação, para perceber qualquer fato estranho (por exemplo, se os habitantes de uma cidadezinha estão agindo de forma esquisita). Este uso apenas indica se há algo anormal; para descobrir a causa, veja a perícia Investigação.</p>	f	f	f	f	\N
Investigação	INTELLIGENCE	<p>Você sabe como descobrir pistas e informações.</p><p><br></p><p><strong>Interrogar</strong></p><p>Você descobre informações perguntando ou indo para um lugar movimentado e mantendo os ouvidos atentos. Informações gerais (“Quem é o dono desse bar?”) não exigem teste. Informações restritas, que poucas pessoas conhecem (“Quem é o delegado encarregado desse caso?”), têm DT 20. Informações confidenciais, ou que podem colocar em risco quem falar sobre elas, têm DT 30. Este uso gasta desde uma hora até um dia, a critério do mestre.</p><p><br></p><p><strong>Procurar</strong></p><p>Você examina um local. A DT varia:</p><ul><li>15 para um item discreto ou no meio de uma bagunça, mas não necessariamente escondido.</li><li>20 para um item escondido (cofre atrás de um quadro, documento no fundo falso de uma gaveta).</li><li>30 para um item muito bem escondido (passagem secreta ativada por um botão, documento escrito com tinta invisível).</li></ul><p>Este uso gasta desde uma ação completa (examinar uma escrivaninha) até um dia (pesquisar uma biblioteca).</p><p><br></p>	f	f	f	f	\N
Medicina	INTELLIGENCE	<p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você sabe tratar ferimentos, doenças e venenos. </span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Primeiros Socorros (DT 20) </strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Um personagem adjacente que esteja morrendo e inconsciente perde essas condições e fica com 1 PV. A DT aumenta em +5 para cada vez que ele tiver sido estabilizado na cena. Este uso gasta uma ação padrão.</span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Cuidados Prolongados (Veterano, DT 20)</strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Durante uma cena de interlúdio, você pode gastar uma de suas ações para tratar até uma pessoa por ponto de Intelecto. Se passar, elas recuperam o dobro dos PV pela ação dormir neste interlúdio. </span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Necropsia (Treinado, DT 20) </strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você examina um cadáver para determinar a causa e o momento aproximado da morte. Causas raras ou extraordinárias, como um veneno exótico ou uma maldição, possuem DT +10. Este uso leva dez minutos. </span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Tratamento (Treinado)</strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você ajuda a vítima de uma doença ou veneno com efeito contínuo. Gaste uma ação completa e faça um teste contra a DT da doença ou veneno. Se você passar, o paciente recebe +5 em seu próximo teste de Fortitude contra esse efeito. </span></p><p><br></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);"><span class="ql-cursor">﻿</span>Esta perícia exige um kit. Sem ele, você sofre -5 no teste. Você pode usar a perícia Medicina em si mesmo, mas sofre -1d20 no teste.</span></p>	f	f	t	f	\N
Ocultismo	INTELLIGENCE	<p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você estudou o paranormal.</span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Identificar Criatura </strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você analisa uma criatura paranormal que possa ver. A DT do teste é igual à DT para resistir à Presença Perturbadora da criatura. Se você passar, descobre uma característica da criatura, como um poder ou vulnerabilidade. Para cada 5 pontos pelos quais o resultado do teste superar a DT, você descobre outra característica. Se falhar por 5 ou mais, tira uma conclusão errada (por exemplo, acredita que uma criatura é vulnerável à Morte, quando na verdade é vulnerável a Energia). Este uso gasta uma ação completa.</span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Identificar Item Amaldiçoado (DT 20)</strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você pode gastar uma ação de interlúdio para estudar um item amaldiçoado e identificar seus poderes ou qual ritual o objeto contém. Você pode sofrer -10 no teste para fazê-lo como uma ação completa.</span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Identificar Ritual (DT 10 +5 por círculo do ritual)</strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Quando alguém lança um ritual, você pode descobrir qual é observando seus gestos, palavras e componentes. Este uso é uma reação.</span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Informação</strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você responde dúvidas relativas ao Outro Lado, objetos amaldiçoados, fenômenos paranormais, runas, profecias, etc. Questões simples não exigem teste. Questões complexas exigem um teste contra DT 20. Por fim, mistérios e enigmas exigem um teste contra DT 30.</span></p>	t	f	f	f	\N
Percepção	PRESENCE	<p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você nota coisas usando os sentidos.</span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Observar</strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você vê coisas discretas ou escondidas. A DT varia de 15 para coisas difíceis de serem vistas (um livro específico em uma estante) a 30 para coisas quase invisíveis (uma gota de sangue em uma folha no meio de uma floresta à noite). Para pessoas ou coisas escondidas, a DT é o resultado do teste de Furtividade ou Crime feito para esconder a pessoa ou ocultar o item. Você também pode ler lábios, com uma DT de 20.</span></p><p><br></p><p><strong style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Ouvir</strong></p><p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você escuta barulhos sutis. Uma conversa casual próxima tem DT 0 — ou seja, a menos que exista alguma penalidade, você passa automaticamente. Ouvir pessoas sussurrando tem DT 15. Ouvir do outro lado de uma porta aumenta a DT em +5. Você pode fazer testes de Percepção para ouvir mesmo que esteja dormindo, mas sofre -2d20 no teste; um sucesso faz você acordar. Perceber seres que não possam ser vistos tem DT 20, ou +10 no teste de Furtividade do ser, o que for maior. Mesmo que você passe no teste, ainda sofre penalidades normais por lutar sem ver o inimigo.</span></p>	f	f	f	f	\N
Pilotagem	DEXTERITY	<p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você sabe operar veículos terrestres e aquáticos, como motos, carros e lanchas. Pilotar um veículo gasta uma ação de movimento por turno. Situações comuns (dirigir em uma estrada, velejar em clima tranquilo) não exigem teste. Situações ruins (dirigir em uma estrada de chão e sem iluminação, velejar em chuva ou ventania) exigem um teste por turno contra DT 15. Situações terríveis (dirigir em terreno acidentado, velejar durante uma tempestade) exigem um teste por turno contra DT 25. Se você possuir grau de treinamento veterano nesta perícia, pode pilotar veículos aéreos, como aviões e helicópteros.</span></p>	t	f	f	f	\N
Pontaria	DEXTERITY	<p><span style="background-color: oklab(0.0852327 0.00000386313 0.00000170618 / 0.06); color: oklab(0.899401 -0.00192499 -0.00481987);">Você usa Pontaria para fazer ataques à distância. A DT é a Defesa do alvo. Se você acertar, causa dano de acordo com a arma utilizada.</span></p>	f	f	f	f	\N
Profissão	INTELLIGENCE	<p>Você sabe exercer uma profissão específica, como advogado, engenheiro, jornalista ou publicitário. Converse com o mestre para definir os detalhes de sua profissão e quais tipos de testes você pode fazer com ela. Por exemplo, um advogado pode fazer um teste de Profissão para argumentar com a polícia, enquanto um administrador pode usar esta perícia para investigar os documentos de uma corporação.</p><p><br></p><p>Um personagem treinado nesta perícia possui seus próprios rendimentos ou, caso não trabalhe mais, uma reserva de capital. Isso permite que você comece cada missão com um item adicional, além daqueles fornecidos pela Ordem. O item é de categoria I se você for treinado, de categoria II se você for veterano e de categoria III se você for expert.</p>	t	f	f	f	\N
Reflexos	DEXTERITY	<p>Você usa esta perícia para testes de resistência contra efeitos que exigem reação rápida, como armadilhas e explosões. A DT é determina pelo efeito. Você também usa Reflexos para evitar fintas.</p>	f	f	f	f	\N
Religião	PRESENCE	<p>Você possui conhecimento sobre teologia e as diversas religiões do mundo.</p><p><br></p><p><strong>Acalmar (DT 20)</strong></p><p>Você pode usar Religião como Diplomacia para acalmar um personagem que esteja enlouquecendo.</p><p><br></p><p><strong>Informação</strong></p><p>Você pode responder dúvidas relativas a mitos, profecias, relíquias sagradas, etc. A DT é 10 para questões simples, 20 para questões complexas e 30 para mistérios e enigmas.</p><p><br></p><p><strong>Rito (Veterano, DT 20)</strong></p><p>Você realiza uma cerimônia religiosa (batizado, casamento, funeral, etc.).</p>	t	f	f	f	\N
Sobrevivência	INTELLIGENCE	<p>Você possui habilidades para se guiar em regiões selvagens e evitar perigos da natureza.</p><p><br></p><p><strong>Acampamento ( Treinado)</strong></p><p>Você pode conseguir abrigo e alimento nos ermos, como caçar, pescar e colher frutos. A DT varia conforme o tipo de terreno:</p><ul><li>15 para campo aberto</li><li>20 para mata fechada</li><li>25 para regiões extremas (desertos, pântanos, montanhas)</li></ul><p>Regiões especialmente áridas ou estéreis e condições climáticas ruins (neve, tempestade, etc.) impõem uma penalidade de –5 (cumulativa). Se você passar no teste, você e seu grupo podem usar as ações de interlúdio para alimentar-se e dormir mesmo ao relento.</p><p><br></p><p><strong>Identificar Animal (Treinado, DT 20)</strong></p><p>Com uma ação completa, você pode identificar um animal exótico. Para mais detalhes, veja a perícia Ocultismo.</p><p><br></p><p><strong>Orientar-se</strong></p><p>Para viajar em regiões selvagens, um personagem deve fazer um teste de Sobrevivência por dia. A DT varia conforme o tipo de terreno:</p><ul><li>15 para campo aberto</li><li>20 para mata fechada</li><li>25 para regiões extremas</li></ul><p>Se você passar, avança seu deslocamento normal. Se falhar, avança metade do deslocamento. Se falhar por 5 ou mais, se perde e não avança pelo dia inteiro. Em um grupo, um personagem deve ser escolhido como guia. Personagens treinados em Sobrevivência podem fazer testes para ajudar o guia. Se mais de um personagem tentar fazer o teste sozinho, todos devem rolar em segredo. Os jogadores devem decidir qual guia seguir antes de verem o resultado.</p><p><br></p><p><strong>Rastrear (Treinado)</strong></p><p>Você pode identificar e seguir rastros. A DT varia:</p><ul><li>15 para rastrear um grupo grande ou um único ser em solo macio (lama, neve)</li><li>20 para um ser em solo comum (grama, terra)</li><li>25 para um ser em solo duro (estrada, piso de interiores)</li></ul><p>Visibilidade precária ou clima ruim (noite, chuva, neblina) impõem –1d20 no teste. Você precisa fazer um teste por dia de perseguição. Enquanto rastreia, seu deslocamento é reduzido à metade. Se falhar, pode tentar novamente gastando mais um dia. A cada dia desde a criação dos rastros, a DT aumenta em +1.</p><p><br></p>	f	f	f	f	\N
Tática	INTELLIGENCE	<p><strong>Analisar Terreno (DT 20)</strong></p><p>Como uma ação de movimento, você pode observar o campo de batalha. Se passar no teste, você descobre uma vantagem, como cobertura, camuflagem ou terreno elevado, se houver.</p><p><br></p><p><strong>Plano de Ação (Veterano, DT 20)</strong></p><p>Como uma ação padrão, você orienta um aliado em alcance médio. Se passar no teste, fornece +5 na Iniciativa dele. Se isso fizer com que o aliado que ainda não tenha agido nesta rodada fique com uma Iniciativa maior do que a sua, ele age imediatamente após o seu turno. Nas próximas rodadas, ele age de acordo com a nova ordem.</p><p><br></p>	t	f	f	f	\N
Tecnologia	INTELLIGENCE	<p>Você possui conhecimentos avançados de eletrônica e informática. Usos cotidianos, como mexer em um computador ou celular, não exigem treinamento nesta perícia ou testes. Esta perícia serve para usos avançados, como reprogramar um sistema de vigilância ou invadir um servidor seguro.</p><p><br></p><p><strong>Falsificação (Veterano)</strong></p><p>Como o uso de Enganação, mas apenas para documentos eletrônicos.</p><p><br></p><p><strong>Hackear</strong></p><p>Você invade um computador protegido. A DT é 15 para computadores pessoais, 20 para redes profissionais e 25 para grandes servidores corporativos, governamentais ou militares. Este uso gasta 1d4+1 ações completas. Você pode sofrer uma penalidade de –1d20 em seu teste para fazê-lo como uma ação completa. Se você falhar no teste, não pode tentar novamente até ter alguma informação nova que o ajude na invasão, como um nome de usuário ou senha. Se falhar por 5 ou mais, pode ser rastreado pelos administradores do sistema que tentou invadir.</p><p>Uma vez que invada o sistema, você pode fazer o que veio fazer. Para procurar uma informação específica, veja o uso localizar arquivo, abaixo. Outras ações, como alterar ou deletar arquivos, corromper ou desativar aplicativos ou bloquear o acesso de outros usuários, podem exigir novos testes de Tecnologia, à critério do mestre.</p><p><br></p><p><strong>Localizar Arquivo</strong></p><p>Você procura um arquivo específico em um computador ou rede que possa acessar (se você não tiver acesso ao sistema, precisará primeiro invadi-lo; veja o uso hackear, acima). O tempo exigido e a DT do teste variam de acordo com o tamanho do sistema no qual você está pesquisando: uma ação completa e DT 15 para um computador pessoal, 1d4+1 ações completas e DT 20 para uma rede pequena e 1d6+2 ações completas e DT 25 para uma rede corporativa ou governamental. Este uso se refere apenas a localizar arquivos em sistemas privados que você não conhece. Para procurar informações públicas, na internet, use a perícia Investigação.</p><p><br></p><p><strong>Operar Dispositivo</strong></p><p>Você opera um dispositivo eletrônico complexo. Isso permite que você acesse câmeras remotamente, destrave fechaduras eletrônicas, ative ou desative alarmes, etc. A DT é 15 para aparelhos comuns, 20 para equipamento profissional e 25 para sistemas protegidos. Este uso gasta 1d4+1 ações completas e exige um kit de eletrônica. Você pode sofrer uma penalidade de –1d20 em seu teste para fazê-lo como uma ação completa. Sem o kit, você sofre –5 nos testes de operar dispositivo.</p>	t	f	t	f	\N
Vontade	PRESENCE	<p>Você usa esta perícia para testes de resistência contra efeitos que exigem determinação, como intimidação e rituais que afetam a mente. A DT é determina pelo efeito. Você também usa Vontade para conjurar rituais em condições adversas.</p>	f	f	f	f	\N
\.


--
-- Data for Name: Subclass; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Subclass" (id, name, "classId", description) FROM stdin;
cm1bely5b0004knwb1e1zi0hi	Aniquilador	cm1beidgp0001knwb86n0e6w6	<p>Você é treinado para abater alvos com eficiência e velocidade. Suas armas são suas melhores amigas e você cuida tão bem delas quanto de seus companheiros de equipe. Talvez até melhor.</p>
cm1bem8q00005knwbvx4mshna	Comandante de Campo	cm1beidgp0001knwb86n0e6w6	<p>Sem um oficial uma batalha não passa de uma briga de bar. Você é treinado para coordenar e auxiliar seus companheiros em combate, tomando decisões 27 rápidas e tirando melhor proveito da situação e do talento de seus aliados.</p>
cm1bemg2h0006knwbsqhi0w4c	Guerreiro	cm1beidgp0001knwb86n0e6w6	<p>Você treinou sua musculatura e movimentos a ponto de transformar seu corpo em uma verdadeira arma. Com golpes corpo a corpo tão poderosos quanto uma bala, você encara os perigos de frente.</p>
cm1bemopb0007knwbqn26aktv	Operações Especiais	cm1beidgp0001knwb86n0e6w6	<p>Você é um combatente eficaz. Suas ações são calculadas e otimizadas, sempre antevendo os movimentos inimigos e se posicionando da maneira mais inteligente no campo de batalha.</p>
cm1bemy380008knwbh8ht7a7b	Tropa de Choque	cm1beidgp0001knwb86n0e6w6	<p>Você é duro na queda. Treinou seu corpo para resistir a traumas físicos, tornando-o praticamente inquebrável, e por isso não teme se colocar entre seus aliados e o perigo.</p>
cm1bena7w0009knwbg2hm9ply	Atirador de Elite	cm1bejpao0002knwbwlri6asv	<p>Um tiro, uma morte. Ao contrário dos combatentes, você é perito em neutralizar ameaças de longe, terminando uma briga antes mesmo que ela comece. Você trata sua arma como uma ferramenta de precisão, sendo capaz de executar façanhas incríveis.</p>
cm1beng80000aknwb792uz6wm	Infiltrador	cm1bejpao0002knwbwlri6asv	<p>Você é um perito em infiltração e sabe neutralizar alvos desprevenidos sem causar alarde. Combinando talento acrobático, destreza manual e conhecimento técnico você é capaz de superar qualquer barreira de defesa, mesmo quando a missão parece impossível</p>
cm1bennph000bknwb01zb8bq1	Médico de Campo	cm1bejpao0002knwbwlri6asv	<p>Você é treinado em técnicas de primeiros socorros e tratamento de emergência, o que torna você um membro valioso para qualquer grupo de agentes. Ao contrário dos profissionais de saúde convencionais, você está acostumado com o campo de batalha e sabe tomar decisões rápidas no meio do caos</p>
cm1benvcd000cknwbwjc693zu	Negociador	cm1bejpao0002knwbwlri6asv	<p>Você é um diplomata habilidoso e consegue influenciar outras pessoas, seja por lábia ou intimidação. Sua capacidade de avaliar situações com rapidez e eficiência pode tirar o grupo de apuros que nem a mais poderosa das armas poderia resolver.</p>
cm1beo416000dknwbkk2whchu	Técnico	cm1bejpao0002knwbwlri6asv	<p>Sua principal habilidade é a manutenção e reparo do valioso equipamento que seu time carrega em missão. Seu conhecimento técnico também permite que improvise ferramentas com o que tiver à disposição e sabote os itens usados por seus inimigos.</p>
cm1beodck000eknwbtc0du48u	Conduíte	cm1bekpmk0003knwbdi0gscjk	<p>Você domina os aspectos fundamentais da conjuração de rituais e é capaz de aumentar o alcance e velocidade de suas conjurações. Conforme sua conexão com as entidades paranormais aumenta você se torna capaz de interferir com os rituais de outros ocultistas.</p>
cm1beokwi000fknwbd903mrl4	Flagelador	cm1bekpmk0003knwbdi0gscjk	<p>Dor é um poderoso catalisador paranormal e você aprendeu a transformá-la em poder para seus rituais. Quando se torna especialmente poderoso, consegue usar a dor e o sofrimento de seus inimigos como instrumento de seus rituais ocultistas.</p>
cm1beouk0000gknwbc5gi1wo8	Graduado	cm1bekpmk0003knwbdi0gscjk	<p>Você foca seus estudos em se tornar um conjurador versátil e poderoso, conhecendo mais rituais que os outros ocultistas e sendo capaz de torná-los mais difíceis de serem resistidos. Seu objetivo é desvendar e dominar os segredos do Outro Lado, custe o que custar</p>
cm1bep1tp000hknwb4xjbo5wi	Intuitivo	cm1bekpmk0003knwbdi0gscjk	<p>Assim como combatentes treinam seus corpos para resistir a traumas f ísicos, você preparou sua mente para resistir aos efeitos do Outro Lado. Seu foco e força de vontade fazem com que você expanda os limites de suas capacidades paranormais.</p>
cm1bep9u1000iknwb53ztxxq4	Lâmina Paranormal	cm1bekpmk0003knwbdi0gscjk	<p>Alguns ocultistas preferem ficar fechados em suas bibliotecas estudando livros e rituais. Outros preferem investigar fenômenos paranormais em sua fonte. Já você, prefere usar o paranormal como uma arma. Você aprendeu e dominou técnicas de luta mesclando suas habilidades de conjuração com suas capacidades de combate.</p>
\.


--
-- Data for Name: SubclassFeats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SubclassFeats" ("featId", "subclassId", "levelRequired") FROM stdin;
cm1bg55f10013knwbforr1pde	cm1bemg2h0006knwbsqhi0w4c	2
cm1bg5u690014knwbv0yo3wbz	cm1bemg2h0006knwbsqhi0w4c	8
cm1bg69z80015knwbavyay2zw	cm1bemg2h0006knwbsqhi0w4c	13
cm1bg6jw50016knwbpxevoa1k	cm1bemg2h0006knwbsqhi0w4c	20
cm1bg8yip0017knwb9a86ftbs	cm1beng80000aknwb792uz6wm	2
cm1bgad3a0018knwblw7ce5ty	cm1beng80000aknwb792uz6wm	8
cm1bgappw0019knwbkx5f7drn	cm1beng80000aknwb792uz6wm	13
cm1bgb2ow001aknwb944fcpfz	cm1beng80000aknwb792uz6wm	20
cm1bgd3la001bknwbdjtvg63u	cm1beodck000eknwbtc0du48u	2
cm1bgdsfd001cknwbdaol9ytc	cm1beodck000eknwbtc0du48u	8
cm1bgemhg001dknwbjoved7i7	cm1beodck000eknwbtc0du48u	13
cm1bgeytz001eknwb5pr0w5bf	cm1beodck000eknwbtc0du48u	20
cm5hkq8rp00006apb9o0gccm5	cm1bely5b0004knwb1e1zi0hi	2
cm5hkrqj800016apbcwrpgkq3	cm1bely5b0004knwb1e1zi0hi	8
cm5hksk3w00026apbcmcdl2hw	cm1bely5b0004knwb1e1zi0hi	13
cm5hkt3el00036apbq4spyc4f	cm1bely5b0004knwb1e1zi0hi	20
cm5hktw6k00046apbwr56pqnk	cm1bemy380008knwbh8ht7a7b	2
cm5hkuox800056apb81oodk9y	cm1bemy380008knwbh8ht7a7b	8
cm5hkv69m00066apbe3uj442t	cm1bemy380008knwbh8ht7a7b	13
cm5hkvjyi00076apb5z6464fk	cm1bemy380008knwbh8ht7a7b	20
cm5hkw49100086apb0f6iwu34	cm1benvcd000cknwbwjc693zu	2
cm5hkwr0h00096apbjd8jnjn8	cm1benvcd000cknwbwjc693zu	8
cm5hkx5s9000a6apbasfrrgvh	cm1benvcd000cknwbwjc693zu	13
cm5hkxkoa000b6apbiqnmubat	cm1benvcd000cknwbwjc693zu	20
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, username, password, email, role) FROM stdin;
cm1bc46xx0000knwbt37wqtvi	quarerma	$2b$10$MqArroBMznobLK3qd9pARO1FlBowQLZHaZCuWaJe/dw15vr3oI.Xa	gabriel.oliveira.quaresma@gmail.com	ADMIN
cm5bmno2k0000n92qg3024kzq	pukA	$2b$10$wHOyJM0.dQp6Qidv2JlUo.XZm2kGOzA6Eb321EOwdlUqgWMSrD47S	eck.leal.39@gmail.com	USER
cm5hc0bh900004p9wvlq38ry2	JoeBlossom	$2b$10$fzjGEGDWAOnKpzISnpqFbOYT2q3djWAPN0YfPBMF2PNHBDBbf89bS	snack9827@gmail.com	ADMIN
cm5ieq8i70008xhvho01d3xkv	Gabili	$2b$10$I6vJs5oEBk8.BbwUOUaqE.zMGbi4eKVbDZhVhFVHLundSg7WMEOtu	g.vanzella1812@gmail.com	USER
cm5jis4km0000pa9ew5i0gk3s	Danas	$2b$10$sSw5s3z10XE2jkcWRTG1K.5xx6fvF9fgzXa7f2S68NCbyIv0FcE9O	dsouzamiguelfaria@gmail.com	USER
\.


--
-- Data for Name: Weapon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Weapon" ("equipmentId", damage, critical_multiplier, critical_range, range, damage_type, weapon_category, weapon_type, hand_type) FROM stdin;
9	2d6	3	19	SHORT	BALISTIC	SIMPLE	BULLET	LIGHT
17	1d8	3	20	MELEE	SLASHING	SIMPLE	MELEE	ONE_HANDED
19	2d8	3	19	MEDIUM	BALISTIC	SIMPLE	BULLET	TWO_HANDED
20	1d4	2	19	SHORT	SLASHING	SIMPLE	MELEE	LIGHT
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
6fd6c698-58b4-4547-a287-06363a4af40e	c0730390a2ef616c158c2d1b6794e5ae77550c492a239a20823183464af47e11	2025-01-18 22:28:24.304189+00	20240619140621_first_look_at_database	\N	\N	2025-01-18 22:28:23.170608+00	1
dd3df2d0-10d2-412c-adf3-b6e7bc018aa8	c409900f125bdbe429ccc6be6db18f535ddcc111936fce4f7fbacd9c3845fd93	2025-01-18 22:28:41.730023+00	20240902181609_origin_type_on_feats	\N	\N	2025-01-18 22:28:40.78121+00	1
f479d956-7b89-4263-9e4e-38374f281ebe	7fa21169d9dfacc657e8da5d1441a35e563d548270a14dd7ba342d1330db7fe3	2025-01-18 22:28:25.675118+00	20240619143424_class_specifications	\N	\N	2025-01-18 22:28:24.714859+00	1
0855067a-d0f8-40a1-9761-c9fdde048b81	7783b97c74c9f839ab7c1f8aa38e32a71a15a21ffaddc884bd2e58d846a7f186	2025-01-18 22:28:26.962794+00	20240619201334_add_initial_feats	\N	\N	2025-01-18 22:28:26.053749+00	1
3f74e804-e23d-4197-84b6-8e8b36bec50c	d9f1122ce3df6213f680978ac13903c3364328cdf1b14fdbbcfd0438f7f6b541	2025-01-18 22:28:53.991009+00	20240919212849_revert_change	\N	\N	2025-01-18 22:28:52.890886+00	1
dc557e22-1ac4-4ab2-9929-5a852aa06ffd	f683cdfe8fe6759822e736620244fca13d266d469bc9e87cf75bbfb6363a2070	2025-01-18 22:28:28.293573+00	20240620190329_remodel_relations	\N	\N	2025-01-18 22:28:27.342894+00	1
040cf9c4-818a-427c-bc46-9d99942319e1	fc3deeb8bf39f584de2bdc302eafac1aff9063a135e6fc35079b6da9f86cf388	2025-01-18 22:28:43.077498+00	20240903225317_conditions	\N	\N	2025-01-18 22:28:42.108522+00	1
ad76453f-fa18-4f74-b926-843136bacb79	b875b93bd8146c640ccf7a0d1aceb3c02fe7dfe288996989c604780ead0a17ca	2025-01-18 22:28:29.602772+00	20240621155414_update_migration	\N	\N	2025-01-18 22:28:28.66314+00	1
07c674d8-26c5-43ef-bebd-fa3c960a63fb	5b80e5a85f6e113bc7d2f374c5704a3579285b94deabd8be1d9e638ecabf09f8	2025-01-18 22:28:31.126697+00	20240821203334_rework_database	\N	\N	2025-01-18 22:28:29.974448+00	1
af245953-9ee9-4f26-b86f-d2890528e31a	802f29aaa4a40f58f02b8d7e7ff51f0d3d200901059efe04cd425787d26c0598	2025-01-18 22:28:32.469968+00	20240823195101_user_role	\N	\N	2025-01-18 22:28:31.518953+00	1
b953d98b-e32f-432f-a6e8-1660b5ec6c73	575982087ba4a65939543e1edfad8aa9b6728b8ec581e8154e8fd37c2346b20c	2025-01-18 22:28:44.409497+00	20240914021414_starter_feat_boolean	\N	\N	2025-01-18 22:28:43.459114+00	1
dd9a15ef-2b54-435c-92af-e8fb4a7a9c15	c1e71cc6e9f6efcee63c65c34c2ac0c221359768746dba363265abff64cb30ca	2025-01-18 22:28:33.778652+00	20240825183012_description_to_subclass	\N	\N	2025-01-18 22:28:32.842701+00	1
6e03f7dd-7a9f-42a7-873f-12c85e04d805	4cb8bd1d5a131e921f459e9a001aa365ccf36cac9ce06f35a2c30b4b236ded94	2025-01-18 22:28:35.093443+00	20240825183058_add_description_to_class	\N	\N	2025-01-18 22:28:34.15107+00	1
eb4797e9-fc17-4f7a-95ba-de9d5d1db2c7	7572ed6b3c4c5814372672df639770a43d7a3c15961fb6a15674701294ffbc31	2025-01-18 22:28:36.416358+00	20240826171948_change_afinity	\N	\N	2025-01-18 22:28:35.468906+00	1
8d2850b0-5297-474d-af3b-1ab84f10e24a	ffb4b6cbb297be5f9bae4b333e4a53fefdf8a118a60d2ea534f70fd9e979fca1	2025-01-18 22:28:45.746718+00	20240914172504_	\N	\N	2025-01-18 22:28:44.791211+00	1
17aae5bb-b8c8-445a-a0a5-61365f5c3712	c633fb7f02650686da747f509abda83183a84f738d0b5078319a91bd225556e4	2025-01-18 22:28:37.745661+00	20240902151014_defense_speed	\N	\N	2025-01-18 22:28:36.795509+00	1
6709baf4-f395-4869-99d7-22fa59a140b4	d05e4bf7a10551436934f6363af40eca4bb1e9a71b47ce6a4a21499b593ec4ed	2025-01-18 22:28:39.066195+00	20240902175355_change_how_feats_afinity_works	\N	\N	2025-01-18 22:28:38.121808+00	1
6ff7e7f7-65c0-44fd-b3d5-fb894167bdf9	d432d224a4a9b834f18f82431d8913a6d1a9992ec42ca439e87cb71a53dbf072	2025-01-18 22:28:55.335825+00	20240920014945_remove_unique_from_name	\N	\N	2025-01-18 22:28:54.372244+00	1
c7c298de-85e3-4fe3-8f7d-901e04920eda	c1826076aaf915076583f9497a3cba1063a685fa1335cef1233d808b82cb13f1	2025-01-18 22:28:40.398407+00	20240902181036_feat_not_null_on_origin	\N	\N	2025-01-18 22:28:39.444198+00	1
a4de2943-471c-4c45-ba73-0334a345650c	91e311bced8bb8d26a55cda9474437fb57fff59c97853b0e54be6ec8041f7b11	2025-01-18 22:28:47.084678+00	20240914175133_add_damage_type	\N	\N	2025-01-18 22:28:46.12681+00	1
6c709760-ec3e-405b-8f81-d912617822bd	b4074b87d98095dcd2d84e350b2dce155a86e4e688a52e461151d4208aec90f8	2025-01-18 22:28:48.453691+00	20240916145412_delete_initialfeats	\N	\N	2025-01-18 22:28:47.49351+00	1
27c545c2-7ce8-4643-bc30-20d91e77f289	fea075238d48c0974985bedc618abff3819d6b65c760f7a031b6633ffcf97c94	2025-01-18 22:28:49.808238+00	20240918212310_optional_damage	\N	\N	2025-01-18 22:28:48.834867+00	1
b4074d8a-2706-43a1-a77f-05377cbc0c54	4479803cbdd7fa591cb708b8472c1d59ef63fd3e4da30ebd3f54f4bbe7f92d13	2025-01-18 22:28:56.681315+00	20240920142054_custom_description	\N	\N	2025-01-18 22:28:55.719956+00	1
589f0263-43d9-496f-8032-2cf513f83225	f9ae436ab3861d2c681c92bdf839df1be88a9ea35e557d6a5971bcd76261b7c9	2025-01-18 22:28:51.151884+00	20240918234633_make_damage_string	\N	\N	2025-01-18 22:28:50.188545+00	1
eab7cd61-b560-4963-b99f-a5b79b2c812a	e8cf76d14e6a9c8cd36ae93cc4c04de20f36b1913d0f029e51e3a5f2019c4453	2025-01-18 22:28:52.496572+00	20240919212558_custom_item_type	\N	\N	2025-01-18 22:28:51.536386+00	1
754ade69-8a07-4b6b-ad1a-686585f7a2dc	25075c187a7834b504c8c6ba28ca8f87fbcf22c562c4ebeb45f38d7bf4e055ff	2025-01-18 22:28:58.053059+00	20250113224034_optional_char_campaign_note	\N	\N	2025-01-18 22:28:57.062558+00	1
6d3dbc7b-4daf-4e2c-9adc-91c13ce6f014	9ca9738caf0ac9a0f273c56493b5ba2137d3c934d2df31e5a967342a949930ee	2025-01-18 22:28:59.330453+00	20250118222314_change_inventory_weight	\N	\N	2025-01-18 22:28:58.413745+00	1
883fa73d-5a5b-4d69-9128-4f628acd56c5	12cebf6aa2d45cc14c6f593fe7843fae61b5e8b94766d7fcb7eaba2e475c23b5	2025-01-13 22:20:18.329464+00	20250113_create_notes_table		\N	2025-01-13 22:20:18.329464+00	0
985becfc-c5fc-4398-959b-b6b76b867429	c0730390a2ef616c158c2d1b6794e5ae77550c492a239a20823183464af47e11	2025-01-13 22:24:32.312352+00	20240619140621_first_look_at_database		\N	2025-01-13 22:24:32.312352+00	0
5d5f4d93-bfa5-4f7d-8b2e-38d045eeeb6b	7fa21169d9dfacc657e8da5d1441a35e563d548270a14dd7ba342d1330db7fe3	2025-01-13 22:24:39.053686+00	20240619143424_class_specifications		\N	2025-01-13 22:24:39.053686+00	0
83f7b9ef-5b11-4c2f-93ff-da973bd7c900	7783b97c74c9f839ab7c1f8aa38e32a71a15a21ffaddc884bd2e58d846a7f186	2025-01-13 22:24:45.460083+00	20240619201334_add_initial_feats		\N	2025-01-13 22:24:45.460083+00	0
85b40c46-ba23-4a84-8c38-be069fab12e9	f683cdfe8fe6759822e736620244fca13d266d469bc9e87cf75bbfb6363a2070	2025-01-13 22:24:51.79122+00	20240620190329_remodel_relations		\N	2025-01-13 22:24:51.79122+00	0
06a6a9bb-b0ea-46c1-baea-d3008f4ddf44	b875b93bd8146c640ccf7a0d1aceb3c02fe7dfe288996989c604780ead0a17ca	2025-01-13 22:24:56.949978+00	20240621155414_update_migration		\N	2025-01-13 22:24:56.949978+00	0
5cb77aac-6a85-4141-bb03-2604906f9d83	5b80e5a85f6e113bc7d2f374c5704a3579285b94deabd8be1d9e638ecabf09f8	2025-01-13 22:25:03.42958+00	20240821203334_rework_database		\N	2025-01-13 22:25:03.42958+00	0
080b9b5e-acff-4e7a-807b-beb67d453d03	802f29aaa4a40f58f02b8d7e7ff51f0d3d200901059efe04cd425787d26c0598	2025-01-13 22:25:09.90082+00	20240823195101_user_role		\N	2025-01-13 22:25:09.90082+00	0
5b11378d-14d2-4e06-9092-642dc0c0e7cd	c1e71cc6e9f6efcee63c65c34c2ac0c221359768746dba363265abff64cb30ca	2025-01-13 22:25:16.402919+00	20240825183012_description_to_subclass		\N	2025-01-13 22:25:16.402919+00	0
6becf694-6e28-4955-a20a-8986590fbb30	4cb8bd1d5a131e921f459e9a001aa365ccf36cac9ce06f35a2c30b4b236ded94	2025-01-13 22:25:23.489015+00	20240825183058_add_description_to_class		\N	2025-01-13 22:25:23.489015+00	0
13b6bdf4-c703-4066-9e5d-bdcff7bf8334	7572ed6b3c4c5814372672df639770a43d7a3c15961fb6a15674701294ffbc31	2025-01-13 22:25:28.193284+00	20240826171948_change_afinity		\N	2025-01-13 22:25:28.193284+00	0
e1e79c3f-f98a-4457-826c-858851fb8c6b	c633fb7f02650686da747f509abda83183a84f738d0b5078319a91bd225556e4	2025-01-13 22:25:34.537305+00	20240902151014_defense_speed		\N	2025-01-13 22:25:34.537305+00	0
9b17a9ff-074e-42df-b4a5-ca2f94f2f10a	d05e4bf7a10551436934f6363af40eca4bb1e9a71b47ce6a4a21499b593ec4ed	2025-01-13 22:25:40.991547+00	20240902175355_change_how_feats_afinity_works		\N	2025-01-13 22:25:40.991547+00	0
42de7526-e31c-478f-a53c-7488df43efbb	c1826076aaf915076583f9497a3cba1063a685fa1335cef1233d808b82cb13f1	2025-01-13 22:25:47.362534+00	20240902181036_feat_not_null_on_origin		\N	2025-01-13 22:25:47.362534+00	0
c77db070-5cf9-4a66-911d-b53383d454e9	c409900f125bdbe429ccc6be6db18f535ddcc111936fce4f7fbacd9c3845fd93	2025-01-13 22:25:52.473633+00	20240902181609_origin_type_on_feats		\N	2025-01-13 22:25:52.473633+00	0
8f65c2b7-d756-4388-85c4-e0ef5000b88f	fc3deeb8bf39f584de2bdc302eafac1aff9063a135e6fc35079b6da9f86cf388	2025-01-13 22:25:59.161889+00	20240903225317_conditions		\N	2025-01-13 22:25:59.161889+00	0
9574ce3a-5c44-4368-a388-20fdc011034a	575982087ba4a65939543e1edfad8aa9b6728b8ec581e8154e8fd37c2346b20c	2025-01-13 22:26:05.5847+00	20240914021414_starter_feat_boolean		\N	2025-01-13 22:26:05.5847+00	0
5f672339-e97b-4550-8c2a-8fba30ddd7b4	ffb4b6cbb297be5f9bae4b333e4a53fefdf8a118a60d2ea534f70fd9e979fca1	2025-01-13 22:26:12.050621+00	20240914172504_		\N	2025-01-13 22:26:12.050621+00	0
70240db2-5025-4c13-b194-88ea221ebb03	91e311bced8bb8d26a55cda9474437fb57fff59c97853b0e54be6ec8041f7b11	2025-01-13 22:26:18.435346+00	20240914175133_add_damage_type		\N	2025-01-13 22:26:18.435346+00	0
625ba1b9-178e-4745-9fe5-ebfcbaaff899	b4074b87d98095dcd2d84e350b2dce155a86e4e688a52e461151d4208aec90f8	2025-01-13 22:26:23.184719+00	20240916145412_delete_initialfeats		\N	2025-01-13 22:26:23.184719+00	0
a4e5c69b-8bbb-441b-a3da-195602e0c780	fea075238d48c0974985bedc618abff3819d6b65c760f7a031b6633ffcf97c94	2025-01-13 22:26:29.619658+00	20240918212310_optional_damage		\N	2025-01-13 22:26:29.619658+00	0
fcf1ea75-952c-4848-94a3-ad8534cba0db	f9ae436ab3861d2c681c92bdf839df1be88a9ea35e557d6a5971bcd76261b7c9	2025-01-13 22:26:36.106895+00	20240918234633_make_damage_string		\N	2025-01-13 22:26:36.106895+00	0
fdda667a-1ded-4a40-8d58-adee508b4916	e8cf76d14e6a9c8cd36ae93cc4c04de20f36b1913d0f029e51e3a5f2019c4453	2025-01-13 22:26:42.638644+00	20240919212558_custom_item_type		\N	2025-01-13 22:26:42.638644+00	0
77c2f740-d2bb-45d6-beea-21f07bb75aae	d9f1122ce3df6213f680978ac13903c3364328cdf1b14fdbbcfd0438f7f6b541	2025-01-13 22:26:49.06649+00	20240919212849_revert_change		\N	2025-01-13 22:26:49.06649+00	0
493cde17-a2bb-46db-b044-d5bd2524c50a	d432d224a4a9b834f18f82431d8913a6d1a9992ec42ca439e87cb71a53dbf072	2025-01-13 22:26:53.941546+00	20240920014945_remove_unique_from_name		\N	2025-01-13 22:26:53.941546+00	0
bdbee976-91a3-4d0d-a900-1aade027b116	4479803cbdd7fa591cb708b8472c1d59ef63fd3e4da30ebd3f54f4bbe7f92d13	2025-01-13 22:27:00.471466+00	20240920142054_custom_description		\N	2025-01-13 22:27:00.471466+00	0
d3cbc283-0e75-439e-a8e9-296d9fccbbd4	56f76a7147959131d07b6868cb56c91013894725759836407a0dc5ba3a9e6b87	2025-01-13 22:40:36.369242+00	20250113224034_optional_char_campaign_note	\N	\N	2025-01-13 22:40:35.315011+00	1
\.


--
-- Name: Equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Equipment_id_seq"', 1, false);


--
-- Name: CampaignEquipment CampaignEquipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignEquipment"
    ADD CONSTRAINT "CampaignEquipment_pkey" PRIMARY KEY (id);


--
-- Name: CampaignModifications CampaignModifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignModifications"
    ADD CONSTRAINT "CampaignModifications_pkey" PRIMARY KEY (id);


--
-- Name: CampaignOrigin CampaignOrigin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignOrigin"
    ADD CONSTRAINT "CampaignOrigin_pkey" PRIMARY KEY (id);


--
-- Name: CampaignRitual CampaignRitual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignRitual"
    ADD CONSTRAINT "CampaignRitual_pkey" PRIMARY KEY (id);


--
-- Name: Campaign Campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Campaign"
    ADD CONSTRAINT "Campaign_pkey" PRIMARY KEY (id);


--
-- Name: Character Character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Character"
    ADD CONSTRAINT "Character_pkey" PRIMARY KEY (id);


--
-- Name: Class Class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Class"
    ADD CONSTRAINT "Class_pkey" PRIMARY KEY (id);


--
-- Name: Condition Condition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Condition"
    ADD CONSTRAINT "Condition_pkey" PRIMARY KEY (id);


--
-- Name: CursedItem CursedItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CursedItem"
    ADD CONSTRAINT "CursedItem_pkey" PRIMARY KEY ("equipmentId");


--
-- Name: DamageRitual DamageRitual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DamageRitual"
    ADD CONSTRAINT "DamageRitual_pkey" PRIMARY KEY ("ritualId");


--
-- Name: Equipment Equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Equipment"
    ADD CONSTRAINT "Equipment_pkey" PRIMARY KEY (id);


--
-- Name: Feat Feat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Feat"
    ADD CONSTRAINT "Feat_pkey" PRIMARY KEY (id);


--
-- Name: GeneralFeats GeneralFeats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GeneralFeats"
    ADD CONSTRAINT "GeneralFeats_pkey" PRIMARY KEY (id);


--
-- Name: InventorySlot InventorySlot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InventorySlot"
    ADD CONSTRAINT "InventorySlot_pkey" PRIMARY KEY (id);


--
-- Name: Inventory Inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory"
    ADD CONSTRAINT "Inventory_pkey" PRIMARY KEY (character_id);


--
-- Name: Modification Modification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Modification"
    ADD CONSTRAINT "Modification_pkey" PRIMARY KEY (id);


--
-- Name: Notes Notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Notes"
    ADD CONSTRAINT "Notes_pkey" PRIMARY KEY (id);


--
-- Name: Origin Origin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Origin"
    ADD CONSTRAINT "Origin_pkey" PRIMARY KEY (id);


--
-- Name: Ritual Ritual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ritual"
    ADD CONSTRAINT "Ritual_pkey" PRIMARY KEY (id);


--
-- Name: Skill Skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Skill"
    ADD CONSTRAINT "Skill_pkey" PRIMARY KEY (name);


--
-- Name: Subclass Subclass_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subclass"
    ADD CONSTRAINT "Subclass_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Weapon Weapon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Weapon"
    ADD CONSTRAINT "Weapon_pkey" PRIMARY KEY ("equipmentId");


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: CampaignEquipment_campaign_id_equipment_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CampaignEquipment_campaign_id_equipment_id_key" ON public."CampaignEquipment" USING btree (campaign_id, equipment_id);


--
-- Name: CampaignFeats_featId_campaignId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CampaignFeats_featId_campaignId_key" ON public."CampaignFeats" USING btree ("featId", "campaignId");


--
-- Name: CampaignModifications_campaign_id_modification_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CampaignModifications_campaign_id_modification_id_key" ON public."CampaignModifications" USING btree (campaign_id, modification_id);


--
-- Name: CampaignOrigin_campaign_id_origin_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CampaignOrigin_campaign_id_origin_id_key" ON public."CampaignOrigin" USING btree (campaign_id, origin_id);


--
-- Name: CampaignRitual_campaign_id_ritual_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CampaignRitual_campaign_id_ritual_id_key" ON public."CampaignRitual" USING btree (campaign_id, ritual_id);


--
-- Name: CharacterCondition_character_id_condition_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CharacterCondition_character_id_condition_id_key" ON public."CharacterCondition" USING btree (character_id, condition_id);


--
-- Name: CharacterFeat_character_id_feat_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CharacterFeat_character_id_feat_id_key" ON public."CharacterFeat" USING btree (character_id, feat_id);


--
-- Name: CharacterRitual_character_id_ritual_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CharacterRitual_character_id_ritual_id_key" ON public."CharacterRitual" USING btree (character_id, ritual_id);


--
-- Name: ClassFeats_featId_classId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "ClassFeats_featId_classId_key" ON public."ClassFeats" USING btree ("featId", "classId");


--
-- Name: GeneralFeats_featId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "GeneralFeats_featId_key" ON public."GeneralFeats" USING btree ("featId");


--
-- Name: PlayerOnCampaign_campaign_id_player_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "PlayerOnCampaign_campaign_id_player_id_key" ON public."PlayerOnCampaign" USING btree (campaign_id, player_id);


--
-- Name: RitualCondition_ritual_id_condition_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "RitualCondition_ritual_id_condition_id_key" ON public."RitualCondition" USING btree (ritual_id, condition_id);


--
-- Name: SubclassFeats_featId_subclassId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "SubclassFeats_featId_subclassId_key" ON public."SubclassFeats" USING btree ("featId", "subclassId");


--
-- Name: User_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_email_idx" ON public."User" USING btree (email);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_username_idx" ON public."User" USING btree (username);


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: CampaignEquipment CampaignEquipment_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignEquipment"
    ADD CONSTRAINT "CampaignEquipment_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignEquipment CampaignEquipment_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignEquipment"
    ADD CONSTRAINT "CampaignEquipment_equipment_id_fkey" FOREIGN KEY (equipment_id) REFERENCES public."Equipment"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignFeats CampaignFeats_campaignId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignFeats"
    ADD CONSTRAINT "CampaignFeats_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignFeats CampaignFeats_featId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignFeats"
    ADD CONSTRAINT "CampaignFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES public."Feat"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignModifications CampaignModifications_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignModifications"
    ADD CONSTRAINT "CampaignModifications_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignModifications CampaignModifications_modification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignModifications"
    ADD CONSTRAINT "CampaignModifications_modification_id_fkey" FOREIGN KEY (modification_id) REFERENCES public."Modification"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignOrigin CampaignOrigin_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignOrigin"
    ADD CONSTRAINT "CampaignOrigin_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignOrigin CampaignOrigin_origin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignOrigin"
    ADD CONSTRAINT "CampaignOrigin_origin_id_fkey" FOREIGN KEY (origin_id) REFERENCES public."Origin"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignRitual CampaignRitual_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignRitual"
    ADD CONSTRAINT "CampaignRitual_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CampaignRitual CampaignRitual_ritual_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignRitual"
    ADD CONSTRAINT "CampaignRitual_ritual_id_fkey" FOREIGN KEY (ritual_id) REFERENCES public."Ritual"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Campaign Campaign_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Campaign"
    ADD CONSTRAINT "Campaign_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CharacterCondition CharacterCondition_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CharacterCondition"
    ADD CONSTRAINT "CharacterCondition_character_id_fkey" FOREIGN KEY (character_id) REFERENCES public."Character"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CharacterCondition CharacterCondition_condition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CharacterCondition"
    ADD CONSTRAINT "CharacterCondition_condition_id_fkey" FOREIGN KEY (condition_id) REFERENCES public."Condition"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CharacterFeat CharacterFeat_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CharacterFeat"
    ADD CONSTRAINT "CharacterFeat_character_id_fkey" FOREIGN KEY (character_id) REFERENCES public."Character"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CharacterFeat CharacterFeat_feat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CharacterFeat"
    ADD CONSTRAINT "CharacterFeat_feat_id_fkey" FOREIGN KEY (feat_id) REFERENCES public."Feat"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CharacterRitual CharacterRitual_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CharacterRitual"
    ADD CONSTRAINT "CharacterRitual_character_id_fkey" FOREIGN KEY (character_id) REFERENCES public."Character"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CharacterRitual CharacterRitual_ritual_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CharacterRitual"
    ADD CONSTRAINT "CharacterRitual_ritual_id_fkey" FOREIGN KEY (ritual_id) REFERENCES public."Ritual"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Character Character_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Character"
    ADD CONSTRAINT "Character_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Character Character_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Character"
    ADD CONSTRAINT "Character_class_id_fkey" FOREIGN KEY (class_id) REFERENCES public."Class"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Character Character_origin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Character"
    ADD CONSTRAINT "Character_origin_id_fkey" FOREIGN KEY (origin_id) REFERENCES public."Origin"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Character Character_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Character"
    ADD CONSTRAINT "Character_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Character Character_subclass_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Character"
    ADD CONSTRAINT "Character_subclass_id_fkey" FOREIGN KEY (subclass_id) REFERENCES public."Subclass"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ClassFeats ClassFeats_classId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassFeats"
    ADD CONSTRAINT "ClassFeats_classId_fkey" FOREIGN KEY ("classId") REFERENCES public."Class"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ClassFeats ClassFeats_featId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassFeats"
    ADD CONSTRAINT "ClassFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES public."Feat"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CursedItem CursedItem_equipmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CursedItem"
    ADD CONSTRAINT "CursedItem_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES public."Equipment"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DamageRitual DamageRitual_ritualId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DamageRitual"
    ADD CONSTRAINT "DamageRitual_ritualId_fkey" FOREIGN KEY ("ritualId") REFERENCES public."Ritual"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: GeneralFeats GeneralFeats_featId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GeneralFeats"
    ADD CONSTRAINT "GeneralFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES public."Feat"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: InventorySlot InventorySlot_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InventorySlot"
    ADD CONSTRAINT "InventorySlot_equipment_id_fkey" FOREIGN KEY (equipment_id) REFERENCES public."Equipment"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: InventorySlot InventorySlot_inventory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InventorySlot"
    ADD CONSTRAINT "InventorySlot_inventory_id_fkey" FOREIGN KEY (inventory_id) REFERENCES public."Inventory"(character_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Inventory Inventory_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory"
    ADD CONSTRAINT "Inventory_character_id_fkey" FOREIGN KEY (character_id) REFERENCES public."Character"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Notes Notes_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Notes"
    ADD CONSTRAINT "Notes_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Notes Notes_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Notes"
    ADD CONSTRAINT "Notes_character_id_fkey" FOREIGN KEY (character_id) REFERENCES public."Character"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Origin Origin_feat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Origin"
    ADD CONSTRAINT "Origin_feat_id_fkey" FOREIGN KEY (feat_id) REFERENCES public."Feat"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PlayerOnCampaign PlayerOnCampaign_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerOnCampaign"
    ADD CONSTRAINT "PlayerOnCampaign_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PlayerOnCampaign PlayerOnCampaign_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerOnCampaign"
    ADD CONSTRAINT "PlayerOnCampaign_player_id_fkey" FOREIGN KEY (player_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RitualCondition RitualCondition_condition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RitualCondition"
    ADD CONSTRAINT "RitualCondition_condition_id_fkey" FOREIGN KEY (condition_id) REFERENCES public."Condition"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RitualCondition RitualCondition_ritual_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RitualCondition"
    ADD CONSTRAINT "RitualCondition_ritual_id_fkey" FOREIGN KEY (ritual_id) REFERENCES public."Ritual"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Skill Skill_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Skill"
    ADD CONSTRAINT "Skill_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES public."Campaign"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SubclassFeats SubclassFeats_featId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubclassFeats"
    ADD CONSTRAINT "SubclassFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES public."Feat"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SubclassFeats SubclassFeats_subclassId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubclassFeats"
    ADD CONSTRAINT "SubclassFeats_subclassId_fkey" FOREIGN KEY ("subclassId") REFERENCES public."Subclass"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Subclass Subclass_classId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subclass"
    ADD CONSTRAINT "Subclass_classId_fkey" FOREIGN KEY ("classId") REFERENCES public."Class"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Weapon Weapon_equipmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Weapon"
    ADD CONSTRAINT "Weapon_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES public."Equipment"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

