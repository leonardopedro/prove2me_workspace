-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.ker_casimir
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.ChapterGaugeCasimirAverage.ker_casimir (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric) :
    LinearMap.ker (casimir T) = ⨅ a, LinearMap.ker (T a) := by sorry
