-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.inner_casimir
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

theorem BookProof.ChapterGaugeCasimirAverage.inner_casimir (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric) (v : V) :
    ⟪v, casimir T v⟫_ℂ = ((∑ a, ‖T a v‖ ^ 2 : ℝ) : ℂ) := by sorry
