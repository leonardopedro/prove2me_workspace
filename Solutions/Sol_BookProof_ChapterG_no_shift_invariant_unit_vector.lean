-- Generated from ChapterG.lean — solution of BookProof.ChapterG.no_shift_invariant_unit_vector
import Mathlib
import Definitions.Def_ChapterG
import Theorems.Thm_BookProof_ChapterG_shift_invariant_l2_eq_zero
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ Ψ : lp (fun _ : ℤ => ℂ) 2, ‖Ψ‖ = 1 ∧ ∀ k, Ψ (k + 1) = Ψ k := by

  rintro ⟨Ψ, hnorm, hinv⟩
  have h0 := shift_invariant_l2_eq_zero Ψ hinv
  rw [h0] at hnorm
  simp at hnorm
