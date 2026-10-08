-- Generated from ChapterAbelianAtomicCondensation.lean — solution of BookProof.ChapterAbelianAtomicCondensation.commutes_atomProj_iff
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
import Theorems.Thm_BookProof_ChapterAbelianAtomicCondensation_atomProj_apply
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_comm
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_coordUnit_apply
import Definitions.Def_ChapterAtomicDiagonalModel
open BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterAbelianAtomicCondensation



open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable

set_option maxHeartbeats 1000000 in
theorem solution (T : Ell2C →L[ℂ] Ell2C) :
    (∀ i : ℕ, T.comp (atomProj i) = (atomProj i).comp T) ↔ ∃ d : EllInf, T = diagOp d := by

  constructor
  · intro hT
    set c : ℕ → ℂ := fun i => ((T (atom i) : Ell2C) : ℕ → ℂ) i with hc
    have hbdd : ∀ i, ‖c i‖ ≤ ‖T‖ := by
      intro i
      calc ‖c i‖ ≤ ‖T (atom i)‖ := lp.norm_apply_le_norm (by simp) _ i
        _ ≤ ‖T‖ * ‖atom i‖ := T.le_opNorm _
        _ = ‖T‖ := by rw [norm_atom, mul_one]
    have hmem : Memℓp c ∞ := by
      refine memℓp_infty ⟨‖T‖, ?_⟩
      rintro x ⟨i, rfl⟩
      exact hbdd i
    refine ⟨⟨c, hmem⟩, ?_⟩
    ext f i
    have hcomm := congrArg (fun S => ((S f : Ell2C) : ℕ → ℂ) i) (hT i)
    simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hcomm
    have hleft : T (atomProj i f) = (f : ℕ → ℂ) i • T (atom i) := by
      rw [atomProj_apply, map_smul]
    rw [hleft] at hcomm
    have hright : ((atomProj i (T f) : Ell2C) : ℕ → ℂ) i = ((T f : Ell2C) : ℕ → ℂ) i := by
      rw [atomProj, diagOp_coordUnit_apply]; simp
    rw [hright] at hcomm
    have hval : ((f : ℕ → ℂ) i • T (atom i) : Ell2C) i = (f : ℕ → ℂ) i * c i := rfl
    rw [hval] at hcomm
    rw [← hcomm, diagOp_apply]
    simp [mul_comm]
  · rintro ⟨d, rfl⟩
    intro i
    exact diagOp_comm d (coordUnit i)
