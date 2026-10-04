-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.proj_eq_zero_of_measure_zero
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterA4
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.proj_eq_zero_of_measure_zero (μ : Measure X) {E : Set X} (hE : MeasurableSet E)
    (h0 : μ E = 0) (f : Lp ℂ 2 μ) : proj μ hE f = 0 := by sorry
