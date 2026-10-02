-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.nsQuadraticH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canH_essentiallySelfAdjointOn_core
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution
    (nu : ℝ) (grad : Matrix (Fin 3) (Fin 3) ℝ) (lap : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes Vel)
      ((lpFiniteModes Vel).subtype.comp (nsQuadraticH nu grad lap)) := canH_essentiallySelfAdjointOn_core grad _
