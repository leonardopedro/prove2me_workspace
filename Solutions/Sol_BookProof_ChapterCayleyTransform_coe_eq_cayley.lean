-- Generated from ChapterCayleyTransform.lean — solution of BookProof.ChapterCayleyTransform.coe_eq_cayley
import Mathlib
import Definitions.Def_ChapterCayleyTransform
import Theorems.Thm_BookProof_ChapterCayleyTransform_sub_cayley_shift
open BookProof.ChapterCayleyTransform



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (x : T.domain) :
    (x : H) = (-(Complex.I / 2)) • (T.shift (-1) x - cayley T (T.shift (-1) x)) := by

  rw [sub_cayley_shift, smul_smul]
  have : (-(Complex.I / 2)) * (2 * Complex.I) = 1 := by
    linear_combination -Complex.I_sq
  rw [this, one_smul]
