-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.strProd_jacobi
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (x y z w : Fin N) :
    strProd G x y z w + strProd G y z x w + strProd G z x y w = 0 := by

  have h := G.jacobi x y z w
  rw [← h]
  simp only [strProd]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [G.cyclic m z w, G.cyclic m x w, G.cyclic m y w]
