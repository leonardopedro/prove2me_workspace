-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.finiteGaugeAverage_of_isPhysicalObservable
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeCasimirAverage



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]
variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [Fintype G] [MulAction G X]

theorem BookProof.ChapterGaugeCasimirAverage.finiteGaugeAverage_of_isPhysicalObservable {f : X → ℝ}
    (hf : IsPhysicalObservable G f) :
    finiteGaugeAverage (X := X) G f = f := by sorry
