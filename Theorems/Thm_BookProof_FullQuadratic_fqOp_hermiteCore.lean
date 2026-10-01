-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.fqOp_hermiteCore
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.FullQuadratic

variable {d : ℕ}



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

set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of this transport expensive
theorem BookProof.FullQuadratic.fqOp_hermiteCore (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    fqOp P Q S b b' (hermiteCore a)
      = ((fqSymbol P Q : ℝ) : ℂ) • hermiteMvLp a
        + (∑ i, ∑ j, ((fqAmp P Q S i j * ((rcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (a + pvec i j)
                + ((starRingEnd ℂ) (fqAmp P Q S i j) * ((lcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (a - pvec i j)
                + (fqExch P Q S i j * ((rcm a i j : ℝ) : ℂ))
                    • hermiteMvLp (shiftm a i j)))
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by sorry
