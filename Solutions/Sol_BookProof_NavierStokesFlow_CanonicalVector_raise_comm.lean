-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.raise_comm
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (β : Vel) : raise i (raise k β) = raise k (raise i β) := by

  funext j
  by_cases hji : j = i <;> by_cases hjk : j = k
  · subst hji; subst hjk; simp [raise]
  · subst hji; rw [raise_self, raise_of_ne hjk, raise_of_ne hjk, raise_self]
  · subst hjk; rw [raise_of_ne hji, raise_self, raise_self, raise_of_ne hji]
  · rw [raise_of_ne hji, raise_of_ne hjk, raise_of_ne hjk, raise_of_ne hji]
