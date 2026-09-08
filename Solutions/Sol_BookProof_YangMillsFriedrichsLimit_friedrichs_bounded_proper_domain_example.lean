-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_proper_domain_example
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Theorems.Thm_BookProof_YangMillsFriedrichsLimit_friedrichs_bounded_nontrivial_example
import Theorems.Thm_BookProof_YangMillsFriedrichsLimit_not_mem_span_of_repr_ne_zero
import Theorems.Thm_BookProof_YangMillsFriedrichsLimit_memℓp_one_div_succ
open BookProof.YangMillsFriedrichsLimit









open BookProof.FarisLavine BookProof.YangMillsFriedrichs



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











open scoped InnerProductSpace ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (D : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ)),
      Dense (D : Set (ℓ²(ℕ, ℂ))) ∧ D ≠ ⊤ ∧
      (∀ x : D, A (x : ℓ²(ℕ, ℂ)) = D.subtype x) ∧
      IsPositiveSelfAdjointExtension D.subtype (topRestrict A) := by

  set b : HilbertBasis ℕ ℂ (ℓ²(ℕ, ℂ)) := HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ _) with hb
  set D : Submodule ℂ (ℓ²(ℕ, ℂ)) := Submodule.span ℂ (Set.range b) with hD
  have hdense : Dense (D : Set (ℓ²(ℕ, ℂ))) :=
    Submodule.dense_iff_topologicalClosure_eq_top.mpr b.dense_span
  obtain ⟨A, hagree, hext⟩ := friedrichs_bounded_nontrivial_example D hdense
  refine ⟨D, A, hdense, ?_, hagree, hext⟩
  -- properness: the harmonic vector has all coefficients non-zero
  set x : ℓ²(ℕ, ℂ) := ⟨fun n : ℕ => (1 / (n + 1) : ℂ), memℓp_one_div_succ⟩ with hx
  have hcoeff : ∀ i, b.repr x i ≠ 0 := by
    intro i
    have hxi : (b.repr x : ℕ → ℂ) i = 1 / ((i : ℂ) + 1) := rfl
    rw [hxi]
    have hne : ((i : ℂ) + 1) ≠ 0 := by
      rw [show ((i : ℂ) + 1) = (((i + 1 : ℕ) : ℂ)) by push_cast; ring]
      exact_mod_cast Nat.succ_ne_zero i
    simpa using hne
  have hnot : x ∉ D := not_mem_span_of_repr_ne_zero b x hcoeff
  intro htop
  exact hnot (by rw [htop]; trivial)
