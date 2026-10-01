-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.tendsto_eLpNorm_indicator_compl
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa


theorem BookProof.NavierStokesFlow.FockContinuum.tendsto_eLpNorm_indicator_compl (μ : Measure X) {g : X → ℝ} (hg : Measurable g)
    (f : Lp ℂ 2 μ) :
    Filter.Tendsto
      (fun n : ℕ => eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator ((f : X → ℂ))) 2 μ)
      Filter.atTop (nhds 0) := by sorry
