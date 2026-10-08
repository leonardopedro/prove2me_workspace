-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.boundedEnergyCore_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum


open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]


theorem BookProof.NavierStokesFlow.FockContinuum.boundedEnergyCore_dense (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    Dense ((boundedEnergyCore μ g : Submodule ℂ (Lp ℂ 2 μ)) : Set (Lp ℂ 2 μ)) := by sorry
