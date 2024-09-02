import { CharacterUpgrade } from 'src/types/characterUpgrade-type';
import { CharacterUpgradeType } from '../dto/characterUpgrade';
import { Character, Proficiency } from '@prisma/client';
import { CharacterAtributesService } from './character.atributes.service';
import { DataBaseService } from 'src/database/database.service';
import { Injectable } from '@nestjs/common';
import { SkillJson } from 'src/types/skill-relates-types';
import { AtributesJson, StatusJson } from '../dto/create-character-dto';

@Injectable()
export class CharacterUpgradesService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly atributesService: CharacterAtributesService,
  ) {}

  async applyUpgrade(characterId: string, upgrade: CharacterUpgrade, featId: string) {
    const character = await this.dataBaseService.character.findUnique({ where: { id: characterId } });
    switch (upgrade.type) {
      case CharacterUpgradeType.PERICIA:
        await this.skillUpgrade(character, upgrade, featId);
        break;
      case CharacterUpgradeType.NUM_DE_PERICIA:
        // Implementar lógica para NUM_DE_PERICIA
        break;
      case CharacterUpgradeType.ATRIBUTO:
        await this.atributeUpgrade(character, upgrade, featId);
        break;
      case CharacterUpgradeType.DEFESA:
        await this.defenseUpgrade(character, upgrade);
        break;
      case CharacterUpgradeType.PROFICIENCIA:
        await this.proficiencyUpgrade(character, upgrade);
        break;
      case CharacterUpgradeType.RESISTENCIA:
        // Implementar lógica para RESISTENCIA
        break;
      case CharacterUpgradeType.MARGEM_DE_CRITICO:
        // Implementar lógica para MARGEM_DE_CRITICO
        break;
      case CharacterUpgradeType.MULTIPLCADOR_CRITICO_SOMA:
        // Implementar lógica para MULTIPLCADOR_CRITICO_SOMA
        break;
      case CharacterUpgradeType.MULTIPLCADOR_CRITICO_MULTIPLICA:
        // Implementar lógica para MULTIPLCADOR_CRITICO_MULTIPLICA
        break;
      case CharacterUpgradeType.LIMITE_PE:
        // Implementar lógica para LIMITE_PE
        break;
      case CharacterUpgradeType.VIDA_P_NEX:
        await this.healthPerLevelUpgrade(character, upgrade, featId);
        break;
      case CharacterUpgradeType.VIDA_MAX:
        await this.maxStatusUpgrade(character, upgrade, 'health');
        break;
      case CharacterUpgradeType.PE_P_NEX:
        await this.effortPerLevelUpgrade(character, upgrade, featId);
        break;
      case CharacterUpgradeType.PE_MAX:
        await this.maxStatusUpgrade(character, upgrade, 'effort');
        break;
      case CharacterUpgradeType.MESMO_DADO_DE_DANO_MELEE:
        // Implementar lógica para MESMO_DADO_DE_DANO_MELEE
        break;
      case CharacterUpgradeType.DADO_DE_DANO:
        // Implementar lógica para DADO_DE_DANO
        break;
      case CharacterUpgradeType.DADO_DE_DANO_EXTRA:
        // Implementar lógica para DADO_DE_DANO_EXTRA
        break;
      case CharacterUpgradeType.DEX_NO_DANO:
        // Implementar lógica para DEX_NO_DANO
        break;
      case CharacterUpgradeType.INT_NO_DANO:
        // Implementar lógica para INT_NO_DANO
        break;
      case CharacterUpgradeType.DESLOCAMENTO:
        await this.speedUpgrade(character, upgrade);
        break;
      default:
        throw new Error(`Unknown upgrade type: ${upgrade.type}`);
    }
  }

  async skillUpgrade(character: Character, upgrade: CharacterUpgrade, featId: string) {
    try {
      const skills = character.skills as SkillJson[];

      const skillIndex = skills.findIndex((skill) => skill.name === upgrade.upgradeTarget);

      if (skillIndex < 0) {
        throw new Error('Skill not found');
      }

      skills[skillIndex].value -= upgrade.upgradeValue;

      // remove previous alterations
      skills[skillIndex].alterations = skills[skillIndex].alterations.filter((alteration) => alteration.feat !== featId);

      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          skills: {
            set: skills,
          },
        },
      });
    } catch (error) {
      throw new Error('Error removing skill upgrade');
    }
  }

  async atributeUpgrade(character: Character, upgrade: CharacterUpgrade, feat: string) {
    try {
      const atribute = character.atributes as AtributesJson;

      switch (upgrade.upgradeTarget) {
        case 'strenght':
          this.atributesService.onStreghthUpdate(character.id, atribute.strenght - upgrade.upgradeValue);
          atribute.strenght -= upgrade.upgradeValue;
          break;
        case 'dexterity':
          this.atributesService.onDexterityUpdate(character.id, atribute.dexterity - upgrade.upgradeValue);
          atribute.dexterity -= upgrade.upgradeValue;
          break;
        case 'vitality':
          this.atributesService.onVitalityUpdate(character.id, atribute.vitality - upgrade.upgradeValue, atribute.vitality);
          atribute.vitality -= upgrade.upgradeValue;
          break;
        case 'intelligence':
          this.atributesService.onIntelligenceUpdate(character.id, atribute.intelligence - upgrade.upgradeValue + atribute.intelligence);
          atribute.intelligence -= upgrade.upgradeValue;
          break;
        case 'presence':
          this.atributesService.onPresenceUpdate(character.id, atribute.presence - upgrade.upgradeValue, atribute.presence);
          atribute.presence -= upgrade.upgradeValue;
          break;
        default:
          throw new Error('Atribute not found');
      }

      atribute.alterations = atribute.alterations.filter((alteration) => alteration.feat !== feat);

      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          atributes: {
            set: atribute,
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying atribute upgrade');
    }
  }

  async defenseUpgrade(character: Character, upgrade: CharacterUpgrade) {
    try {
      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          defense: {
            decrement: upgrade.upgradeValue,
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying defense upgrade');
    }
  }

  async proficiencyUpgrade(character: Character, upgrade: CharacterUpgrade) {
    try {
      if (!upgrade.upgradeTarget || typeof upgrade.upgradeTarget !== 'string') {
        throw new Error('Proficiency not found');
      }

      const proficiencies = character.proficiencies as Proficiency[];

      // check if the character doesnt have the proficiency
      if (!proficiencies.includes(upgrade.upgradeTarget as Proficiency)) {
        return;
      }

      // filter the proficiency from the list
      proficiencies.filter((proficiency) => proficiency !== upgrade.upgradeTarget);

      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          proficiencies: {
            set: proficiencies,
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying proficiency upgrade');
    }
  }

  async maxStatusUpgrade(character: Character, upgrade: CharacterUpgrade, status: 'health' | 'effort') {
    try {
      switch (status) {
        case 'health':
          await this.dataBaseService.character.update({
            where: { id: character.id },
            data: {
              max_health: {
                decrement: upgrade.upgradeValue,
              },
              current_health: {
                decrement: upgrade.upgradeValue,
              },
            },
          });
          break;

        case 'effort':
          await this.dataBaseService.character.update({
            where: { id: character.id },
            data: {
              max_effort: {
                decrement: upgrade.upgradeValue,
              },
              current_effort: {
                decrement: upgrade.upgradeValue,
              },
            },
          });
          break;

        default:
          throw new Error('Status not found');
      }
    } catch (error) {
      throw new Error('Error applying max status upgrade');
    }
  }

  async healthPerLevelUpgrade(character: Character, upgrade: CharacterUpgrade, featId: string) {
    try {
      // calculate the life to increment
      const healthInfo = character.healthInfo as StatusJson;
      const valueDiff = healthInfo.valuePerLevel - upgrade.upgradeValue;
      const valueToIncrement = valueDiff * character.level;

      healthInfo.alterations = healthInfo.alterations.filter((alteration) => alteration.feat !== featId);
      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          current_health: {
            increment: valueToIncrement,
          },

          max_health: {
            increment: valueToIncrement,
          },

          healthInfo: {
            valuePerLevel: {
              increment: upgrade.upgradeValue,
            },
            alterations: {
              push: healthInfo.alterations,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying status per level upgrade');
    }
  }
  async effortPerLevelUpgrade(character: Character, upgrade: CharacterUpgrade, featId: string) {
    try {
      const sanityInfo = character.sanityInfo as StatusJson;
      const sanityDiff = sanityInfo.valuePerLevel - upgrade.upgradeValue;
      const sanityToIncrement = sanityDiff * character.level;

      const alterationObject = sanityInfo.alterations.filter((alteration) => alteration.feat !== featId);
      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          current_sanity: {
            increment: sanityToIncrement,
          },
          max_sanity: {
            increment: sanityToIncrement,
          },
          sanityInfo: {
            valuePerLevel: {
              increment: upgrade.upgradeValue,
            },
            alterations: {
              push: alterationObject,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying sanity per level upgrade');
    }
  }

  async speedUpgrade(character: Character, upgrade: CharacterUpgrade) {
    try {
      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          speed: {
            decrement: upgrade.upgradeValue,
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying speed upgrade');
    }
  }
}
