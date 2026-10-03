-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.quadForm_top_nonneg_of_dense
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

theorem BookProof.YangMillsFriedrichsLimit.quadForm_top_nonneg_of_dense {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F))
    (hpos : ∀ x : D, 0 ≤ (inner ℂ (x : F) (A (x : F)) : ℂ).re) :
    ∀ y : (⊤ : Submodule ℂ F), 0 ≤ quadForm (topRestrict A) y := by
  have hcont : Continuous fun y : F => (inner ℂ y (A y) : ℂ).re :=
    Complex.continuous_re.comp (Continuous.inner continuous_id A.continuous) := by sorry
