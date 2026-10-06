-- Generated from ChapterNavierStokesFockParcels.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.fockLagrangian_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory



open FullEsa FockContinuum

theorem BookProof.NavierStokesFlow.FockLagrangian.fockLagrangian_dense (μ : Measure Ω) {p q dr : Fin 3 → Ω → ℝ}
    {cf : Ω → ℝ} (hp : ∀ i, Measurable (p i)) (hq : ∀ i, Measurable (q i))
    (hd : ∀ i, Measurable (dr i)) (hc : Measurable cf) (force : Fin 3 → ℝ) {nu : ℝ}
    (hnu : 0 ≤ nu) :
    Dense (((fockLagSymbols μ hp hq hd hc force hnu).data.D :
      Submodule ℂ (Lp ℂ 2 (fockMeasure μ))) : Set (Lp ℂ 2 (fockMeasure μ))) := by sorry
