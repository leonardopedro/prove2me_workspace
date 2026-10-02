-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.lower_comm
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (β : Vel) : lower i (lower k β) = lower k (lower i β) := by

  funext j
  by_cases hji : j = i <;> by_cases hjk : j = k
  · subst hji; subst hjk; simp [lower]
  · subst hji; rw [lower_self, lower_of_ne hjk, lower_of_ne hjk, lower_self]
  · subst hjk; rw [lower_of_ne hji, lower_self, lower_self, lower_of_ne hji]
  · rw [lower_of_ne hji, lower_of_ne hjk, lower_of_ne hjk, lower_of_ne hji]
