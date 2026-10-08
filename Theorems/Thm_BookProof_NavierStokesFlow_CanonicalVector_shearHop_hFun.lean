-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.shearHop_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterGravityProjector
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow.LagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.CanonicalVector.shearHop_hFun (i : Fin 3) (X : Vel → ℂ) (γ : Vel) :
    (shearHop A c i).hFun X γ
      = Complex.I * (((c i / Real.sqrt 2 : ℝ) : ℂ) * (cFun i X γ - aFun i X γ)) := by sorry
