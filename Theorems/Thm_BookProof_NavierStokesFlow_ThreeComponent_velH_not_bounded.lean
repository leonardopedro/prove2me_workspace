-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent















open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift





































variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.ThreeComponent.velH_not_bounded (hA : A 0 0 ≠ 0) (C : ℝ) :
    ∃ β : Vel, ‖(velState A c β : L2I Vel)‖ = 1
      ∧ C < ‖(velH A c (velState A c β) : L2I Vel)‖ := by sorry
