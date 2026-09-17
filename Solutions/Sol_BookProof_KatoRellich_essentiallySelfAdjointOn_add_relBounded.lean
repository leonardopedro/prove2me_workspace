-- Generated from ChapterKatoRellichRelative.lean — solution of BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
import Theorems.Thm_BookProof_KatoRellich_symmetricOn_add
import Theorems.Thm_BookProof_KatoRellich_dense_range_add_relBounded
import Theorems.Thm_BookProof_FarisLavine_deficiencyTrivialAt_of_dense_range
import Theorems.Thm_BookProof_FarisLavine_dense_range_of_deficiencyTrivialAt
open BookProof.KatoRellich




open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] (H B : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (hB : SymmetricOn D B)
    {a b : ℝ} (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hrel : ∀ x : D, ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖) :
    EssentiallySelfAdjointOn D (H + B) := by

  set K : D →ₗ[ℂ] F := H + B with hK
  have hKapply : ∀ x : D, K x = H x + B x := fun x => rfl
  have hKsymm : SymmetricOn D K := symmetricOn_add hH hB
  -- `H` has trivial deficiency spaces at every non-real point
  have hHall : ∀ σ : ℂ, σ.im ≠ 0 → DeficiencyTrivialAt D H σ := by
    intro σ hσ
    refine deficiencyTrivialAt_of_dense_range H hH 1 one_ne_zero σ hσ ?_ ?_
    · have := dense_range_of_deficiencyTrivialAt H ((1 : ℝ) * Complex.I) (by simpa using hesa.2)
      simpa using this
    · simpa using hesa.1
  -- a shift large enough to make the contraction factor `< 1`
  set e : ℝ := (b + 1) / (1 - a) with hedef
  have h1a : (0 : ℝ) < 1 - a := by linarith
  have he0' : (0 : ℝ) < e := by rw [hedef]; positivity
  have he0 : e ≠ 0 := ne_of_gt he0'
  have habse : |e| = e := abs_of_pos he0'
  have hqlt : ∀ d : ℝ, e ≤ |d| → a + b / |d| < 1 := by
    intro d hd
    have hd0 : (0 : ℝ) < |d| := lt_of_lt_of_le he0' hd
    have hbe : b / |d| ≤ b / e := by
      rcases eq_or_lt_of_le hb with h | h
      · simp [← h]
      · exact div_le_div_of_nonneg_left hb he0' hd
    have hlt : b / e < 1 - a := by
      rw [hedef, div_div_eq_mul_div, div_lt_iff₀ (by positivity)]
      nlinarith
    linarith
  have hdenseH : ∀ d : ℝ, d ≠ 0 →
      Dense (Set.range fun x : D => H x - ((d : ℂ) * Complex.I) • (x : F)) := by
    intro d hd
    refine dense_range_of_deficiencyTrivialAt H ((d : ℂ) * Complex.I) (hHall _ ?_)
    simp [hd]
  have hdenseK : ∀ d : ℝ, e ≤ |d| →
      Dense (Set.range fun x : D => (H x + B x) - ((d : ℂ) * Complex.I) • (x : F)) := by
    intro d hd
    have hd0 : d ≠ 0 := by
      intro h
      rw [h] at hd
      simp at hd
      linarith
    exact dense_range_add_relBounded H B hH ha hb hd0 hrel (hqlt d hd) (hdenseH d hd0)
  have hself : e ≤ |e| := le_of_eq habse.symm
  have hneg : e ≤ |(-e)| := by rw [abs_neg]; exact hself
  have hdefK : DeficiencyTrivialAt D K ((e : ℂ) * Complex.I) := by
    refine deficiencyTrivialAt_of_dense K _ ?_
    have hconj : (starRingEnd ℂ) ((e : ℂ) * Complex.I) = ((-e : ℝ) : ℂ) * Complex.I := by
      push_cast
      simp [mul_comm]
    rw [hconj]
    simpa [hKapply] using hdenseK (-e) hneg
  have hdenseKe : Dense (Set.range fun x : D => K x - ((e : ℂ) * Complex.I) • (x : F)) := by
    simpa [hKapply] using hdenseK e hself
  exact ⟨deficiencyTrivialAt_of_dense_range K hKsymm e he0 Complex.I (by simp) hdenseKe hdefK,
    deficiencyTrivialAt_of_dense_range K hKsymm e he0 (-Complex.I) (by simp) hdenseKe hdefK⟩
