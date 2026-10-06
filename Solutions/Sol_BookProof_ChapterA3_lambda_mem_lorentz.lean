-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.lambda_mem_lorentz
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_hasLambda_LambdaOf
import Theorems.Thm_BookProof_ChapterA3_lorentz_of_conjR
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℝ) (hS : IsPin S) :
    LambdaOf S ∈ LorentzO := lorentz_of_conjR S hS.1 _ (hasLambda_LambdaOf S hS.2.2)
