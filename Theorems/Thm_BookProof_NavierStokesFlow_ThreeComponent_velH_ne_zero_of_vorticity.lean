-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_ne_zero_of_vorticity
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.ThreeComponent.velH_ne_zero_of_vorticity (h : A 0 1 - A 1 0 ≠ 0) :
    velH A c (velState A c ![0, 1, 0]) ≠ 0 := by sorry
