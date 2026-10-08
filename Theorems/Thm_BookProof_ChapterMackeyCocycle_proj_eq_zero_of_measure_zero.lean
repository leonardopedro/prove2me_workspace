-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.proj_eq_zero_of_measure_zero
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyCocycle


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


theorem BookProof.ChapterMackeyCocycle.proj_eq_zero_of_measure_zero (μ : Measure X) {E : Set X} (hE : MeasurableSet E)
    (h0 : μ E = 0) (f : Lp ℂ 2 μ) : proj μ hE f = 0 := by sorry
