-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.canH_domain_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((lpFiniteModes Vel : Submodule ℂ (L2I Vel)) : Set (L2I Vel)) := lpFiniteModes_dense
