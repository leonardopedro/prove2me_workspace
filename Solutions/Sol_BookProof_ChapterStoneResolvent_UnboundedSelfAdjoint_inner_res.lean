-- Generated from ChapterStoneResolvent.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.inner_res
import Mathlib
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint







open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]



variable (T : UnboundedSelfAdjoint H)













variable [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {l : ℝ} (hl : l ≠ 0) (y z : H) :
    ⟪((T.res l y : T.domain) : H), z⟫_ℂ = ⟪y, ((T.res (-l) z : T.domain) : H)⟫_ℂ := by

  have hl' : -l ≠ 0 := neg_ne_zero.mpr hl
  set u : T.domain := T.res l y with hu
  set v : T.domain := T.res (-l) z with hv
  have hy : T.op u - ((l : ℂ) * Complex.I) • (u : H) = y := by
    have := T.shift_res hl y
    rwa [shift_apply] at this
  have hz : T.op v - (((-l : ℝ) : ℂ) * Complex.I) • (v : H) = z := by
    have := T.shift_res hl' z
    rwa [shift_apply] at this
  have hz' : T.op v + ((l : ℂ) * Complex.I) • (v : H) = z := by
    rw [← hz]; push_cast; module
  have hsym := T.symmetric u v
  rw [← hy, ← hz']
  rw [inner_add_right, inner_sub_left, inner_smul_left, inner_smul_right, hsym]
  simp [Complex.conj_I]
