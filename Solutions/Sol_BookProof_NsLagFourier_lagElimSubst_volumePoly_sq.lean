-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimSubst_volumePoly_sq
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Theorems.Thm_BookProof_NsLagFourier_lagElimSubst_volumePoly
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    (lagElimHom l n (volumePoly p)) ^ 2 = 1 := by

  rw [lagElimSubst_volumePoly]
  ring
