-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.tendsto_resCLM_shift
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_resCLM_apply_le
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_shift
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint F) (S : ℕ → UnboundedSelfAdjoint F)
    {x : F} (hT : x ∈ T.domain) (hS : ∀ n, x ∈ (S n).domain)
    (hconv : Tendsto (fun n => (S n).op ⟨x, hS n⟩) atTop (𝓝 (T.op ⟨x, hT⟩))) :
    Tendsto (fun n => (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩)) atTop
      (𝓝 (T.resCLM 1 (T.shift 1 ⟨x, hT⟩))) := by

  have hfix : T.resCLM 1 (T.shift 1 ⟨x, hT⟩) = x := by
    have := T.res_shift (l := 1) one_ne_zero ⟨x, hT⟩
    simpa using congrArg (fun u : T.domain => (u : F)) this
  rw [hfix, tendsto_iff_norm_sub_tendsto_zero]
  have hdiff : ∀ n, (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - x
      = (S n).resCLM 1 (T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩) := by
    intro n
    have hres : (S n).resCLM 1 ((S n).shift 1 ⟨x, hS n⟩) = x := by
      have := (S n).res_shift (l := 1) one_ne_zero ⟨x, hS n⟩
      simpa using congrArg (fun u : (S n).domain => (u : F)) this
    have hsub : T.shift 1 ⟨x, hT⟩ - (S n).shift 1 ⟨x, hS n⟩
        = T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩ := by
      rw [UnboundedSelfAdjoint.shift_apply, UnboundedSelfAdjoint.shift_apply]
      simp
    calc (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - x
        = (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - (S n).resCLM 1 ((S n).shift 1 ⟨x, hS n⟩) := by
          rw [hres]
      _ = (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩ - (S n).shift 1 ⟨x, hS n⟩) := (map_sub _ _ _).symm
      _ = (S n).resCLM 1 (T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩) := by rw [hsub]
  have hnorm : ∀ n, ‖(S n).resCLM 1 (T.shift 1 ⟨x, hT⟩) - x‖
      ≤ ‖T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩‖ := by
    intro n
    rw [hdiff n]
    have := (S n).norm_resCLM_apply_le 1 (T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩)
    simpa using this
  have h0 : Tendsto (fun n => ‖T.op ⟨x, hT⟩ - (S n).op ⟨x, hS n⟩‖) atTop (𝓝 0) := by
    have := (tendsto_iff_norm_sub_tendsto_zero.mp hconv)
    simpa only [norm_sub_rev] using this
  exact squeeze_zero (fun n => norm_nonneg _) hnorm h0
