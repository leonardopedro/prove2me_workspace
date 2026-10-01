-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.hermiteMvNorm_add_pvec
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_add_pvec_eq
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvNorm_add_single
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

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMvNorm (a + pvec i j) = hermiteMvNorm a * rcp a i j := by

  rw [← add_pvec_eq, hermiteMvNorm_add_single i (a + Finsupp.single j 1),
    hermiteMvNorm_add_single j a, rcp]
  ring
