-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimHom_C
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
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (c : ℂ) :
    lagElimHom l n (C c : MvPolynomial (Fin (n * 36)) ℂ)
      = (C c : MvPolynomial (Fin (n * 12)) ℂ) := MvPolynomial.eval₂Hom_C _ _ c
