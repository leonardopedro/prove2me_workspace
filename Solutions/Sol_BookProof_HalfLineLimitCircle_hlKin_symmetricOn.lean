-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlKin_symmetricOn
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_hlKin_coeFn
import Theorems.Thm_BookProof_HalfLineLimitCircle_integral_deriv2_mul
import Theorems.Thm_BookProof_HalfLineLimitCircle_inner_eq_integral
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn hlCore hlKin := by

  intro x y
  obtain ⟨f, rfl⟩ := hlEquiv.surjective x
  obtain ⟨g, rfl⟩ := hlEquiv.surjective y
  simp only [hlEquiv_coe]
  rw [inner_eq_integral (hlKin_coeFn f) (testIncl_coeFn g),
    inner_eq_integral (testIncl_coeFn f) (hlKin_coeFn g)]
  have hibp := integral_deriv2_mul (f : ℝ → ℂ) f.2 (g : ℝ → ℂ) (contDiff_of_mem_testSpace g.2)
  simp only [map_neg, neg_mul, mul_neg, integral_neg]
  rw [hibp]
