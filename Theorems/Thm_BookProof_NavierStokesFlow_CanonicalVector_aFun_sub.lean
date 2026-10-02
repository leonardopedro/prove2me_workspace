-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.aFun_sub
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.CanonicalVector.aFun_sub (i : Fin 3) (X Y : Vel → ℂ) :
    aFun i (X - Y) = aFun i X - aFun i Y := by sorry
