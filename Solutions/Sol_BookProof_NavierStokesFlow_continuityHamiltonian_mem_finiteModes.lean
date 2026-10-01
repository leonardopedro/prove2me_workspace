-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.continuityHamiltonian_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_shiftOp_mem_finiteModes
import Theorems.Thm_BookProof_NavierStokesFlow_velocityOp_mem_finiteModes
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
 refine hf.subset fun k hk => ?_
  simp only [Function.mem_support, velocityOp_apply] at hk
  exact fun hzero => hk (by rw [hzero, mul_zero])

/-- The continuity generator preserves the finite-mode domain. - :=
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
