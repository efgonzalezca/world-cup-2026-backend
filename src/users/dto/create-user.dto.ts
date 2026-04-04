import { IsEmail, IsNotEmpty, IsString, MaxLength, MinLength, Matches } from 'class-validator';

export class CreateUserDto {
  @IsEmail({}, { message: 'Formato de correo electronico invalido' })
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  @MaxLength(20)
  @Matches(/^\S+$/, { message: 'El nickname no puede contener espacios' })
  nickname: string;

  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  names: string;

  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  surnames: string;

  @IsString()
  @IsNotEmpty()
  @Matches(/^3\d{9}$/, { message: 'El celular debe ser colombiano (inicia con 3, 10 digitos)' })
  cellphone: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  password: string;
}
