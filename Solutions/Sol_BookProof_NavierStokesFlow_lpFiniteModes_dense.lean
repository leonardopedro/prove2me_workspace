-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.lpFiniteModes_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_lpSingle_mem_lpFiniteModes
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((lpFiniteModes ι : Submodule ℂ (lp (fun _ : ι => ℂ) 2)) :
      Set (lp (fun _ : ι => ℂ) 2)) := by

  classical
  intro f
  refine mem_closure_of_tendsto (lp.hasSum_single (by simp) f) ?_
  filter_upwards with S
  exact Submodule.sum_mem _ fun k _ => lpSingle_mem_lpFiniteModes k _
