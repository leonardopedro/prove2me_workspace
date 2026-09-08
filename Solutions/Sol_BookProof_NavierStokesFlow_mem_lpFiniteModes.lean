-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.mem_lpFiniteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {f : lp (fun _ : ι => ℂ) 2} :
    f ∈ lpFiniteModes ι ↔ (Function.support ((f : ι → ℂ))).Finite := Iff.rfl
