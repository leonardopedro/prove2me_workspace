-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.su2_gaussVec_value
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterA4
open BookProof.SmBrstGhost
open BookProof.BookBrstInstances

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)



open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section


theorem BookProof.BookBrstInstances.su2_gaussVec_value :
    gaussVec (su2BookAlgebra 0) 0 (0, 1) = (X (0, 2) : FieldPoly 3) := by sorry
