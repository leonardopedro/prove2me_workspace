-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.lower_raise_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution {i k : Fin 3} (h : i ≠ k) (β : Vel) :
    lower k (raise i β) = raise i (lower k β) := by

  funext j
  by_cases hji : j = i <;> by_cases hjk : j = k
  · exact absurd (hji ▸ hjk ▸ rfl) h
  · subst hji; rw [lower_of_ne hjk, raise_self, raise_self, lower_of_ne hjk]
  · subst hjk; rw [lower_self, raise_of_ne hji, raise_of_ne hji, lower_self]
  · rw [lower_of_ne hjk, raise_of_ne hji, raise_of_ne hji, lower_of_ne hjk]
