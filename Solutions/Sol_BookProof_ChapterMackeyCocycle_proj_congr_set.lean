-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.proj_congr_set
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterElectroweakFieldStrength

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {E F : Set X} (hE : MeasurableSet E)
    (hF : MeasurableSet F) (h : E = F) (f : Lp ℂ 2 μ) : proj μ hE f = proj μ hF f := by

  subst h
  rfl
