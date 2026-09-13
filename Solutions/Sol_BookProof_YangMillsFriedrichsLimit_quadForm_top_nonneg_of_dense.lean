-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.quadForm_top_nonneg_of_dense
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichsLimit









open BookProof.FarisLavine BookProof.YangMillsFriedrichs



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F))
    (hpos : ∀ x : D, 0 ≤ (inner ℂ (x : F) (A (x : F)) : ℂ).re) :
    ∀ y : (⊤ : Submodule ℂ F), 0 ≤ quadForm (topRestrict A) y := by

  have hcont : Continuous fun y : F => (inner ℂ y (A y) : ℂ).re :=
    Complex.continuous_re.comp (Continuous.inner continuous_id A.continuous)
  have hclosed : IsClosed {y : F | 0 ≤ (inner ℂ y (A y) : ℂ).re} :=
    isClosed_le continuous_const hcont
  have hsub : (D : Set F) ⊆ {y : F | 0 ≤ (inner ℂ y (A y) : ℂ).re} := by
    rintro y hy
    exact hpos ⟨y, hy⟩
  have huniv : ∀ y : F, 0 ≤ (inner ℂ y (A y) : ℂ).re := by
    intro y
    have := hclosed.closure_subset_iff.mpr hsub
    have hy : y ∈ closure (D : Set F) := by rw [hdense.closure_eq]; trivial
    exact this hy
  intro y
  exact huniv (y : F)
