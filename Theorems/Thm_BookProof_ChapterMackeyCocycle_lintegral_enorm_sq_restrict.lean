-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.lintegral_enorm_sq_restrict
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


theorem BookProof.ChapterMackeyCocycle.lintegral_enorm_sq_restrict (μ : Measure X) {F : Set X} (hF : MeasurableSet F)
    (u : Lp ℂ 2 μ) :
    ∫⁻ x in F, ‖(u : X → ℂ) x‖ₑ ^ 2 ∂μ = ENNReal.ofReal (‖proj μ hF u‖ ^ 2) := by sorry
