-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.fqTerm_hermiteMv
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

theorem BookProof.FullQuadratic.fqTerm_hermiteMv (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) (a : Fin d →₀ ℕ) :
    (((P i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly j)
      + ((Q i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly j)
      + ((S i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly j))
        (hermiteMv a)
      = fqAmp P Q S i j • hermiteMv (a + pvec i j)
        + ((starRingEnd ℂ) (fqMl P Q S i j) * (a i : ℂ)) • hermiteMv (shiftm a j i)
        + (fqMl P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j)
        + ((starRingEnd ℂ) (fqAmp P Q S i j) * (a j : ℂ)
            * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ)) • hermiteMv (a - pvec i j)
        + (if i = j then (((Q i i + P i i / 4 : ℝ) : ℂ)) • hermiteMv a else 0) := by sorry
