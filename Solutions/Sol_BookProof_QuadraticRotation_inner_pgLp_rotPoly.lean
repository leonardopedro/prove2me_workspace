-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.inner_pgLp_rotPoly
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_integral_comp_rotIso
import Theorems.Thm_BookProof_QuadraticRotation_pgFun_rotPoly
open BookProof.QuadraticRotation




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp (rotPoly O p)) (pgLp (rotPoly O q)) : ℂ)
      = (inner ℂ (pgLp p) (pgLp q) : ℂ) := by

  have hL : (inner ℂ (pgLp (rotPoly O p)) (pgLp (rotPoly O q)) : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFun (rotPoly O p) x) * pgFun (rotPoly O q) x := by
    rw [inner_pgLp]
    refine integral_congr_ae ?_
    filter_upwards [pgLp_coeFn (rotPoly O q)] with x hx
    rw [hx]
  have hR : (inner ℂ (pgLp p) (pgLp q) : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFun p x) * pgFun q x := by
    rw [inner_pgLp]
    refine integral_congr_ae ?_
    filter_upwards [pgLp_coeFn q] with x hx
    rw [hx]
  have hpt : ∀ x : Vd d, (starRingEnd ℂ) (pgFun (rotPoly O p) x) * pgFun (rotPoly O q) x
      = (fun y : Vd d => (starRingEnd ℂ) (pgFun p y) * pgFun q y) (rotIso hO x) := by
    intro x
    rw [pgFun_rotPoly hO, pgFun_rotPoly hO]
  rw [hL, hR, integral_congr_ae (Filter.Eventually.of_forall hpt)]
  exact integral_comp_rotIso hO
    (fun y : Vd d => (starRingEnd ℂ) (pgFun p y) * pgFun q y)
