import { IsInt, Min, Max, IsNotEmpty } from 'class-validator';

export class UpdatePredictionDto {
  @IsInt()
  @Min(0)
  @Max(30)
  @IsNotEmpty()
  local_score: number;

  @IsInt()
  @Min(0)
  @Max(30)
  @IsNotEmpty()
  visitor_score: number;
}
