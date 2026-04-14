import { IsInt, Min, Max, IsNotEmpty } from 'class-validator';

export class UpdateResultDto {
  @IsInt()
  @Min(0)
  @Max(30)
  @IsNotEmpty()
  local_result: number;

  @IsInt()
  @Min(0)
  @Max(30)
  @IsNotEmpty()
  visiting_result: number;
}
