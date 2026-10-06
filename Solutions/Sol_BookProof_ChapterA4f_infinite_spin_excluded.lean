-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.infinite_spin_excluded
import Mathlib
import Definitions.Def_ChapterA4f
import Theorems.Thm_BookProof_ChapterA4f_boostZ_scales_translation
import Theorems.Thm_BookProof_ChapterA4f_boostZ_conj_mem
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution {T : Matrix (Fin 2) (Fin 2) ℂ} (hT : T ∈ SEtwo)
    (hc : T 1 0 ≠ 0) :
    ∀ c : ℂ, c ≠ 0 → ∃ l : ℂ, l ≠ 0 ∧ boostZ l * T * boostZ l⁻¹ ∈ SEtwo ∧
      (boostZ l * T * boostZ l⁻¹) 1 0 = c := by

  intro c hc_ne
  -- Reduce to finding `l ≠ 0` with `(l⁻¹)² * (T 1 0) = c`, via `boostZ_scales_translation`.
  suffices h_exists_l : ∃ l : ℂ, l ≠ 0 ∧ (l⁻¹) ^ 2 * T 1 0 = c by
    obtain ⟨l, hl_ne, hl_eq⟩ := h_exists_l
    exact ⟨l, hl_ne, boostZ_conj_mem hl_ne hT,
      by rw [boostZ_scales_translation]; exact hl_eq⟩
  exact ⟨(T 1 0 / c) ^ (1 / 2 : ℂ), by aesop, by
    rw [inv_pow, ← Complex.cpow_nat_mul]; norm_num [hc, hc_ne]⟩
