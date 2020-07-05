import { NativeModules } from 'react-native';

const { Md5File: { hashFileMD5, hashFileSHA1, hashFileSHA512, hashFileCRC32 } } = NativeModules;

export default (...args) => {
  let algo = 'md5';
  let path;
  let output = 'hex';
  if (args.length === 1) {
    path = args[0];
  } else if (args.length >= 2) {
    algo = args[0];
    path = args[1];
    if (args.length >= 3) output = args[2];
  } else {
    throw new Error('Invalid arguments!');
  }
  if (output !== 'hex' && output !== 'base64') throw new Error('Invalid output type!');
  return new Promise((resolve, reject) => {
    switch (algo) {
      case 'md5':
        return hashFileMD5(path, output, (_, hash) => resolve(hash));
      case 'sha1':
        return hashFileSHA1(path, output, (_, hash) => resolve(hash));
      case 'sha512':
        return hashFileSHA512(path, output, (_, hash) => resolve(hash));
      case 'crc32':
        return hashFileCRC32(path, output, (_, hash) => resolve(hash));
      default: reject(new Error('Invalid algorithm!'));
    }
  });
    // .then((hash) => {
    //   switch (output) {
    //     case 'hex':
    //       return hash;
    //     case 'base64':
    //       return base64.encode(hash);
    //   }
    // });
};
