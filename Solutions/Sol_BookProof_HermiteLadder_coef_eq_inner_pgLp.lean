-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.coef_eq_inner_pgLp
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) (v : L2d d) :
    coef a v = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ * inner ℂ (pgLp (hermiteMv a)) v := by

  rw [coef, hermiteMvLp, inner_smul_left]
  simp
