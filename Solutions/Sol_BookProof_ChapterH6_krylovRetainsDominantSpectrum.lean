-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.krylovRetainsDominantSpectrum
import Mathlib
import Definitions.Def_ChapterH6
import Theorems.Thm_BookProof_ChapterH6_krylov_rayleigh_transfer
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) (lam : ℂ) (y : F) (hy : ‖y‖ = 1)
    (heig : compress V X y = lam • y) :
    lam = inner ℂ (V y) (X (V y)) ∧ ‖lam‖ ≤ ‖X‖ := by

  have hyy : (inner ℂ y y : ℂ) = 1 := by
    rw [inner_self_eq_norm_sq_to_K, hy]
    norm_num
  have hval : (inner ℂ y (compress V X y) : ℂ) = lam := by
    rw [heig, inner_smul_right, hyy, mul_one]
  have hlam : lam = inner ℂ (V y) (X (V y)) := by
    rw [← hval, krylov_rayleigh_transfer]
  refine ⟨hlam, ?_⟩
  have hVy : ‖V y‖ = 1 := by rw [hViso, hy]
  have hcs : ‖(inner ℂ (V y) (X (V y)) : ℂ)‖ ≤ ‖V y‖ * ‖X (V y)‖ :=
    norm_inner_le_norm _ _
  have hXb : ‖X (V y)‖ ≤ ‖X‖ := by
    have := X.le_opNorm (V y)
    rwa [hVy, mul_one] at this
  rw [hlam]
  calc ‖(inner ℂ (V y) (X (V y)) : ℂ)‖ ≤ ‖V y‖ * ‖X (V y)‖ := hcs
    _ = ‖X (V y)‖ := by rw [hVy, one_mul]
    _ ≤ ‖X‖ := hXb
