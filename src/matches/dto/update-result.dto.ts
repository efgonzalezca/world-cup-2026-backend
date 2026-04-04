import { IsInt, Min, IsNotEmpty } from 'class-validator';

export class UpdateResultDto {
  @IsInt()
  @Min(0)
  @IsNotEmpty()
  local_result: number;

  @IsInt()
  @Min(0)
  @IsNotEmpty()
  visiting_result: number;
}
