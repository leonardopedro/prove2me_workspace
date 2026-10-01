-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.mqQuadPoly_hermiteMv
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

theorem BookProof.ModeQuadratic.mqQuadPoly_hermiteMv (p q s : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mqQuadPoly p q s (hermiteMv a)
      = ((mqSymbol p q a : ℝ) : ℂ) • hermiteMv a
        + ∑ i, (mqAmp p q s i • hermiteMv (a + Finsupp.single i 2)
              + ((starRingEnd ℂ) (mqAmp p q s i) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
                  • hermiteMv (a - Finsupp.single i 2)) := by sorry
