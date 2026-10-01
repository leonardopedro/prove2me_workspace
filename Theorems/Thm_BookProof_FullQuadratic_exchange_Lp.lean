-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.exchange_Lp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.FullQuadratic

variable {d : ℕ}



open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.FullQuadratic.exchange_Lp (i j : Fin d) (a : Fin d →₀ ℕ) (c : ℂ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • ((c * (a j : ℂ)) • pgLp (hermiteMv (shiftm a i j)))
      = (c * ((rcm a i j : ℝ) : ℂ)) • hermiteMvLp (shiftm a i j) := by sorry
