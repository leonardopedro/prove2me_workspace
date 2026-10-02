-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosida_tendsto
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_jn_tendsto
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_apply_domain
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (x : T.domain) :
    Tendsto (fun k : ℕ => T.yosida ((k : ℝ) + 1) (x : H)) atTop (𝓝 (T.op x)) := by

  have h : ∀ k : ℕ, T.yosida ((k : ℝ) + 1) (x : H) = T.jn ((k : ℝ) + 1) (T.op x) := by
    intro k
    exact T.yosida_apply_domain (by positivity) x
  simp only [h]
  exact T.jn_tendsto (T.op x)
