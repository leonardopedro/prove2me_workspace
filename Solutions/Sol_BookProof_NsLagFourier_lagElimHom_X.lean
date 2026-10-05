-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimHom_X
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
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (s : Fin (n * 36)) :
    lagElimHom l n (X s)
      = lagLift (finProdFinEquiv.symm s).1 (lagElimCoord l (finProdFinEquiv.symm s).2) := MvPolynomial.eval₂Hom_X' _ _ s
