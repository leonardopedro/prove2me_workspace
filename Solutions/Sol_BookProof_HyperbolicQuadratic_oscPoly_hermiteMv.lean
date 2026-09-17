-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.oscPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_oscPoly_apply
import Theorems.Thm_BookProof_HyperbolicQuadratic_hermiteMv_number
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    oscPoly i (hermiteMv a) = (((a i : ℝ) : ℂ) + 1/2) • hermiteMv a := by

  rw [oscPoly_apply, hermiteMv_number, ← add_smul]
  norm_num
