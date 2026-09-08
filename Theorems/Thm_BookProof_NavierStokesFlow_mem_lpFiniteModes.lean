-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.mem_lpFiniteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow








open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}

theorem BookProof.NavierStokesFlow.mem_lpFiniteModes {f : lp (fun _ : ι => ℂ) 2} :
    f ∈ lpFiniteModes ι ↔ (Function.support ((f : ι → ℂ))).Finite := by sorry
