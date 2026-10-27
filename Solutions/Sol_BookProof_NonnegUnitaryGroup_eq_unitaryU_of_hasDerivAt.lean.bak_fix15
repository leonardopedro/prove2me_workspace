-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.eq_unitaryU_of_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_mem_unitaryU
import Theorems.Thm_BookProof_NonnegUnitaryGroup_hasDerivAt_unitaryU
import Theorems.Thm_BookProof_NonnegUnitaryGroup_inner_mem_conj_eq
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {u kk : ℝ → F}
    (hmem : ∀ s : ℝ, (u s, kk s) ∈ T)
    (hu : ∀ s : ℝ, HasDerivAt u ((-Complex.I) • kk s) s) (t : ℝ) :
    u t = unitaryU hT hsv t (u 0) := by

  set w : ℝ → F := fun s => u s - unitaryU hT hsv s (u 0) with hwdef
  set kw : ℝ → F := fun s => kk s - unitaryU hT hsv s (kk 0) with hkwdef
  have hmemw : ∀ s : ℝ, (w s, kw s) ∈ T := fun s =>
    T.sub_mem (hmem s) (mem_unitaryU hT hsv (hmem 0) s)
  have hderivw : ∀ s : ℝ, HasDerivAt w ((-Complex.I) • kw s) s := by
    intro s
    have h2 := hasDerivAt_unitaryU hT hsv (hmem 0) s
    have h3 := (hu s).sub h2
    convert h3 using 1 <;>
      (first | rfl | rw [hkwdef, smul_sub])
  have hf : ∀ s : ℝ, HasDerivAt (fun r : ℝ => ‖w r‖ ^ 2) 0 s := by
    intro s
    have hin := (hderivw s).inner ℂ (hderivw s)
    have hzero : ⟪w s, (-Complex.I) • kw s⟫_ℂ + ⟪(-Complex.I) • kw s, w s⟫_ℂ = 0 := by
      have hreal := inner_mem_conj_eq hT (hmemw s)
      have hcs : (starRingEnd ℂ) ⟪kw s, w s⟫_ℂ = ⟪w s, kw s⟫_ℂ := inner_conj_symm _ _
      have hswap : ⟪kw s, w s⟫_ℂ = ⟪w s, kw s⟫_ℂ := by
        have h := congrArg (starRingEnd ℂ) hcs
        simp only [Complex.conj_conj] at h
        rw [h, hreal]
      have h1 : ⟪w s, (-Complex.I) • kw s⟫_ℂ = (-Complex.I) * ⟪w s, kw s⟫_ℂ := by
        rw [inner_smul_right]
      have h2 : ⟪(-Complex.I) • kw s, w s⟫_ℂ = Complex.I * ⟪kw s, w s⟫_ℂ := by
        rw [inner_smul_left]
        simp
      rw [h1, h2, hswap]
      ring
    rw [hzero] at hin
    have hre := Complex.reCLM.hasFDerivAt.comp_hasDerivAt s hin
    simp only [map_zero, Function.comp_def] at hre
    have hfun : (fun r : ℝ => Complex.reCLM (⟪w r, w r⟫_ℂ)) = fun r : ℝ => ‖w r‖ ^ 2 := by
      funext r
      simpa using inner_self_eq_norm_sq (𝕜 := ℂ) (w r)
    rwa [hfun] at hre
  have hconst : ‖w t‖ ^ 2 = ‖w 0‖ ^ 2 := by
    have hmvt := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le
      (f := fun r : ℝ => ‖w r‖ ^ 2) (f' := fun _ : ℝ => (0 : ℝ)) (C := 0) (s := Set.univ)
      (fun r _ => (hf r).hasDerivWithinAt) (fun r _ => by simp) convex_univ
      (Set.mem_univ 0) (Set.mem_univ t)
    have h0 : ‖‖w t‖ ^ 2 - ‖w 0‖ ^ 2‖ ≤ 0 := by simpa using hmvt
    have := norm_le_zero_iff.1 h0
    linarith [sub_eq_zero.1 this]
  have hz : unitaryU hT hsv 0 (u 0) = u 0 := by
    rw [unitaryU_zero hT hsv]
    simp
  have hw0 : w 0 = 0 := by
    calc w 0 = u 0 - unitaryU hT hsv 0 (u 0) := rfl
      _ = 0 := by rw [hz]; simp
  rw [hw0] at hconst
  have hwt : u t - unitaryU hT hsv t (u 0) = 0 := by
    have hsq : ‖w t‖ ^ 2 = 0 := by simpa using hconst
    have hnorm : ‖w t‖ = 0 := by nlinarith [norm_nonneg (w t)]
    exact norm_eq_zero.1 hnorm
  exact sub_eq_zero.1 hwt
