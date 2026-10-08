-- Generated from ChapterNavierStokesFockParcels.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.volume_sum_sq_level
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian


open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

theorem BookProof.NavierStokesFlow.FockLagrangian.volume_sum_sq_level (n : ℕ) (hn : 0 < n) (a : ℝ) :
    (volume : Measure (Fin n → ℝ)) {ξ : Fin n → ℝ | (∑ i, ξ i) ^ 2 = a} = 0 := by sorry
