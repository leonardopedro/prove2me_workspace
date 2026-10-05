-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.indicatorConstLp_eq_smul
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.indicatorConstLp_eq_smul {E : Set X} (hE : MeasurableSet E) (hμE : μ E ≠ ⊤) (c : ℂ) :
    indicatorConstLp 2 hE hμE c = c • indSet μ hE := by sorry
