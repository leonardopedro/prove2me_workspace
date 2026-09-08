-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.lpSingle_mem_lpFiniteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow








open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}

theorem BookProof.NavierStokesFlow.lpSingle_mem_lpFiniteModes [DecidableEq ι] (k : ι) (c : ℂ) :
    lp.single 2 k c ∈ lpFiniteModes ι := by sorry
