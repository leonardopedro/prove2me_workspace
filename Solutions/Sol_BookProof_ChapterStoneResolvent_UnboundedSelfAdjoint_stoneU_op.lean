-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_op
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_commute_resCLM
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_mem_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_shift
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (x : T.domain) :
    T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩ = T.stoneU t (T.op x) := by

  set y : H := T.shift 1 x with hy
  have hx : ((T.res 1 y : T.domain) : H) = (x : H) := T.res_shift one_ne_zero x ▸ rfl
  have hAx : T.op x = y + ((1 : ℂ) * Complex.I) • (x : H) := by
    have h := T.op_res (l := 1) one_ne_zero y
    rw [show ((T.res 1 y : T.domain) : H) = (x : H) from hx] at h
    have hxx : (T.res 1 y : T.domain) = x := by
      have := T.res_shift (l := 1) one_ne_zero x
      simpa [hy] using this
    rw [hxx] at h
    simpa using h
  have hU : T.stoneU t (x : H) = T.resCLM 1 (T.stoneU t y) := by
    rw [← T.stoneU_commute_resCLM]
    congr 1
    exact hx.symm
  have hmem : T.stoneU t (x : H) ∈ T.domain := T.stoneU_mem_domain t x
  have hop : T.op ⟨T.stoneU t (x : H), hmem⟩
      = T.stoneU t y + ((1 : ℂ) * Complex.I) • T.resCLM 1 (T.stoneU t y) := by
    have h := T.op_res (l := 1) one_ne_zero (T.stoneU t y)
    have hcoe : (⟨T.stoneU t (x : H), hmem⟩ : T.domain) = T.res 1 (T.stoneU t y) := by
      apply Subtype.ext
      simpa using hU
    rw [hcoe]
    simpa using h
  rw [hop, ← hU, hAx, map_add, map_smul]
