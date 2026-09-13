-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.nsFlowEuclidean_norm
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
theorem solution (t : ℝ) (psi : EuclideanSpace ℂ (Fin n)) :
    ‖nsFlowEuclidean d t psi‖ = ‖psi‖ := by

  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  simpa [nsFlowEuclidean] using nsFlow_norm_preserving d t (WithLp.ofLp psi)
