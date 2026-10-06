-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_stoneU_sub_approxU_le
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_sub_apply_le
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_tendsto_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_tendsto
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (k : ℝ) (t : ℝ) (x : T.domain) :
    ‖T.stoneU t (x : H) - T.approxU k t (x : H)‖ ≤ |t| * ‖T.op x - T.yosida k (x : H)‖ := by

  have hf : Tendsto (fun l : ℕ => ‖T.approxU ((l : ℝ) + 1) t (x : H) - T.approxU k t (x : H)‖)
      atTop (𝓝 ‖T.stoneU t (x : H) - T.approxU k t (x : H)‖) :=
    ((T.tendsto_stoneU t (x : H)).sub tendsto_const_nhds).norm
  have hg : Tendsto
      (fun l : ℕ => |t| * ‖T.yosida ((l : ℝ) + 1) (x : H) - T.yosida k (x : H)‖)
      atTop (𝓝 (|t| * ‖T.op x - T.yosida k (x : H)‖)) :=
    (((T.yosida_tendsto x).sub tendsto_const_nhds).norm).const_mul _
  refine le_of_tendsto_of_tendsto' hf hg (fun l => ?_)
  exact T.norm_approxU_sub_apply_le _ k t (x : H)
