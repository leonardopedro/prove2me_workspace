-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.coef_crePoly
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_inner_pgLp_crePoly
import Theorems.Thm_BookProof_HermiteLadder_coef_eq_inner_pgLp
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_hermiteMvLp
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (b : Fin d →₀ ℕ) (p : MvPolynomial (Fin d) ℂ) :
    coef b (pgLp (crePoly i p))
      = ((Real.sqrt ((b i : ℝ)) : ℝ) : ℂ) * coef (b - Finsupp.single i 1) (pgLp p) := by

  have hN : ∀ x : L2d d, ((hermiteMvNorm b : ℝ) : ℂ)⁻¹ * inner ℂ (pgLp (annPoly i (hermiteMv b))) x
      = inner ℂ (((hermiteMvNorm b : ℝ) : ℂ)⁻¹ • pgLp (annPoly i (hermiteMv b))) x := by
    intro x
    rw [inner_smul_left]
    simp
  rw [coef_eq_inner_pgLp, inner_pgLp_crePoly, hN, annPoly_hermiteMvLp, inner_smul_left, coef]
  simp
