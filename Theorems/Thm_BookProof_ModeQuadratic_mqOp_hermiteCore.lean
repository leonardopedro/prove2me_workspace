-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.mqOp_hermiteCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2
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


theorem BookProof.ModeQuadratic.mqOp_hermiteCore (p q s b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mqOp p q s b b' (hermiteCore a)
      = ((mqSymbol p q a : ℝ) : ℂ) • hermiteMvLp a
        + (∑ i, ((mqAmp p q s i * ((rc2 a i : ℝ) : ℂ))
                    • hermiteMvLp (a + Finsupp.single i 2)
                + ((starRingEnd ℂ) (mqAmp p q s i) * ((lc2 a i : ℝ) : ℂ))
                    • hermiteMvLp (a - Finsupp.single i 2)))
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by sorry
