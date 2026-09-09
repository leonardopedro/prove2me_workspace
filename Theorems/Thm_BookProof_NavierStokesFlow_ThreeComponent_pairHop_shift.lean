-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.pairHop_shift
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent















open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift





































variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.ThreeComponent.pairHop_shift (i k : Fin 3) : (pairHop A c i k).shift = shPair i k := by sorry
