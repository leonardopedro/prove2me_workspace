-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.tridiagOp_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_tridiagOp_add
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (cc : ι → ℕ → ℂ) :
    (∑ i ∈ s, tridiagOp (cc i)) = tridiagOp (fun n => ∑ i ∈ s, cc i n) := by

  classical
  induction s using Finset.induction with
  | empty =>
      refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
      funext n
      cases n with
      | zero => simp [tridiagFun]
      | succ m => simp [tridiagFun]
  | insert x s hx ih =>
      rw [Finset.sum_insert hx, ih, tridiagOp_add]
      congr 1
      funext n
      rw [Finset.sum_insert hx]
