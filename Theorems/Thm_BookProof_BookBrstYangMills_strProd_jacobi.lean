-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.strProd_jacobi
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.strProd_jacobi (x y z w : Fin N) :
    strProd G x y z w + strProd G y z x w + strProd G z x y w = 0 := by sorry
