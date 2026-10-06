-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.nullTranslations_mul
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
import Theorems.Thm_BookProof_ChapterWignerLittleGroup_nullElt_mul
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (b b' : ℂ) :
    nullElt 1 b * nullElt 1 b' = nullElt 1 (b + b') := by

  rw [nullElt_mul]; simp [add_comm]
