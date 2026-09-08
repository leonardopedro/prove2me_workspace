-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.finiteModes_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_lpFiniteModes_dense
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution : Dense ((finiteModes : Submodule ℂ L2Z) : Set L2Z) := lpFiniteModes_dense
