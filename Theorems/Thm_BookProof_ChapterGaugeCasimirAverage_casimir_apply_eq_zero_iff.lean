-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.casimir_apply_eq_zero_iff
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.ChapterGaugeCasimirAverage.casimir_apply_eq_zero_iff (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric)
    (v : V) : casimir T v = 0 ↔ ∀ a, T a v = 0 := by sorry
