-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.bookCCR_poly
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.BookBrstYangMills



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstYangMills.bookCCR_poly (μ ν : Fin 4) (a b : Fin N) :
    AfieldPoly μ a * momPoly ν b - momPoly ν b * AfieldPoly μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (FieldPoly N)) else 0 := by sorry
