-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.weylxp_gen
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_weylProd_smul_apply
import Theorems.Thm_BookProof_ModeQuadratic_momPoly_eq_lop
import Theorems.Thm_BookProof_ModeQuadratic_mulXPoly_eq_lop
open BookProof.FullQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly j) (hermiteMv a)
      = (Complex.I / 2) •
          BookProof.YangMillsHermite.weylProd (lop 1 i) (lop (-1) j) (hermiteMv a) := by

  rw [mulXPoly_eq_lop, momPoly_eq_lop]
  have h := weylProd_smul_apply (d := d) 1 (Complex.I / 2) (lop 1 i) (lop (-1) j) (hermiteMv a)
  rw [one_smul] at h
  rw [h, one_mul]
