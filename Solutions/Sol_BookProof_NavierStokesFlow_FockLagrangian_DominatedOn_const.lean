-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.const
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) (g : X → ℝ) (r : ℝ) :
    DominatedOn μ g (fun _ => r) := fun _ => ⟨|r|, abs_nonneg r, Filter.Eventually.of_forall fun _ _ => le_rfl⟩
