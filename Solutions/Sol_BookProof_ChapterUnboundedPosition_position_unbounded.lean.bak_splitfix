-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.position_unbounded
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_single_mem_mulDomain
import Theorems.Thm_BookProof_ChapterUnboundedPosition_mulOp_single
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ psi : mulDomain positionField,
      ‖mulOp positionField psi‖ ≤ C * ‖(psi : L2Z)‖ :=
     ‖mulOp positionField psi‖ ≤ C * ‖(psi : L2Z)‖ := by
    rintro ⟨C, hC⟩
    obtain ⟨n, hn⟩ := exists_nat_gt C
    have hmem := single_mem_mulDomain positionField (n : ℤ) (1 : ℂ)
    have h := hC ⟨lp.single 2 (n : ℤ) (1 : ℂ), hmem⟩
    rw [mulOp_single positionField (n : ℤ) (1 : ℂ)] at h
    rw [lp.norm_single (by norm_num), lp.norm_single (by norm_num)] at h
    simp only [positionField, mul_one, norm_one] at h
    simp only [Complex.norm_real, Real.norm_eq_abs] at h
    rw [abs_
