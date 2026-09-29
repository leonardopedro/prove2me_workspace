-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.IsShiftInvert.inner_nonneg
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_shift_apply
open BookProof.HashimotoShiftInvert
open BookProof.HashimotoShiftInvert.IsShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) (u : F) :
    0 ≤ (inner ℂ u (R u) : ℂ).re := by

  have hu : A ⟨R u, h.mem u⟩ + (γ : ℂ) • R u = u := h.shift_apply u
  have key : ∀ (y : F) (hy : y ∈ Dom),
      (inner ℂ (A ⟨y, hy⟩ + (γ : ℂ) • y) y : ℂ).re = quadForm A ⟨y, hy⟩ + γ * ‖y‖ ^ 2 := by
    intro y hy
    have hq : (inner ℂ (A ⟨y, hy⟩) y : ℂ).re = quadForm A ⟨y, hy⟩ := by
      rw [quadForm, ← inner_conj_symm (A ⟨y, hy⟩) y, Complex.conj_re]
    rw [inner_add_left, inner_smul_left, Complex.add_re, hq, inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have hexp := key (R u) (h.mem u)
  rw [hu] at hexp
  rw [hexp]
  have := hpos ⟨R u, h.mem u⟩
  positivity
