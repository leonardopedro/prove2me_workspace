-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosida_commute
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_resCLM_commute
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n m : ℝ) : Commute (T.yosida n) (T.yosida m) := by

  have h : ∀ a b : ℝ, Commute (T.resCLM a) (T.resCLM b) := T.resCLM_commute
  unfold yosida
  refine Commute.add_left (Commute.smul_left ?_ _) (Commute.smul_left ?_ _) <;>
    refine Commute.add_right (Commute.smul_right ?_ _) (Commute.smul_right ?_ _) <;>
    first
      | exact h _ _
      | exact (h _ _).mul_right (h _ _)
      | exact (h _ _).mul_left (h _ _)
      | exact Commute.mul_left ((h _ _).mul_right (h _ _)) ((h _ _).mul_right (h _ _))
