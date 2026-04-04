import { IsEmail, IsNotEmpty } from 'class-validator';

export class ResetPasswordDto {
  @IsEmail({}, { message: 'Formato de correo electronico invalido' })
  @IsNotEmpty()
  email: string;
}
