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


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.continuityHamiltonian_hasZeroDeficiencyOn_finiteModes (v : LinfZ) :
    HasZeroDeficiencyOn finiteModes
      (LinearMap.codRestrict finiteModes
        ((continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).comp finiteModes.subtype)
        fun f => continuityHamiltonian_mem_finiteModes v f.2) := by sorry
