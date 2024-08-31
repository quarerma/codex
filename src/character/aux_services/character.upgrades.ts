import { Character, Feat } from '@prisma/client';
import { CharacterUpgradeType } from '../dto/characterUpgrade';
import { DataBaseService } from 'src/database/database.service';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';
import { Injectable } from '@nestjs/common';
import { SkillJson } from 'src/types/skill-relates-types';

@Injectable()
export class CharacterUpgradesService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async applyUpgrade(character: Character, upgrade: CharacterUpgrade, feat: Feat) {
    switch (upgrade.type) {
      case CharacterUpgradeType.PERICIA:
        await this.skillUpgrade(character, upgrade, feat);
        break;
      case CharacterUpgradeType.NUM_DE_PERICIA:
        // Implementar lógica para NUM_DE_PERICIA
        break;
      case CharacterUpgradeType.ATRIBUTO:
        // Implementar lógica para ATRIBUTO
        break;
      case CharacterUpgradeType.DEFESA:
        // Implementar lógica para DEFESA
        break;
      case CharacterUpgradeType.PROFICIENCIA:
        // Implementar lógica para PROFICIENCIA
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
        // Implementar lógica para VIDA_P_NEX
        break;
      case CharacterUpgradeType.VIDA_MAX:
        // Implementar lógica para VIDA_MAX
        break;
      case CharacterUpgradeType.PE_P_NEX:
        // Implementar lógica para PE_P_NEX
        break;
      case CharacterUpgradeType.PE_MAX:
        // Implementar lógica para PE_MAX
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
}
