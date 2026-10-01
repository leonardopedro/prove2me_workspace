-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.canFun_eq_ladFun
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 4000000 in
-- Both sides expand into the same several-dozen-term ladder polynomial; normalising it
-- with `ring` exceeds the default heartbeat budget.
theorem BookProof.NavierStokesFlow.CanonicalVector.canFun_eq_ladFun (X : Vel → ℂ) (γ : Vel) :
    canFun A c X γ = ladFun A c X γ := by sorry
