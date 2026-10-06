-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.isPhysicalObservable_of_tendsto
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeCasimirAverage

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]
variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [Fintype G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X]



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

theorem BookProof.ChapterGaugeCasimirAverage.isPhysicalObservable_of_tendsto {ι : Type*} {l : Filter ι} [l.NeBot]
    {f : ι → X → ℝ} (hf : ∀ i, IsPhysicalObservable G (f i)) {F : X → ℝ}
    (h : ∀ x, Filter.Tendsto (fun i => f i x) l (nhds (F x))) :
    IsPhysicalObservable G F := by sorry
