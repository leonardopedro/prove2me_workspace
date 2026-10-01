-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.diagOp_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_add
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (a : ι → ℕ → ℝ) :
    (∑ i ∈ s, diagOp (a i)) = diagOp (fun n => ∑ i ∈ s, a i n) := by

  classical
  induction s using Finset.induction with
  | empty =>
      refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
      funext n
      simp [diagFun]
  | insert x s hx ih =>
      rw [Finset.sum_insert hx, ih, diagOp_add]
      congr 1
      funext n
      rw [Finset.sum_insert hx]
