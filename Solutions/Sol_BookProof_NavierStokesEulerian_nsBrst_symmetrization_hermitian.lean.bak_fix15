-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.nsBrst_symmetrization_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (d : NSTruncation n) :
    (nsBrstCharge d + (nsBrstCharge d)ᴴ)ᴴ = nsBrstCharge d + (nsBrstCharge d)ᴴ := by

  rw [Matrix.conjTranspose_add, Matrix.conjTranspose_conjTranspose, add_comm]
