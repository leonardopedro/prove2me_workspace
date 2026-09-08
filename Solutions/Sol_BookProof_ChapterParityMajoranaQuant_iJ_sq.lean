-- Generated from ChapterParityMajoranaQuant.lean — solution of BookProof.ChapterParityMajoranaQuant.iJ_sq
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
open BookProof.ChapterParityMajoranaQuant











open Matrix
open scoped ComplexConjugate


variable {m : ℕ}




variable (J : Matrix (Fin m) (Fin m) ℂ)

set_option maxHeartbeats 1000000 in
theorem solution (hJ2 : J * J = -1) : iJ J * iJ J = 1 := by

  unfold iJ
  rw [smul_mul_smul_comm, hJ2, Complex.I_mul_I, smul_neg, neg_smul, neg_neg, one_smul]
