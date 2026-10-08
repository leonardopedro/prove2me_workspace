-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.finiteGaugeAverage_const
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]
variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [Fintype G] [MulAction G X]

theorem BookProof.ChapterGaugeCasimirAverage.finiteGaugeAverage_const (c : ℝ) :
    finiteGaugeAverage (X := X) G (fun _ => c) = fun _ => c := by sorry
