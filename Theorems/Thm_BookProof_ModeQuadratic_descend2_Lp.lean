-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.descend2_Lp
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

theorem BookProof.ModeQuadratic.descend2_Lp (i : Fin d) (a : Fin d →₀ ℕ) (c : ℂ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ •
        ((c * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) • pgLp (hermiteMv (a - Finsupp.single i 2)))
      = (c * ((lc2 a i : ℝ) : ℂ)) • hermiteMvLp (a - Finsupp.single i 2) := by sorry
