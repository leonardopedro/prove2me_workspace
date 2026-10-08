-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn_of_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn_of_flow :
    HasZeroDeficiencyOn (⊤ : Submodule ℂ (EuclideanSpace ℂ (Fin n)))
      (restrictToTop (Matrix.toEuclideanLin (nsHamiltonian d))) := by sorry
