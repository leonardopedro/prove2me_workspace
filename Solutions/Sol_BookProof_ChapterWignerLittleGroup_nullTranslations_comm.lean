-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.nullTranslations_comm
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
import Theorems.Thm_BookProof_ChapterWignerLittleGroup_nullTranslations_mul
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (b b' : ℂ) :
    nullElt 1 b * nullElt 1 b' = nullElt 1 b' * nullElt 1 b := by

  rw [nullTranslations_mul, nullTranslations_mul, add_comm b' b]
