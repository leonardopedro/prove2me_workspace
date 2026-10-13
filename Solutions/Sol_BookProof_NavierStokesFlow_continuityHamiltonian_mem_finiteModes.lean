-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.continuityHamiltonian_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_velocityOp_mem_finiteModes
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
open BookProof.ChapterContinuityUnitary BookProof.ChapterContinuityUnitaryInfinite
theorem solution (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
    continuityHamiltonian v f ∈ finiteModes :=
  /
  theorem continuityHamiltonian_mem_finiteModes (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
      continuityHamiltonian v f ∈ finiteModes := by
    have hmom : ∀ {g : L2Z}, g ∈ finiteModes → momentum g ∈ finiteModes := by
      intro g hg
      have hstep := Submodule.smul_mem finiteModes (-Complex.I / 2)
        (Submodule.sub_mem finiteModes (shiftOp_mem_finiteModes 1 hg)
          (shiftOp_mem_finiteModes (-1) hg))
      simpa [momentum] using hstep
    have h1 : momentum (velocityOp v f) ∈ finiteModes := hmom (velocityOp_mem_finiteModes v hf)
    have h2 : velocityOp v (momentum f) ∈ finiteModes := velocityOp_mem_finiteModes v (hmom hf)
