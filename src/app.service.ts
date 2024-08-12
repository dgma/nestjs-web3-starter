import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(network: string) {
    return `Hello World! ${network}`;
  }
}
