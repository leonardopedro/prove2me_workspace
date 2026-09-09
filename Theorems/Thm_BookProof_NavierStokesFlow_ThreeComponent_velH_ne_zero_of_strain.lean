-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_ne_zero_of_strain
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent















open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift





































variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.ThreeComponent.velH_ne_zero_of_strain (h : A 0 1 + A 1 0 ≠ 0) :
    velH A c (velState A c ![0, 0, 0]) ≠ 0 := by sorry
