-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.shiftedHPoly_eq_quadPoly
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedHPoly_apply
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedHPoly_term
open BookProof.ShiftedQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0)
    (p : MvPolynomial (Fin d) ℂ) :
    shiftedHPoly (shiftVec c b) (boostVec c b') c b b' p
      = quadPoly c p + ((shiftConst c b b' : ℝ) : ℂ) • p := by

  rw [shiftedHPoly_apply, Finset.sum_congr rfl fun i _ => shiftedHPoly_term c b b' i (hc i) p,
    Finset.sum_add_distrib]
  congr 1
  · rw [quadPoly, LinearMap.sum_apply]
    exact Finset.sum_congr rfl fun i _ => rfl
  · rw [← Finset.sum_smul, shiftConst]
    congr 1
    push_cast
    ring
