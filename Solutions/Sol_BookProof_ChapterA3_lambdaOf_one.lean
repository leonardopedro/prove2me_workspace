-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.lambdaOf_one
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_hasLambda_one
import Theorems.Thm_BookProof_ChapterA3_isPin_one
import Theorems.Thm_BookProof_ChapterA3_hasLambda_LambdaOf
import Theorems.Thm_BookProof_ChapterA3_hasLambda_unique
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : LambdaOf (1 : Matrix (Fin 4) (Fin 4) ℝ) = 1 := hasLambda_unique (hasLambda_LambdaOf _ isPin_one.2.2) hasLambda_one
