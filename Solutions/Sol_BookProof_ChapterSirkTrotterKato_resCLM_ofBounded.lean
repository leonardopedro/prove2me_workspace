-- Generated from ChapterSirkTrotterKatoGalerkin.lean — solution of BookProof.ChapterSirkTrotterKato.resCLM_ofBounded
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterSirkTrotterKato









noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (A : H →L[ℂ] H) (hA : IsSelfAdjoint A) (y : H) :
    (ofBounded A hA).resCLM 1 y = -(resolvent A Complex.I y) := by

  have hz : (Complex.I).im ≠ 0 := by simp
  have h := BookProof.HermiteGalerkin.sub_resolvent_apply A hA hz y
  rw [Algebra.algebraMap_eq_smul_one] at h
  simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.one_apply] at h
  set r : H := resolvent A Complex.I y with hr
  set x : H := -r with hx
  have hxmem : x ∈ (ofBounded A hA).domain := by simp [ofBounded]
  have hop : (ofBounded A hA).op ⟨x, hxmem⟩ = A x := rfl
  have hshift : (ofBounded A hA).shift 1 ⟨x, hxmem⟩ = y := by
    rw [UnboundedSelfAdjoint.shift_apply, hop]
    calc A x - ((1 : ℂ) * Complex.I) • x = Complex.I • r - A r := by
          rw [hx, map_neg]; module
      _ = y := h
  have hres := (ofBounded A hA).res_shift (l := 1) one_ne_zero ⟨x, hxmem⟩
  rw [hshift] at hres
  simpa using congrArg (fun (u : (ofBounded A hA).domain) => (u : H)) hres
