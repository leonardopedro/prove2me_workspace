-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_coe_single
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesSignedShift
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift.SignedHop
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.ThreeComponent.velH_coe_single (β γ : Vel) :
    ((velH A c (velState A c β) : L2I Vel) : Vel → ℂ) γ
      = ((hopList A c).map (fun S => Complex.I *
          ((if γ = S.shift β then (S.amp β : ℂ) else 0)
            - (if S.shift γ = β then (S.amp γ : ℂ) else 0)))).sum := by sorry
