# c-rsa-sha256-pow-votechain

A C-based educational blockchain voting engine that combines:
- RSA key generation and message signing
- Signed vote declarations
- Vote validation and winner computation
- Proof-of-Work block production
- Longest-chain consensus for trusted tallying

## What This Project Does
This project simulates a blockchain-backed election workflow:
1. Generate voter/candidate RSA keys.
2. Produce signed vote declarations (`Protected`).
3. Verify signatures and reject fraudulent declarations.
4. Group declarations into blocks.
5. Mine blocks with SHA-256 Proof-of-Work.
6. Build a block tree and trust the longest chain.
7. Compute the winner from trusted declarations only.

## Technology Stack
- **Language:** C (GNU11)
- **Cryptography:** OpenSSL SHA-256 (`-lssl -lcrypto`)
- **Asymmetric crypto model:** RSA-like educational implementation
- **Consensus model:** Simplified Proof-of-Work with leading-hex-zero difficulty
- **Data structures:**
  - Linked lists for keys/declarations
  - Hash tables for duplicate detection and vote counting
  - Block tree for fork handling and longest-chain selection

## Architecture
Core modules live in [`lib/`](./lib):
- [`security.c`](./lib/security.c): primality, modular arithmetic, number theory helpers
- [`rsa.c`](./lib/rsa.c): keypair generation, encrypt/decrypt primitives
- [`sign.c`](./lib/sign.c): signatures, `Protected` declarations, verification
- [`dataio.c`](./lib/dataio.c): read/write election data and directory lifecycle
- [`vote.c`](./lib/vote.c): hashtable-backed winner computation
- [`blockchain.c`](./lib/blockchain.c): block serialization, PoW, block tree, trusted-chain tallying

Test executables live in [`test/`](./test):
- Unit and integration-style tests per module
- End-to-end election scenario in [`question96.c`](./test/question96.c)
- Optional performance harness in [`perf.c`](./test/perf.c)

Additional project report artifacts are in [`docs/`](./docs).

## Build and Test
### Prerequisites
- GCC-compatible toolchain
- GNU Make (or `mingw32-make` on Windows)
- OpenSSL development libraries

### Build
Linux/macOS:
```bash
make
```

Windows (MSYS2/MinGW):
```powershell
mingw32-make
```

### Run Tests
Linux/macOS:
```bash
make test
```

Windows:
```powershell
mingw32-make test
```

### Run Tests Under Valgrind (Linux)
```bash
make test VALGRIND=1
```

### Enable Performance Tests
```bash
make test PERFORMANCETESTS=1
```

## Runtime Data Layout
Generated runtime files are created under [`data/`](./data):
- `data/blockchain/`: persisted validated blocks
- `data/pending_block`: latest mined candidate block
- `data/pending_votes.txt`: queued declarations waiting to be mined
- `data/temp/`: temporary test artifacts

## End-to-End Demo
The test binary [`test/question96.c`](./test/question96.c) demonstrates:
- random election generation,
- incremental block creation,
- blockchain reconstruction from disk,
- trusted winner extraction from the longest chain.

## Notes on Scope
This repository is designed for **education and experimentation**, not production voting systems.

Important simplifications:
- non-hardened key sizes and randomness model
- no network protocol / distributed peer layer
- no Byzantine fault-tolerant finality
- PoW cost/difficulty model is intentionally simplified

## Professionalization Changes Included
- Standardized project layout (`lib/`, `test/`, `docs/`, `data/`)
- Reworked Makefiles for reliable local builds/tests
- Cross-platform portability fixes (Windows + Unix behavior)
- Cleaner `.gitignore` and tracked runtime directory placeholders
- Detailed technical README and clearer project positioning
