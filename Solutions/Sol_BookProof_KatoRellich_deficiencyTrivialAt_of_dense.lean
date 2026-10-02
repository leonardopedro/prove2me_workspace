-- Generated from ChapterKatoRellichDeficiency.lean — solution of BookProof.KatoRellich.deficiencyTrivialAt_of_dense
import Mathlib
import Definitions.Def_ChapterKatoRellichDeficiency




open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (z : ℂ)
    (hd : Dense (Set.range fun x : D => T x - ((starRingEnd ℂ) z) • (x : F))) :
    DeficiencyTrivialAt D T z := by

  intro w hw
  have hclosed : IsClosed {y : F | (inner ℂ y w : ℂ) = 0} :=
    isClosed_eq (Continuous.inner continuous_id continuous_const) continuous_const
  have hsub : (Set.range fun x : D => T x - ((starRingEnd ℂ) z) • (x : F))
      ⊆ {y : F | (inner ℂ y w : ℂ) = 0} := by
    rintro _ ⟨x, rfl⟩
    simp only [Set.mem_setOf_eq, inner_sub_left, inner_smul_left, hw x, Complex.conj_conj]
    ring
  have huniv := hclosed.closure_subset_iff.mpr hsub
  rw [hd.closure_eq] at huniv
  exact inner_self_eq_zero.mp (huniv (Set.mem_univ w))
