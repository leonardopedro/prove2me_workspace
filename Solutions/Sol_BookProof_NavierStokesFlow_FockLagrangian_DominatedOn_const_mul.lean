-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.const_mul
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_const
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_mul
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution {μ : Measure X} {g h : X → ℝ} (r : ℝ) (d : DominatedOn μ g h) :
    DominatedOn μ g (fun x => r * h x) := (DominatedOn.const μ g r).mul d
