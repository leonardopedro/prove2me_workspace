-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.lop_hermiteMv
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMv
import Theorems.Thm_BookProof_HermiteProductBasis_pderiv_hermiteMv




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (t : ℂ) (i : Fin d) (b : Fin d →₀ ℕ) :
    lop t i (hermiteMv b)
      = hermiteMv (b + Finsupp.single i 1) + (t * (b i : ℂ)) • hermiteMv (b - Finsupp.single i 1) := by

  simp only [lop, LinearMap.add_apply, LinearMap.smul_apply, annPoly_apply]
  rw [crePoly_hermiteMv, pderiv_hermiteMv, smul_smul]
