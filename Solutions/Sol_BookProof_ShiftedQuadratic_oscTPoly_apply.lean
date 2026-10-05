-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.oscTPoly_apply
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
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
theorem solution (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    oscTPoly a k i p = oscPoly i p + (2 * ((k i : ℝ) : ℂ)) • momPoly i p
      + (((a i : ℝ) : ℂ) / 2) • (X i * p)
      + ((((k i : ℝ) : ℂ)) ^ 2 + ((a i : ℝ) : ℂ) ^ 2 / 4) • p := by

  simp only [oscTPoly, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    momTPoly_apply, mulXTPoly_apply, oscPoly, map_add, map_smul, mulXPoly_apply]
  module
