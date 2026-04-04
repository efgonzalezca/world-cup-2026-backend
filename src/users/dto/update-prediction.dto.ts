import { IsInt, Min, IsNotEmpty } from 'class-validator';

export class UpdatePredictionDto {
  @IsInt()
  @Min(0)
  @IsNotEmpty()
  local_score: number;

  @IsInt()
  @Min(0)
  @IsNotEmpty()
  visitor_score: number;
}
