-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.hermiteMvNorm_add_two
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
open BookProof.ModeQuadratic

variable {d : ℕ}



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

theorem BookProof.ModeQuadratic.hermiteMvNorm_add_two (i : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMvNorm (a + Finsupp.single i 2)
      = hermiteMvNorm a * Real.sqrt ((a i : ℝ) + 1) * Real.sqrt ((a i : ℝ) + 2) := by sorry
