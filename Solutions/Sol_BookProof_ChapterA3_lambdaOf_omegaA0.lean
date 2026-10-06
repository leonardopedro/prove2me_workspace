-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.lambdaOf_omegaA0
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_hasLambda_omegaA0
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaA0
import Theorems.Thm_BookProof_ChapterA3_hasLambda_LambdaOf
import Theorems.Thm_BookProof_ChapterA3_hasLambda_unique
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : LambdaOf omegaA0 = minkowskiMat := hasLambda_unique (hasLambda_LambdaOf _ isPin_omegaA0.2.2) hasLambda_omegaA0
