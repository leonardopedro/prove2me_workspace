-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.lambdaOf_neg
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_hasLambda_LambdaOf
import Theorems.Thm_BookProof_ChapterA3_hasLambda_unique
import Theorems.Thm_BookProof_ChapterA3_hasLambda_neg
import Theorems.Thm_BookProof_ChapterA3_isPin_neg
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {S : Matrix (Fin 4) (Fin 4) ℝ} (h : IsPin S) :
    LambdaOf (-S) = LambdaOf S := by

  apply hasLambda_unique (hasLambda_LambdaOf _ (isPin_neg h).2.2)
  exact hasLambda_neg (hasLambda_LambdaOf _ h.2.2)
