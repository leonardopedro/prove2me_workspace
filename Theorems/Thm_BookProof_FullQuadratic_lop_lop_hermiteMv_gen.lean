-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.lop_lop_hermiteMv_gen
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterModeQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
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


theorem BookProof.FullQuadratic.lop_lop_hermiteMv_gen (t t' : ℂ) (i j : Fin d) (a : Fin d →₀ ℕ) :
    lop t i (lop t' j (hermiteMv a))
      = hermiteMv (a + pvec i j)
        + (t * (a i : ℂ)) • hermiteMv (shiftm a j i)
        + (t' * (a j : ℂ)) • hermiteMv (shiftm a i j)
        + (t * t' * (a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ))
            • hermiteMv (a - pvec i j)
        + (if i = j then t • hermiteMv a else 0) := by sorry
