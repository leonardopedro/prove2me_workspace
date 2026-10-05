-- Generated from ChapterMassGap.lean — solution of BookProof.MassGap.exp_conj_eq_self
import Mathlib
import Definitions.Def_ChapterMassGap
open BookProof.MassGap




open scoped BigOperators

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]

set_option maxHeartbeats 1000000 in
theorem solution {Obs Y : 𝔸} (h : Commute Obs Y) :
    NormedSpace.exp Y * Obs * NormedSpace.exp (-Y) = Obs := by

  haveI : NormedAlgebra ℚ 𝔸 := NormedAlgebra.restrictScalars ℚ ℂ 𝔸
  have hcomm : Commute (NormedSpace.exp Y) Obs := h.symm.exp_left
  have hinv : NormedSpace.exp Y * NormedSpace.exp (-Y) = 1 := by
    rw [← NormedSpace.exp_add_of_commute ((Commute.refl Y).neg_right), add_neg_cancel,
      NormedSpace.exp_zero]
  rw [mul_assoc, ← mul_assoc, hcomm.eq, mul_assoc, hinv, mul_one]
