-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.lambdaOf_omegaG05
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_hasLambda_omegaG05
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaG05
import Theorems.Thm_BookProof_ChapterA3_hasLambda_LambdaOf
import Theorems.Thm_BookProof_ChapterA3_hasLambda_unique
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : LambdaOf omegaG05 = -minkowskiMat := hasLambda_unique (hasLambda_LambdaOf _ isPin_omegaG05.2.2) hasLambda_omegaG05
