# World Cup 2026 - Backend

API REST y servidor WebSocket para la polla mundialista FIFA World Cup 2026.

## Stack Tecnologico

- **Framework**: NestJS 11 (Node.js)
- **Base de datos**: PostgreSQL 16
- **ORM**: TypeORM 0.3
- **Autenticacion**: JWT (Passport.js)
- **WebSocket**: Socket.io
- **Validacion**: class-validator + class-transformer
- **Testing**: Jest
- **Lenguaje**: TypeScript 5

## Arquitectura

```
src/
├── app-config/        # Configuracion dinamica desde BD (ej. deadline podio)
│   ├── entities/      # AppConfig entity (key-value store)
│   ├── app-config.service.ts
│   ├── app-config.controller.ts
│   └── app-config.module.ts
├── auth/              # Autenticacion JWT
│   ├── strategies/    # JWT Strategy (Passport)
│   ├── dto/           # LoginDto
│   ├── auth.service.ts
│   └── auth.controller.ts
├── users/             # Usuarios, predicciones y podio
│   ├── entities/      # User, UserMatch, UserPodium
│   ├── dto/           # CreateUser, UpdateUser, UpdatePrediction, ResetPassword
│   ├── users.service.ts
│   └── users.controller.ts
├── matches/           # Partidos y calculo de puntos
│   ├── entities/      # Match
│   ├── dto/           # UpdateResult
│   ├── scoring.ts     # Logica pura de puntuacion (max 7 pts/partido)
│   ├── scoring.spec.ts
│   ├── matches.service.ts
│   └── matches.controller.ts
├── teams/             # Equipos y grupos del torneo
│   ├── entities/      # Team, TournamentGroup
│   ├── teams.service.ts
│   └── teams.controller.ts
├── events/            # WebSocket Gateway (Socket.io, JWT auth)
│   └── events.gateway.ts
├── seed/              # Seed de datos del torneo
│   └── seed.service.ts
├── common/            # Guards, decoradores, filtros
│   ├── guards/        # RolesGuard (RBAC)
│   ├── decorators/    # @Roles()
│   └── filters/       # HttpExceptionFilter
└── config/            # Configuracion de base de datos
```

## Modelo de Datos

| Entidad | Descripcion |
|---------|-------------|
| **User** | Usuarios del sistema (email, nickname, rol admin/user, score, podium_score, avatar base64) |
| **UserMatch** | Prediccion de un usuario para un partido (local_score, visitor_score, points, discriminated_points JSONB) |
| **UserPodium** | Prediccion de podio (champion, runner_up, third_place) |
| **Match** | Partido del torneo (fase, fecha, equipos, resultado, has_played) |
| **Team** | Seleccion nacional (48 equipos, ranking FIFA, grupo) |
| **TournamentGroup** | Grupo del torneo (A-L, 12 grupos) |
| **AppConfig** | Configuracion key-value (ej. podium_deadline) |

## API Endpoints

### Autenticacion
| Metodo | Ruta | Descripcion |
|--------|------|-------------|
| POST | `/auth/login` | Login con email/password, retorna JWT |

### Usuarios
| Metodo | Ruta | Auth | Descripcion |
|--------|------|------|-------------|
| POST | `/users` | No | Registro de usuario |
| GET | `/users` | JWT | Ranking de usuarios activos |
| PATCH | `/users/:userId` | JWT | Actualizar perfil (nickname, password, podio) |
| POST | `/users/:userId/avatar` | JWT | Subir avatar (base64, max 1MB) |
| POST | `/users/reset-password` | No | Solicitar contrasena temporal |
| GET | `/users/:userId/matches/all` | JWT | Todas las predicciones del usuario |
| GET | `/users/matches/:matchId` | JWT | Predicciones de todos los participantes para un partido |
| PATCH | `/users/:userId/matches/:matchId` | JWT | Actualizar prediccion de un partido |

### Partidos
| Metodo | Ruta | Auth | Descripcion |
|--------|------|------|-------------|
| GET | `/matches?phase=` | JWT | Listar partidos (filtro opcional por fase) |
| PATCH | `/matches/:matchId` | Admin | Registrar resultado de un partido |

### Equipos
| Metodo | Ruta | Auth | Descripcion |
|--------|------|------|-------------|
| GET | `/teams?group=` | JWT | Listar equipos (filtro opcional por grupo) |
| GET | `/teams/groups` | JWT | Listar grupos con equipos |

### Configuracion
| Metodo | Ruta | Auth | Descripcion |
|--------|------|------|-------------|
| GET | `/config/podium-deadline` | No | Obtener fecha limite de podio |
| GET | `/config` | Admin | Listar toda la configuracion |
| PATCH | `/config` | Admin | Actualizar un valor de configuracion |

## Sistema de Puntuacion (max 7 pts/partido)

| Concepto | Puntos |
|----------|--------|
| Acertar resultado (G/E/P) | 2 |
| Acertar goles equipo local | 1 |
| Acertar goles equipo visitante | 1 |
| Bonus marcador exacto | 3 |
| Bonus empate no exacto | 1 |

