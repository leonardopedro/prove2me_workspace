-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.tailStep_subset
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : tailStep k ⊆ tailFockSet := Set.image_mono fun _ hξ i _ => Set.mem_iUnion.2 ⟨k, hξ i (Set.mem_univ i)⟩
