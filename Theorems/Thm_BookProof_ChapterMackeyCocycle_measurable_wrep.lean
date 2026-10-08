-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.measurable_wrep
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {μ : Measure X} [IsFiniteMeasure μ]

theorem BookProof.ChapterMackeyCocycle.measurable_wrep (V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)) (g : G) :
    Measurable (wrep V g) := by sorry
