-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.covariant_unitary_is_induced
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.covariant_unitary_is_induced {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V) :
    QuasiInvariant μ G ∧
      ∃ u : G → X → ℂ, (∀ g x, ‖u g x‖ = 1) ∧ (∀ g, Measurable (u g)) ∧
        ∀ (g : G) (f : Lp ℂ 2 μ), ((V g f : Lp ℂ 2 μ) : X → ℂ) =ᵐ[μ]
          fun x => u g x * (sqrtDens μ g x : ℂ) * (f : X → ℂ) (g⁻¹ • x) := by sorry
