-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.weylxp_hermiteMv
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_mulXPoly_eq_lop
import Theorems.Thm_BookProof_ModeQuadratic_momPoly_eq_lop
import Theorems.Thm_BookProof_ModeQuadratic_lop_lop_hermiteMv
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

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly i) (hermiteMv a)
      = (Complex.I / 2) • hermiteMv (a + Finsupp.single i 2)
        + (0 : ℂ) • hermiteMv a
        + (-(Complex.I / 2) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
            • hermiteMv (a - Finsupp.single i 2) := by

  rw [mulXPoly_eq_lop, momPoly_eq_lop, BookProof.YangMillsHermite.weylProd]
  simp only [LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply, map_smul]
  rw [lop_lop_hermiteMv 1 (-1) i a, lop_lop_hermiteMv (-1) 1 i a]
  push_cast
  module
