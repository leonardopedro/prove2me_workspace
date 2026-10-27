-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.sum
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_const
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_add
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} {μ : Measure X} {g : X → ℝ} (s : Finset ι)
    {h : ι → X → ℝ} (d : ∀ i ∈ s, DominatedOn μ g (h i)) :
    DominatedOn μ g (fun x => ∑ i ∈ s, h i x) := by

  classical
  induction s using Finset.induction with
  | empty => simpa using DominatedOn.const μ g 0
  | insert i s hi ih =>
      have hd : DominatedOn μ g (h i) := d i (Finset.mem_insert_self i s)
      have hrest : DominatedOn μ g (fun x => ∑ j ∈ s, h j x) :=
        ih fun j hj => d j (Finset.mem_insert_of_mem hj)
      have := hd.add hrest
      simpa [Finset.sum_insert hi] using this
