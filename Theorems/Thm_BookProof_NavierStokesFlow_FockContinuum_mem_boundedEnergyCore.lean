-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.mem_boundedEnergyCore
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum


open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]


theorem BookProof.NavierStokesFlow.FockContinuum.mem_boundedEnergyCore {μ : Measure X} {g : X → ℝ} {f : Lp ℂ 2 μ} :
    f ∈ boundedEnergyCore μ g ↔ ∃ n : ℕ, ∀ᵐ x ∂μ, ¬ (|g x| ≤ (n : ℝ)) → (f : X → ℂ) x = 0 := by sorry
