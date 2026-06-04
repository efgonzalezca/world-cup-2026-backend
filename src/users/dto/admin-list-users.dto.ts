import { IsOptional, IsInt, IsString, IsIn, Min, Max, MaxLength } from 'class-validator';
import { Type } from 'class-transformer';

export class AdminListUsersDto {
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  page?: number = 1;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number = 20;

  @IsOptional()
  @IsString()
  @MaxLength(100)
  search?: string;

  @IsOptional()
  @IsIn(['active', 'inactive', 'all'])
  status?: 'active' | 'inactive' | 'all' = 'all';

  @IsOptional()
  @IsIn(['admin', 'user'])
  role?: 'admin' | 'user';
}