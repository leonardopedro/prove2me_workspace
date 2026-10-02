-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.crd_injective
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective crd := by

  intro x y h
  exact Subtype.ext (lp.ext h)
