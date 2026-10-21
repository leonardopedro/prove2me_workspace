-- Generated from ChapterBrstUnboundedLeakage.lean — solution of BookProof.BrstUnboundedLeakage.hasDerivAt_duhamel_stone
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Theorems.Thm_BookProof_BrstUnboundedLeakage_hasDerivAt_isometry_apply
import Theorems.Thm_BookProof_BrstUnboundedLeakage_hasDerivAt_flow
import Theorems.Thm_BookProof_BrstUnboundedLeakage_flow_apply_flow
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_stoneU_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_apply_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_zero
open BookProof.BrstUnboundedLeakage



open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (B : H →L[ℂ] H) (t : ℝ) (x : H)
    (hdom : ∀ s : ℝ, flow B s x ∈ T.domain) (s : ℝ) :
    HasDerivAt (fun u : ℝ => T.stoneU (t - u) (flow B u x))
      (T.stoneU (t - s) ((-Complex.I) • (B (flow B s x) - T.op ⟨flow B s x, hdom s⟩))) s := by

  set y : H := flow B s x with hy
  have hyd : y ∈ T.domain := hdom s
  -- the local curve `k h = e^{ihT} e^{-ihB} y`
  set k : ℝ → H := fun h => T.stoneU (-h) (flow B h y) with hk
  -- piece 1: the truncated increment, transported by the (isometric) group
  have hg1 : HasDerivAt (fun h : ℝ => T.stoneU (-h) (flow B h y - y))
      ((-Complex.I) • B y) 0 := by
    refine hasDerivAt_isometry_apply (U := fun h : ℝ => T.stoneU (-h))
      (fun h z => T.norm_stoneU_apply (-h) z) (fun z => by simp) (fun z => ?_) ?_ (by simp)
    · have hcont : Continuous fun h : ℝ => T.stoneU (-h) z :=
        (T.continuous_stoneU_apply z).comp continuous_neg
      have := hcont.tendsto (0 : ℝ)
      simpa using this
    · have h0 := hasDerivAt_flow B y 0
      simpa using h0.sub_const y
  -- piece 2: the exact group applied to the (fixed) state
  have hg2 : HasDerivAt (fun h : ℝ => T.stoneU (-h) y) (Complex.I • T.op ⟨y, hyd⟩) 0 := by
    have h1 : HasDerivAt (fun r : ℝ => T.stoneU r y) ((-Complex.I) • T.op ⟨y, hyd⟩) (0 - 0) := by
      simpa using T.hasDerivAt_stoneU_zero ⟨y, hyd⟩
    have h2 := HasDerivAt.comp_const_sub (0 : ℝ) (0 : ℝ) h1
    have h3 : HasDerivAt (fun h : ℝ => T.stoneU (0 - h) y)
        (-((-Complex.I) • T.op ⟨y, hyd⟩)) 0 := h2
    have hfun : (fun h : ℝ => T.stoneU (0 - h) y) = fun h : ℝ => T.stoneU (-h) y := by
      funext h; rw [zero_sub]
    have hval : -((-Complex.I) • T.op ⟨y, hyd⟩) = Complex.I • T.op ⟨y, hyd⟩ := by
      rw [neg_smul, neg_neg]
    rw [hfun, hval] at h3
    exact h3
  have hkderiv : HasDerivAt k ((-Complex.I) • (B y - T.op ⟨y, hyd⟩)) 0 := by
    have hsum : HasDerivAt (fun h : ℝ => T.stoneU (-h) (flow B h y - y) + T.stoneU (-h) y)
        ((-Complex.I) • B y + Complex.I • T.op ⟨y, hyd⟩) 0 := hg1.add hg2
    have hfun : ∀ h : ℝ, T.stoneU (-h) (flow B h y - y) + T.stoneU (-h) y = k h := by
      intro h
      rw [hk]
      simp [map_sub]
    have hval : (-Complex.I) • B y + Complex.I • T.op ⟨y, hyd⟩
        = (-Complex.I) • (B y - T.op ⟨y, hyd⟩) := by
      simp [sub_eq_add_neg]
    rw [hval] at hsum
    exact hsum.congr_of_eventuallyEq (Filter.Eventually.of_forall fun h => (hfun h).symm)
  -- transport: the global curve is `e^{-i(t-s)T}` applied to the local one, shifted
  have hk0 : HasDerivAt k ((-Complex.I) • (B y - T.op ⟨y, hyd⟩)) (s - s) := by
    simpa using hkderiv
  have hshift : HasDerivAt (fun u : ℝ => k (u - s)) ((-Complex.I) • (B y - T.op ⟨y, hyd⟩)) s :=
    HasDerivAt.comp_sub_const s s hk0
  have hcomp := ((T.stoneU (t - s)).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt s hshift
  have hfun : (fun u : ℝ => T.stoneU (t - s) (k (u - s)))
      = fun u : ℝ => T.stoneU (t - u) (flow B u x) := by
    funext u
    change T.stoneU (t - s) (T.stoneU (-(u - s)) (flow B (u - s) y)) = _
    rw [T.stoneU_apply_stoneU, hy, flow_apply_flow]
    have e1 : (t - s) + -(u - s) = t - u := by ring
    have e2 : (u - s) + s = u := by ring
    rw [e1, e2]
  have hcomp' : HasDerivAt (fun u : ℝ => T.stoneU (t - s) (k (u - s)))
      (T.stoneU (t - s) ((-Complex.I) • (B y - T.op ⟨y, hyd⟩))) s := by
    simpa [Function.comp_def] using hcomp
  rw [hfun] at hcomp'
  exact hcomp'
