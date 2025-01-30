import { WebSocketGateway, WebSocketServer, SubscribeMessage, MessageBody, ConnectedSocket } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { DataBaseService } from 'src/database/database.service';
import { DieRoll } from './types/die.roll';

@WebSocketGateway({
  cors: {
    origin: '*', // Replace with your frontend's URL for production
    methods: ['GET', 'POST'],
    credentials: true,
  },
  port: 3000,
})
export class SocketsGateway {
  @WebSocketServer() server: Server;
  constructor(private readonly dataBaseService: DataBaseService) {}

  // Handle incoming messages from clients
  @SubscribeMessage('sendMessage')
  handleMessage(@MessageBody() data: DieRoll, @ConnectedSocket() client: Socket): void {
    // Broadcast the message to all clients in the character's room

    console.log(data);
    this.server.to(data.campaignId).emit('receiveMessage', data);
  }

  // Handle client connection to a specific character room
  @SubscribeMessage('joinCampaignRoom')
  handleJoinRoom(@MessageBody() campaingId: string, @ConnectedSocket() client: Socket): void {
    console.log(`Client joined room: ${campaingId}`);
    client.join(campaingId); // Join the room for the specific character ID
  }

  // Handle client disconnection
  handleDisconnect(client: Socket): void {
    console.log(`Client disconnected: ${client.id}`);
  }
}
