-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_commute_resCLM
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_commute_resCLM
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_tendsto_stoneU
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (t l : ℝ) (y : H) :
    T.stoneU t (T.resCLM l y) = T.resCLM l (T.stoneU t y) := by

  have h1 : Tendsto (fun k : ℕ => T.approxU ((k : ℝ) + 1) t (T.resCLM l y)) atTop
      (𝓝 (T.stoneU t (T.resCLM l y))) := T.tendsto_stoneU t _
  have h2 : Tendsto (fun k : ℕ => T.resCLM l (T.approxU ((k : ℝ) + 1) t y)) atTop
      (𝓝 (T.resCLM l (T.stoneU t y))) :=
    ((T.resCLM l).continuous.tendsto _).comp (T.tendsto_stoneU t y)
  have heq : (fun k : ℕ => T.approxU ((k : ℝ) + 1) t (T.resCLM l y))
      = fun k : ℕ => T.resCLM l (T.approxU ((k : ℝ) + 1) t y) := by
    funext k
    exact congrArg (fun (S : H →L[ℂ] H) => S y) ((T.approxU_commute_resCLM ((k : ℝ) + 1) t l).eq)
  rw [heq] at h1
  exact tendsto_nhds_unique h1 h2
