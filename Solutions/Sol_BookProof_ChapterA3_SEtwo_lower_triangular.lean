-- Generated from ChapterA4d.lean — solution of BookProof.ChapterA3.SEtwo_lower_triangular
import Mathlib
import Definitions.Def_ChapterA4d
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SEtwo) :
    T 0 1 = 0 ∧ T 1 1 = (T 0 0)⁻¹ ∧ Complex.normSq (T 0 0) = 1 := by

  obtain ⟨hd, hb, ha⟩ := hT
  refine ⟨hb, ?_, ha⟩
  have ha0 : T 0 0 ≠ 0 := by
    intro h; rw [h] at ha; simp at ha
  rw [Matrix.det_fin_two] at hd
  rw [hb] at hd
  field_simp at hd ⊢
  linear_combination hd
