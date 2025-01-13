import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { NotesService } from './notes.service';
import { CreateNoteDTO } from './dto/create.note.dto';
import { UpdateNoteDTO } from './dto/update.note.dto';

@Controller('notes')
export class NotesController {
  constructor(private readonly notesService: NotesService) {}

  @Post()
  async createNote(@Body() body: CreateNoteDTO) {
    return await this.notesService.createNote(body);
  }

  @Get('character')
  async getCharacterNotes(@Query() characterId: string) {
    return await this.notesService.getCharacterNotes(characterId);
  }

  @Get('campaign')
  async getCampaignNotes(@Query() campaignId: string) {
    return await this.notesService.getCampaignNotes(campaignId);
  }

  @Post('update')
  async updateNote(@Query() noteId: string, @Body() body: UpdateNoteDTO) {
    return await this.notesService.updateNote(noteId, body);
  }
}
