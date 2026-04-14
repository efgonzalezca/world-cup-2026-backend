import { IsOptional, IsString, MinLength, MaxLength } from 'class-validator';

export class UpdateUserDto {
  @IsOptional()
  @IsString()
  @MinLength(3)
  @MaxLength(20)
  nickname?: string;

  @IsOptional()
  @IsString()
  @MinLength(6)
  @MaxLength(64)
  password?: string;

  @IsOptional()
  @IsString()
  @MaxLength(10)
  champion_team_id?: string;

  @IsOptional()
  @IsString()
  @MaxLength(10)
  runner_up_team_id?: string;

  @IsOptional()
  @IsString()
  @MaxLength(10)
  third_place_team_id?: string;
}
