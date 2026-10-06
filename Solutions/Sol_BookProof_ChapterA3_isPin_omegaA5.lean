-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.isPin_omegaA5
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_isPin_of_sq_neg_one
import Theorems.Thm_BookProof_ChapterA3_omegaA5_sq
import Theorems.Thm_BookProof_ChapterA3_hasLambda_omegaA5
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsPin omegaA5 := isPin_of_sq_neg_one omegaA5_sq ⟨_, hasLambda_omegaA5⟩
