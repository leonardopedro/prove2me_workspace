-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.wrep_ae
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution (V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)) (g : G) :
    wrep V g =ᵐ[μ] ((V g (indSet μ (MeasurableSet.univ (α := (Lp.aestronglyMeasurable _).ae_eq_mk.symm
