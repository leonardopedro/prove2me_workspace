-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.fqQuadPoly_hermiteMv
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
-- expanding the quadratic symbol over all mode pairs makes this rewrite chain expensive
theorem BookProof.FullQuadratic.fqQuadPoly_hermiteMv (P Q S : Fin d → Fin d → ℝ) (a : Fin d →₀ ℕ) :
    fqQuadPoly P Q S (hermiteMv a)
      = ((fqSymbol P Q : ℝ) : ℂ) • hermiteMv a
        + ∑ i, ∑ j, (fqAmp P Q S i j • hermiteMv (a + pvec i j)
            + ((starRingEnd ℂ) (fqAmp P Q S i j) * (a j : ℂ)
                * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ))
                  • hermiteMv (a - pvec i j)
            + (fqExch P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j)) := by sorry
