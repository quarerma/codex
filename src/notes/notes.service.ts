import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateNoteDTO } from './dto/create.note.dto';
import { UpdateNoteDTO } from './dto/update.note.dto';

@Injectable()
export class NotesService {
  constructor(private readonly databaseService: DataBaseService) {}

  async createNote(body: CreateNoteDTO) {
    return await this.databaseService.notes.create({
      data: body,
    });
  }

  async getCharacterNotes(characterId: string) {
    return await this.databaseService.notes.findMany({
      where: {
        characterId,
      },
    });
  }

  async getCampaignNotes(campaignId: string) {
    return await this.databaseService.notes.findMany({
      where: {
        campaignId,
      },
    });
  }

  async updateNote(noteId: string, body: UpdateNoteDTO) {
    return await this.databaseService.notes.update({
      where: {
        id: noteId,
      },
      data: body,
    });
  }

  async deleteNote(noteId: string) {
    return await this.databaseService.notes.delete({
      where: {
        id: noteId,
      },
    });
  }
}
