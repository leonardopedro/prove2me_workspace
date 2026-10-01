-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.nsFlowEuclidean_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix




eorem nsFlowEuclidean_zero (psi : EuclideanSpace ℂ (Fin n)) :
    nsFlowEuclidean d 0 psi = psi := by
  simp [nsFlowEuclidean, nsFlow_zero]

theorem BookProof.NavierStokesFlow.nsFlowEuclidean_hasDerivAt (psi : EuclideanSpace ℂ (Fin n)) (t : ℝ) : := by sorry
