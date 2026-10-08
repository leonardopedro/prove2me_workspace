-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.casimir_apply
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.ChapterGaugeCasimirAverage.casimir_apply (T : ι → V →ₗ[ℂ] V) (v : V) :
    casimir T v = ∑ a, T a (T a v) := by sorry
