-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.momPoly_apply
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.momPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    momPoly μ a p = (-Complex.I) • (pderiv (μ, a) p) := by sorry
