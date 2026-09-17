-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsNumberOp_posSemidef
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    (nsNumberOp A).PosSemidef := by

  refine Finset.sum_induction _ _ (fun a b ha hb => ha.add hb) Matrix.PosSemidef.zero ?_
  intro k _
  exact Matrix.posSemidef_conjTranspose_mul_self (A k)
