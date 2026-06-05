import { IsOptional, IsString, Length, ValidateIf } from 'class-validator';

export class AssignTeamsDto {
  @IsOptional()
  @ValidateIf((_, value) => value !== null)
  @IsString()
  @Length(2, 10)
  local_team_id?: string | null;

  @IsOptional()
  @ValidateIf((_, value) => value !== null)
  @IsString()
  @Length(2, 10)
  visiting_team_id?: string | null;
}