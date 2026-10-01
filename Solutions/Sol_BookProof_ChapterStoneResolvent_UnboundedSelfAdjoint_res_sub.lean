-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_sub
import Mathlib
import Definitions.Def_ChapterStoneGroup
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0) (y : H) :
    T.resCLM l y - T.resCLM m y
      = (((l : ℂ) - (m : ℂ)) * Complex.I) • T.resCLM l (T.resCLM m y) := by

  set u : T.domain := T.res m y with hudef
  set v : T.domain := T.res l y with hvdef
  set w : T.domain := T.res l ((u : H)) with hwdef
  have hu : T.op u - ((m : ℂ) * Complex.I) • (u : H) = y := by
    have := T.shift_res hm y; rwa [shift_apply] at this
  have hv : T.op v - ((l : ℂ) * Complex.I) • (v : H) = y := by
    have := T.shift_res hl y; rwa [shift_apply] at this
  have hw : T.op w - ((l : ℂ) * Complex.I) • (w : H) = (u : H) := by
    have := T.shift_res hl ((u : H)); rwa [shift_apply] at this
  set c : ℂ := (((l : ℂ) - (m : ℂ)) * Complex.I) with hc
  have hzero : T.shift l (v - u - c • w) = 0 := by
    rw [map_sub, map_sub, map_smul, shift_apply, shift_apply, shift_apply]
    rw [hv, hw]
    have hop : T.op u = y + ((m : ℂ) * Complex.I) • (u : H) := by
      rw [← hu]; abel
    rw [hop, hc]
    module
  have hzero' : T.shift l (v - u - c • w) = T.shift l 0 := by simpa using hzero
  have hsub : v - u - c • w = 0 := T.shift_injective hl hzero'
  have hcoe : ((v : H)) - (u : H) - c • (w : H) = 0 := by
    have h2 : ((v - u - c • w : T.domain) : H) = ((0 : T.domain) : H) := by rw [hsub]
    simpa using h2
  have : ((v : H)) - (u : H) = c • (w : H) := by
    have := hcoe
    linear_combination (norm := module) this
  simpa [hudef, hvdef, hwdef, hc] using this
