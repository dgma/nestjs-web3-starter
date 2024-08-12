import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AppService {
  private network: string;

  constructor(private readonly configService: ConfigService) {
    this.network = this.configService.get<string>('network')!;
  }
  getHello() {
    return `Hello World! ${this.network}`;
  }
}
