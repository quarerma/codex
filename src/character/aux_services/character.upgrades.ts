import { Character, Feat, Proficiency } from '@prisma/client';
import { CharacterUpgradeType } from '../dto/characterUpgrade';
import { DataBaseService } from 'src/database/database.service';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';
import { Injectable } from '@nestjs/common';
import { SkillJson } from 'src/types/skill-relates-types';
import { AtributesJson, StatusJson } from '../dto/create-character-dto';
import { CharacterAtributesService } from './character.atributes.service';

@Injectable()
export class CharacterUpgradesService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly atributesService: CharacterAtributesService,
  ) {}

  async applyUpgrade(character: Character, upgrade: CharacterUpgrade, feat: Feat) {
    switch (upgrade.type) {
      case CharacterUpgradeType.PERICIA:
        await this.skillUpgrade(character, upgrade, feat);
        break;
      case CharacterUpgradeType.NUM_DE_PERICIA:
        // Implementar lógica para NUM_DE_PERICIA
        break;
      case CharacterUpgradeType.ATRIBUTO:
        await this.atributeUpgrade(character, upgrade, feat);
        break;
      case CharacterUpgradeType.DEFESA:
        // Implementar lógica para DEFESA
        break;
      case CharacterUpgradeType.PROFICIENCIA:
        await this.proficienciaUpgrade(character, upgrade);
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
        await this.statusPerLevelUpgrade(character, upgrade, 'health', feat);
        break;
      case CharacterUpgradeType.VIDA_MAX:
        await this.maxStatusUpgrade(character, upgrade, 'health');
        break;
      case CharacterUpgradeType.PE_P_NEX:
        // Implementar lógica para PE_P_NEX
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
        // Implementar lógica para DESLOCAMENTO
        break;
      default:
        throw new Error(`Unknown upgrade type: ${upgrade.type}`);
    }
  }

  async skillUpgrade(character: Character, upgrade: CharacterUpgrade, feat: Feat) {
    try {
      const skills = character.skills as SkillJson[];

      const skillIndex = skills.findIndex((skill) => skill.name === upgrade.upgradeTarget);

      if (skillIndex < 0) {
        throw new Error('Skill not found');
      }

      skills[skillIndex].value += upgrade.upgradeValue;

      skills[skillIndex].alterations.push({
        feat: feat.id,
        featName: feat.name,
        value: upgrade.upgradeValue,
      });

      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          skills: {
            set: skills,
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying skill upgrade');
    }
  }

  async atributeUpgrade(character: Character, upgrade: CharacterUpgrade, feat: Feat) {
    try {
      const atribute = character.atributes as AtributesJson;

      switch (upgrade.upgradeTarget) {
        case 'strenght':
          this.atributesService.onStreghthUpdate(character.id, upgrade.upgradeValue);
          atribute.strenght += upgrade.upgradeValue;
          break;
        case 'dexterity':
          this.atributesService.onDexterityUpdate(character.id, upgrade.upgradeValue);
          atribute.dexterity += upgrade.upgradeValue;
          break;
        case 'vitality':
          this.atributesService.onVitalityUpdate(character.id, upgrade.upgradeValue, atribute.vitality);
          atribute.vitality += upgrade.upgradeValue;
          break;
        case 'intelligence':
          this.atributesService.onIntelligenceUpdate(character.id, upgrade.upgradeValue);
          atribute.intelligence += upgrade.upgradeValue;
          break;
        case 'presence':
          this.atributesService.onPresenceUpdate(character.id, upgrade.upgradeValue, atribute.presence);
          atribute.presence += upgrade.upgradeValue;
          break;
        default:
          throw new Error('Atribute not found');
      }

      atribute.alterations.push({
        feat: feat.id,
        featName: feat.name,
      });

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

  async proficienciaUpgrade(character: Character, upgrade: CharacterUpgrade) {
    try {
      if (!upgrade.upgradeTarget || typeof upgrade.upgradeTarget !== 'string') {
        throw new Error('Proficiency not found');
      }

      const proficiencies = character.proficiencies as Proficiency[];

      // check if the character already has the proficiency
      if (proficiencies.includes(upgrade.upgradeTarget as Proficiency)) {
        return;
      }

      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          proficiencies: {
            push: upgrade.upgradeTarget as Proficiency,
          },
        },
      });
    } catch (error) {
      throw new Error('Error applying proficiencia upgrade');
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
                increment: upgrade.upgradeValue,
              },
              current_health: {
                increment: upgrade.upgradeValue,
              },
            },
          });
          break;

        case 'effort':
          await this.dataBaseService.character.update({
            where: { id: character.id },
            data: {
              max_effort: {
                increment: upgrade.upgradeValue,
              },
              current_effort: {
                increment: upgrade.upgradeValue,
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

  async statusPerLevelUpgrade(character: Character, upgrade: CharacterUpgrade, status: 'health' | 'effort', feat: Feat) {
    try {
      const alterationObject = {
        feat: feat.id,
        featName: feat.name,
      };
      switch (status) {
        case 'health':
          // calculate the life to increment
          const healthInfo = character.healthInfo as StatusJson;
          const valueDiff = upgrade.upgradeValue - healthInfo.valuePerLevel;
          const valueToIncrement = valueDiff * character.level;

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
                  push: alterationObject,
                },
              },
            },
          });
          break;

        case 'effort':
          const effortInfo = character.effortInfo as StatusJson;
          const effortDiff = upgrade.upgradeValue - effortInfo.valuePerLevel;
          const effortToIncrement = effortDiff * character.level;

          await this.dataBaseService.character.update({
            where: { id: character.id },
            data: {
              max_effort: {
                increment: effortToIncrement,
              },
              current_effort: {
                increment: effortToIncrement,
              },
              effortInfo: {
                valuePerLevel: {
                  increment: upgrade.upgradeValue,
                },
                alterations: {
                  push: alterationObject,
                },
              },
            },
          });
          break;

        default:
          throw new Error('Status not found');
      }
    } catch (error) {
      throw new Error('Error applying status per level upgrade');
    }
  }
}
