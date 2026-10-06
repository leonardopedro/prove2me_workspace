-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.nsBrst_not_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Theorems.Thm_BookProof_NavierStokesFlow_nsBrst_adjoint
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (d : NSTruncation n) (h : nsDivergence d ≠ 0) :
    (nsBrstCharge d)ᴴ ≠ nsBrstCharge d := by

  intro hEq
  apply h
  ext a b
  have := congrFun (congrFun hEq (a, 0)) (b, 1)
  rw [nsBrst_adjoint] at this
  simpa [nsBrstCharge, Matrix.kroneckerMap_apply, BookProof.GhostField.psi,
    BookProof.GhostField.psiDag] using this.symm
