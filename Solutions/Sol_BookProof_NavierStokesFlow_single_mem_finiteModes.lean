-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.single_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_lpSingle_mem_lpFiniteModes
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (k : ℤ) (c : ℂ) : lp.single 2 k c ∈ finiteModes := lpSingle_mem_lpFiniteModes k c
