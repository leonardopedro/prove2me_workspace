-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.fockLagrangian_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure Ω) {p q dr : Fin 3 → Ω → ℝ}
    {cf : Ω → ℝ} (hp : ∀ i, Measurable (p i)) (hq : ∀ i, Measurable (q i))
    (hd : ∀ i, Measurable (dr i)) (hc : Measurable cf) (force : Fin 3 → ℝ) {nu : ℝ}
    (hnu : 0 ≤ nu) :
    Dense (((fockLagSymbols μ hp hq hd hc force hnu).data.D :
      Submodule ℂ (Lp ℂ 2 (fockMeasure μ))) : Set (Lp ℂ 2 (fockMeasure μ))) := (fockLagSymbols μ hp hq hd hc force hnu).core_dense
