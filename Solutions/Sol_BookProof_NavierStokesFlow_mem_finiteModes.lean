-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution {f : L2Z} :
    f ∈ finiteModes ↔ (Function.support ((f : ℤ → ℂ))).Finite := Iff.rfl