- **Bonus empate**: Se otorga cuando predices empate, el resultado es empate, pero no aciertas el marcador exacto
- **Puntos de podio**: Campeon (30), Subcampeon (20), Tercer lugar (10)

## Validaciones de Seguridad

- **Predicciones de partidos**: No se pueden modificar despues de `match_date` (validacion server-side)
- **Predicciones de podio**: No se pueden modificar despues de `podium_deadline` (configurable en BD)
- **Autorizacion**: Cada usuario solo puede modificar sus propios datos
- **RBAC**: Endpoints admin protegidos con `@Roles('admin')` + `RolesGuard`
- **Password**: Hash con bcrypt, contrasenas temporales con expiracion de 15 min
- **Avatares**: Validacion de formato base64, tamano maximo 1MB y deteccion de patrones XSS (scripts, event handlers)
- **WebSocket**: Conexiones autenticadas con JWT; se rechaza cualquier conexion sin token valido
- **Variables de entorno**: Sin valores hardcodeados; se usa `ConfigService.getOrThrow()` para secretos obligatorios

## WebSocket Events

| Evento | Direccion | Descripcion |
|--------|-----------|-------------|
| `prediction.saved` | Server -> Client | Un usuario guardo una prediccion |
| `match.prediction.updated` | Server -> Client | Predicciones de un partido actualizadas |
| `match.result.updated` | Server -> Client | Resultado de un partido registrado |
| `ranking.updated` | Server -> Client | Ranking actualizado |
| `profile.updated` | Server -> Client | Avatar de usuario actualizado |
| `force.logout` | Server -> Client | Forzar logout (cambio de contrasena) |

## Configuracion

### Variables de Entorno

```env
# Base de datos
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=wc2026_user
DB_PASSWORD=wc2026_pass
DB_DATABASE=world_cup_2026

# JWT
JWT_SECRET=your_secret_key
JWT_EXPIRATION=6h

# Seguridad
SALT_ROUNDS=10

# CORS
CORS_ORIGIN=http://localhost:5173

# Email (opcional)
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USER=
MAIL_PASS=
MAIL_FROM=noreply@worldcup2026.com
```

## Requisitos

- **Node.js** >= 22.0.0
- **npm** >= 10.0.0
- **PostgreSQL** 16 (incluido en Docker Compose)

## Ejecucion con Docker (recomendado)

```bash
# 1. Copiar variables de entorno
cp .env.template .env

# 2. Editar .env con los valores deseados
nano .env

# 3. Levantar PostgreSQL + Backend
docker compose up -d

# 4. Ver logs
docker compose logs -f backend
```

Esto levanta **2 contenedores**:
| Servicio | Puerto | Descripcion |
|----------|--------|-------------|
| `postgres` | 5432 | PostgreSQL 16 Alpine |
| `backend` | 3000 | NestJS en modo watch (hot reload) |

Para detener:
```bash
docker compose down          # Detiene contenedores (preserva datos)
docker compose down -v       # Detiene y ELIMINA volumenes (reset BD)
```

## Ejecucion local (sin Docker)

Requiere PostgreSQL corriendo por separado.

```bash
# 1. Copiar y configurar variables de entorno
cp .env.template .env

# 2. Instalar dependencias
npm install

# 3. Desarrollo (watch mode)
npm run start:dev

# 4. Produccion
npm run build
npm run start:prod
```

## Tests

```bash
npm test              # Ejecutar tests
npm run test:watch    # Tests en modo watch
npm run test:cov      # Tests con coverage
```

## Seed de Datos

El seed **no** se ejecuta automaticamente al iniciar la aplicacion. Se gestiona mediante scripts de npm:

```bash
# Seed base: grupos, equipos, partidos y configuracion inicial
npm run seed

# Seed de pruebas: usuarios ficticios con predicciones (solo desarrollo)
npm run seed:test-data
```

### Seed base (`npm run seed`)
Si la base de datos esta vacia, siembra:
- 12 grupos (A-L)
- 48 equipos con ranking FIFA oficial
- 104 partidos (72 fase de grupos + 32 eliminatorias)
- Configuracion inicial (`podium_deadline`: 2026-07-14)

### Seed de pruebas (`npm run seed:test-data`)
Carga datos de prueba para desarrollo:
- Usuarios ficticios con predicciones aleatorias
- Util para probar el ranking y las vistas de partidos con datos realistas

> **Nota:** Ejecutar primero `npm run seed` antes de `npm run seed:test-data`.

## Documentacion API

La coleccion Postman se encuentra en [`docs/postman-collection.json`](docs/postman-collection.json). Importar en Postman:
1. File > Import > seleccionar el archivo
2. Cambiar la variable `{{baseUrl}}` si el backend no corre en `http://localhost:3000`
3. Ejecutar el request **Login** para autenticar (el token se setea automaticamente)
