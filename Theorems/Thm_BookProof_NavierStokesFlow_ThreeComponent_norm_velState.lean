-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.norm_velState
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.ThreeComponent.norm_velState (β : Vel) : ‖(velState A c β : L2I Vel)‖ = 1 := by sorry
