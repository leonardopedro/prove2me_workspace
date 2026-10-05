-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.proj_indSet_univ
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.proj_indSet_univ (μ : Measure X) [IsFiniteMeasure μ] {E : Set X}
    (hE : MeasurableSet E) :
    proj μ hE (indSet μ (MeasurableSet.univ (α := by sorry
