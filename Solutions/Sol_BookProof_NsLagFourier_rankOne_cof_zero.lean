-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.rankOne_cof_zero
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b ζ : Fin 3 → MvPolynomial (Fin (n * 12)) ℂ) (i j : Fin 3) :
    (b (cyc j 1) * ζ (cyc i 1)) * (b (cyc j 2) * ζ (cyc i 2))
      + (-1) * ((b (cyc j 2) * ζ (cyc i 1)) * (b (cyc j 1) * ζ (cyc i 2))) = 0 := by

  ring
