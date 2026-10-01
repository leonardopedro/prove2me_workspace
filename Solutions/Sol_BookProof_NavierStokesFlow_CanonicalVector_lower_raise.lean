-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.lower_raise
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (β : Vel) : lower i (raise i β) = β := by

  funext j
  by_cases hji : j = i
  · subst hji; rw [lower_self, raise_self]; omega
  · rw [lower_of_ne hji, raise_of_ne hji]
