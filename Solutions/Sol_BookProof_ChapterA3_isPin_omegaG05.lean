-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.isPin_omegaG05
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_isPin_of_sq_neg_one
import Theorems.Thm_BookProof_ChapterA3_omegaG05_sq
import Theorems.Thm_BookProof_ChapterA3_hasLambda_omegaG05
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsPin omegaG05 := isPin_of_sq_neg_one omegaG05_sq ⟨_, hasLambda_omegaG05⟩
