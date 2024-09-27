import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }

  getStatus(): object {
    return {
      timestamp: (new Date()).toISOString(),
      message: 'OK',
    };
  }
}
