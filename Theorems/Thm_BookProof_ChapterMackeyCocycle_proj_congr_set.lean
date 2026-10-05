-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.proj_congr_set
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


theorem BookProof.ChapterMackeyCocycle.proj_congr_set (μ : Measure X) {E F : Set X} (hE : MeasurableSet E)
    (hF : MeasurableSet F) (h : E = F) (f : Lp ℂ 2 μ) : proj μ hE f = proj μ hF f := by sorry
