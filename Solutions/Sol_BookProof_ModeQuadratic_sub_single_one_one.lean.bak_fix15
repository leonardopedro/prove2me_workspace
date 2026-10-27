-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.sub_single_one_one
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
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
    a - Finsupp.single i 1 - Finsupp.single i 1 = a - Finsupp.single i 2 := by

  ext j
  by_cases hj : j = i
  · subst hj; simp; omega
  · simp [hj]
