-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.ThreeComponent.velH_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (lpFiniteModes Vel)
      ((velH A c).comp (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))))) := by sorry
