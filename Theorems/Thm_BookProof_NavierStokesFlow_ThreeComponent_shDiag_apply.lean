-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.shDiag_apply
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.ThreeComponent.shDiag_apply (i : Fin 3) (β : Vel) (j : Fin 3) :
    shDiag i β j = β j + (if j = i then 2 else 0) := by sorry
