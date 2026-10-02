-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.res_second_order
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_shift




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {l : ℝ} (hl : l ≠ 0) (x : T.domain) (hx : T.op x ∈ T.domain) :
    ((T.res l (x : H) : T.domain) : H)
      = (Complex.I / (l : ℂ)) • (x : H) + (1 / (l : ℂ) ^ 2) • T.op x
        - (1 / (l : ℂ) ^ 2) • ((T.res l (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by

  have hlC : ((l : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hl
  set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
  set r : T.domain := T.res l (T.op x2) with hr
  set c : T.domain :=
    (Complex.I / (l : ℂ)) • x + (1 / (l : ℂ) ^ 2) • x2 - (1 / (l : ℂ) ^ 2) • r with hc
  have hopr : T.op r = T.op x2 + ((l : ℂ) * Complex.I) • (r : H) := T.op_res hl (T.op x2)
  have hopc : T.op c = (Complex.I / (l : ℂ)) • T.op x + (1 / (l : ℂ) ^ 2) • T.op x2
      - (1 / (l : ℂ) ^ 2) • T.op r := by
    rw [hc, map_sub, map_add, map_smul, map_smul, map_smul]
  have hcoe : (c : H) = (Complex.I / (l : ℂ)) • (x : H) + (1 / (l : ℂ) ^ 2) • (x2 : H)
      - (1 / (l : ℂ) ^ 2) • (r : H) := by
    rw [hc]; rfl
  have hx2coe : (x2 : H) = T.op x := rfl
  have hshift : T.shift l c = (x : H) := by
    rw [UnboundedSelfAdjoint.shift_apply, hopc, hopr, hcoe, hx2coe]
    match_scalars
    all_goals field_simp
    all_goals ring_nf
    all_goals simp [Complex.I_sq]
  have hres : T.res l (x : H) = c := by
    rw [← hshift, T.res_shift hl]
  rw [hres, hcoe, hx2coe]
