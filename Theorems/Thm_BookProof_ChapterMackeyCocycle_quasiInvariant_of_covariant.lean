-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.quasiInvariant_of_covariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterMackeyQuasiInvariant
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.quasiInvariant_of_covariant {μ : Measure X} [IsFiniteMeasure μ]
    {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V) :
    QuasiInvariant μ G := by sorry
