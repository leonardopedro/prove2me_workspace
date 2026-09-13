-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.nsFlowEuclidean_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite














variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (psi : EuclideanSpace ℂ (Fin n)) :
    nsFlowEuclidean d 0 psi = psi := by

  simp [nsFlowEuclidean, nsFlow_zero]
