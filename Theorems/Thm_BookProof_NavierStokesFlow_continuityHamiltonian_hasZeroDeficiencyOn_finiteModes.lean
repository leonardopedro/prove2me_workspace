-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.continuityHamiltonian_hasZeroDeficiencyOn_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}


open scoped Matrix




 have hstep := Submodule.smul_mem finiteModes (1 / 2 : ℂ) (Submodule.add_mem finiteModes h1 h2)
  simpa [continuityHamiltonian] using hstep

theorem BookProof.NavierStokesFlow.continuityHamiltonian_hasZeroDeficiencyOn_finiteModes (v : LinfZ) :
    HasZeroDeficiencyOn finiteModes
      (LinearMap.codRestrict finiteModes := by sorry
