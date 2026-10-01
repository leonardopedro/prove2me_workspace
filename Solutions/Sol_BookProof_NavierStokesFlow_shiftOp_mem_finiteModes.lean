-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.shiftOp_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_mem_finiteModes
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
pa [hgdef, Function.mem_support] using one_div_ne_zero hkC
  exact (Set.infinite_univ.diff (Set.finite_singleton (0 : ℤ))) (hg.subset hsub)

/-- The lattice translation prese :=
  rves the finite-mode domain. -/
  theorem shiftOp_mem_finiteModes (m : ℤ) {f : L2Z} (hf : f ∈ finiteModes) :
      shiftOp m f ∈ finiteModes := by
    rw [mem_finiteModes] at hf ⊢
    refine Set.F
