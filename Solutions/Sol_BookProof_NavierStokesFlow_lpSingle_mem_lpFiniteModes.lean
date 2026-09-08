-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.lpSingle_mem_lpFiniteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] (k : ι) (c : ℂ) :
    lp.single 2 k c ∈ lpFiniteModes ι := by

  refine Set.Finite.subset (Set.finite_singleton k) ?_
  intro j hj
  simp only [Function.mem_support] at hj
  by_contra hne
  have hjk : j ≠ k := by simpa using hne
  exact hj (by simp [lp.single_apply, Pi.single_eq_of_ne hjk])
