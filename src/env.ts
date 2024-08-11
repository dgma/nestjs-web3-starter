import * as dotenvx from '@dotenvx/dotenvx';
import { Hex } from 'viem';
import * as viemChains from 'viem/chains';

if (!process.env.NODE_ENV) {
  // load env in case of running outside docker
  dotenvx.config({ path: 'conf/.env' });
}

if (process.env.NODE_ENV === 'production') {
  // decrypted .production.secrets.env file
  // more info https://github.com/dotenvx/dotenvx
  dotenvx.config({ path: '/run/secrets/keys' });
  dotenvx.decrypt('conf/.production.secrets.env');
  dotenvx.config({ path: 'conf/.production.secrets.env' });
}

if (process.env.NODE_ENV !== 'production') {
  dotenvx.config({ path: 'conf/.local.secrets.env' });
}

const chains = {
  arbitrumSepolia: viemChains.arbitrumSepolia,
  localhost: viemChains.localhost,
} as const;

export type SupportedChains = keyof typeof chains;

export default () => ({
  privateKey: process.env.PRIVATE_KEY as Hex,
  rpc: process.env.RPC!,
  ws_rpc: process.env.WS_RPC!,
  network: (process.env.NETWORK || 'localhost') as SupportedChains,
  chains,
});
