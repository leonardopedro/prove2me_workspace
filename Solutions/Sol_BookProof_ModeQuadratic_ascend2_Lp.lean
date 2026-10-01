-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.ascend2_Lp
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_hermiteMvNorm_add_two
open BookProof.ModeQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv (a + Finsupp.single i 2))
      = ((rc2 a i : ℝ) : ℂ) • hermiteMvLp (a + Finsupp.single i 2) := by

  rw [pgLp_hermiteMv_eq, smul_smul, hermiteMvNorm_add_two, rc2,
    Real.sqrt_mul (by positivity)]
  congr 1
  have hne : ((hermiteMvNorm a : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero a
  push_cast
  field_simp
