-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.ThreeComponent.velH_symmetricOn : SymmetricOn (maxDom (velSym (velMu A c))) (velH A c) := by sorry
