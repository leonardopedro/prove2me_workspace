-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.nullElt_conj_translation
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
import Theorems.Thm_BookProof_ChapterWignerLittleGroup_nullElt_mul
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℂ) (ha : a * (starRingEnd ℂ) a = 1) :
    nullElt a 0 * nullElt 1 b * nullElt ((starRingEnd ℂ) a) 0 = nullElt 1 (a * a * b) := by

  have h : (starRingEnd ℂ) ((starRingEnd ℂ) a) = a := by simp
  rw [nullElt_mul, nullElt_mul, h]
  simp only [nullElt]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [ha, mul_comm, mul_left_comm]
