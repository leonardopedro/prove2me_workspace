-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.hasDerivAt_unitaryU
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_hasDerivAt_expU_apply
import Theorems.Thm_BookProof_NonnegUnitaryGroup_tendstoUniformlyOn_approxU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_apply
import Theorems.Thm_BookProof_NonnegResolvent_tendsto_yosidaAt
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) (t : ℝ) :
    HasDerivAt (fun s : ℝ => unitaryU hT hsv s h)
      ((-Complex.I) • unitaryU hT hsv t k) t := by

  have hsub : Set.Ioo (t - 1) (t + 1) ⊆ {s : ℝ | |s| ≤ |t| + 1} := by
    intro s hs
    simp only [Set.mem_setOf_eq, abs_le]
    constructor
    · linarith [neg_abs_le t, hs.1]
    · linarith [le_abs_self t, hs.2]
  have hderiv : ∀ (n : ℕ) (s : ℝ), HasDerivAt (fun r : ℝ => approxU hT n r h)
      (approxU hT n s (((-Complex.I) • yosidaAt hT n) h)) s :=
    fun n s => hasDerivAt_expU_apply (yosidaAt hT n) s h
  have huniform : TendstoUniformlyOn
      (fun (n : ℕ) (s : ℝ) => approxU hT n s (((-Complex.I) • yosidaAt hT n) h))
      (fun s : ℝ => (-Complex.I) • unitaryU hT hsv s k) atTop (Set.Ioo (t - 1) (t + 1)) := by
    rw [Metric.tendstoUniformlyOn_iff]
    intro ε hε
    have hU := (Metric.tendstoUniformlyOn_iff.1 (tendstoUniformlyOn_approxU hT hsv k (|t| + 1)))
      (ε / 2) (by linarith)
    have hy : ∀ᶠ n : ℕ in atTop, ‖k - yosidaAt hT n h‖ < ε / 2 := by
      obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp (tendsto_yosidaAt hT hsv hk) (ε / 2)
        (by linarith)
      filter_upwards [eventually_ge_atTop N] with n hn
      have := hN n hn
      rwa [dist_eq_norm, norm_sub_rev] at this
    filter_upwards [hU, hy] with n hn hn2 s hs
    have hsR : s ∈ {s : ℝ | |s| ≤ |t| + 1} := hsub hs
    have hsm : approxU hT n s (((-Complex.I) • yosidaAt hT n) h)
        = (-Complex.I) • approxU hT n s (yosidaAt hT n h) := by
      simp [map_smul]
    have hsplit : (-Complex.I) • unitaryU hT hsv s k
          - (-Complex.I) • approxU hT n s (yosidaAt hT n h)
        = (-Complex.I) • ((unitaryU hT hsv s k - approxU hT n s k)
            + approxU hT n s (k - yosidaAt hT n h)) := by
      rw [map_sub]
      module
    have hnormI : ‖(-Complex.I)‖ = 1 := by simp
    rw [dist_eq_norm, hsm, hsplit, norm_smul, hnormI, one_mul]
    have hb1 : ‖unitaryU hT hsv s k - approxU hT n s k‖ < ε / 2 := by
      have := hn s hsR
      rwa [dist_eq_norm] at this
    have hb2 : ‖approxU hT n s (k - yosidaAt hT n h)‖ < ε / 2 := by
      rw [norm_approxU_apply]
      exact hn2
    calc ‖(unitaryU hT hsv s k - approxU hT n s k) + approxU hT n s (k - yosidaAt hT n h)‖
        ≤ ‖unitaryU hT hsv s k - approxU hT n s k‖
            + ‖approxU hT n s (k - yosidaAt hT n h)‖ := norm_add_le _ _
      _ < ε := by linarith
  exact hasDerivAt_of_tendstoUniformlyOn (f := fun (n : ℕ) (s : ℝ) => approxU hT n s h)
    (f' := fun (n : ℕ) (s : ℝ) => approxU hT n s (((-Complex.I) • yosidaAt hT n) h))
    (g := fun s : ℝ => unitaryU hT hsv s h)
    (g' := fun s : ℝ => (-Complex.I) • unitaryU hT hsv s k)
    isOpen_Ioo huniform (Filter.Eventually.of_forall fun n s _ => hderiv n s)
    (fun s _ => tendsto_unitaryU hT hsv s h) (by constructor <;> linarith)
